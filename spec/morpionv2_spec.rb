# spec/morpion_spec.rb
require_relative '../lib/app/board_caseV2'
require_relative '../lib/app/boardV2'
require_relative'../lib/app/playerV2'
require_relative '../lib/app/showV2'
require_relative '../lib/app/gameV2'
require_relative '../lib/app/applicationV2'
require_relative '../lib/app/stringer'

# Pour exécuter ces tests, vous aurez besoin d'installer la gem rspec :
# gem install rspec
# Puis lancez les tests avec : rspec spec/morpion_spec.rb

require 'stringio'

# Helper pour capturer la sortie standard et simuler l'entrée utilisateur
def capture_io(input_strings = [])
  input = StringIO.new(input_strings.join("\n"))
  output = StringIO.new
  original_stdin, original_stdout = $stdin, $stdout
  $stdin, $stdout = input, output
  yield
  return output.string
ensure
  $stdin, $stdout = original_stdin, original_stdout
end

# Si vous utilisez la version améliorée avec colorize
# Nous devons simuler les méthodes de colorize pour éviter les erreurs dans les tests
unless String.method_defined?(:red)
  class String
    %i[red green blue yellow cyan bold].each do |color|
      define_method(color) { self }
    end
    
    def colorize(_)
      self
    end
  end
end

RSpec.describe "Jeu de Morpion" do
  describe BoardCase do
    let(:board_case) { BoardCase.new("A1") }
    
    it "est initialisé avec une valeur vide" do
      expect(board_case.value).to eq(" ")
    end
    
    it "stocke correctement sa position" do
      expect(board_case.position).to eq("A1")
    end
    
    if BoardCase.method_defined?(:colored_value)
      it "retourne une valeur colorée selon le symbole" do
        # Test pour la méthode colored_value (si elle existe)
        board_case.value = "X"
        expect(board_case.colored_value).to include("X")
        board_case.value = "O"
        expect(board_case.colored_value).to include("O")
      end
    end
  end
  
  describe Board do
    let(:board) { Board.new }
    
    it "initialise 9 cases dans une hash" do
      expect(board.board_cases.size).to eq(9)
      expect(board.board_cases["A1"]).to be_a(BoardCase)
      expect(board.board_cases["C3"]).to be_a(BoardCase)
    end
    
    it "vérifie si un mouvement est valide" do
      expect(board.valid_move?("A1")).to be true
      expect(board.valid_move?("D4")).to be false
      
      # Case déjà remplie
      board.board_cases["A1"].value = "X"
      expect(board.valid_move?("A1")).to be false
    end
    
    it "place un symbole sur une case valide" do
      board.place_symbol("B2", "X")
      expect(board.board_cases["B2"].value).to eq("X")
    end
    
    it "n'affecte pas une case déjà occupée" do
      board.board_cases["C3"].value = "O"
      board.place_symbol("C3", "X")
      expect(board.board_cases["C3"].value).to eq("O")
    end
    
    it "détecte quand le plateau est plein" do
      expect(board.full?).to be false
      
      # Remplir le plateau
      board.board_cases.each_key do |position|
        board.board_cases[position].value = "X"
      end
      
      expect(board.full?).to be true
    end
    
    context "détection des victoires" do
      it "détecte une victoire horizontale" do
        board.board_cases["A1"].value = "X"
        board.board_cases["A2"].value = "X"
        board.board_cases["A3"].value = "X"
        
        expect(board.victory?).to eq("X")
      end
      
      it "détecte une victoire verticale" do
        board.board_cases["A1"].value = "O"
        board.board_cases["B1"].value = "O"
        board.board_cases["C1"].value = "O"
        
        expect(board.victory?).to eq("O")
      end
      
      it "détecte une victoire diagonale (haut gauche à bas droite)" do
        board.board_cases["A1"].value = "X"
        board.board_cases["B2"].value = "X"
        board.board_cases["C3"].value = "X"
        
        expect(board.victory?).to eq("X")
      end
      
      it "détecte une victoire diagonale (haut droite à bas gauche)" do
        board.board_cases["A3"].value = "O"
        board.board_cases["B2"].value = "O"
        board.board_cases["C1"].value = "O"
        
        expect(board.victory?).to eq("O")
      end
      
      it "ne détecte pas de victoire s'il n'y en a pas" do
        board.board_cases["A1"].value = "X"
        board.board_cases["A2"].value = "O"
        board.board_cases["A3"].value = "X"
        
        expect(board.victory?).to be_nil
      end
    end
  end
  
  describe Player do
    let(:player) { Player.new("Alice", "X") }
    
    it "est initialisé avec un nom et un symbole" do
      expect(player.name).to eq("Alice")
      expect(player.symbol).to eq("X")
    end
    
    if Player.method_defined?(:score)
      it "commence avec un score de 0" do
        expect(player.score).to eq(0)
      end
      
      it "peut incrémenter son score" do
        player.increment_score
        expect(player.score).to eq(1)
      end
    end
    
    if Player.method_defined?(:colored_name)
      it "retourne un nom coloré selon le symbole" do
        expect(player.colored_name).to include("Alice")
      end
    end
  end
  
  describe Show do
    let(:show) { Show.new }
    let(:board) { Board.new }
    
    before do
      # Configurer quelques cases pour l'affichage
      board.board_cases["A1"].value = "X"
      board.board_cases["B2"].value = "O"
    end
    
    it "affiche le plateau de jeu" do
      output = capture_io do
        show.display_board(board)
      end
      
      expect(output).to include("A │ X")
      expect(output).to include("B │")
      expect(output).to include("│ O │")
    end
    
    it "affiche un message de bienvenue" do
      output = capture_io do
        show.display_welcome
      end
      
      expect(output).to include("BIENVENUE")
    end
    
    it "affiche un message de victoire" do
      output = capture_io do
        show.display_victory("Alice", "X")
      end
      
      expect(output).to include("Alice")
      expect(output).to include("gagné")
    end
    
    it "affiche un message de match nul" do
      output = capture_io do
        show.display_draw
      end
      
      expect(output).to include("Match nul")
    end
    
    if Show.method_defined?(:display_scores)
      it "affiche les scores des joueurs" do
        players = [
          Player.new("Alice", "X"),
          Player.new("Bob", "O")
        ]
        players[0].instance_variable_set(:@score, 2)
        players[1].instance_variable_set(:@score, 1)
        
        output = capture_io do
          show.display_scores(players)
        end
        
        expect(output).to include("Alice")
        expect(output).to include("Bob")
        expect(output).to include("2")
        expect(output).to include("1")
      end
    end
  end
  
  describe Game do
    let(:game) { Game.new("Alice", "Bob") }
    
    it "initialise correctement les joueurs" do
      expect(game.players.size).to eq(2)
      expect(game.players[0].name).to eq("Alice")
      expect(game.players[1].name).to eq("Bob")
      expect(game.players[0].symbol).to eq("X")
      expect(game.players[1].symbol).to eq("O")
    end
    
    it "crée un nouveau plateau" do
      expect(game.board).to be_an_instance_of(Board)
    end
    
    it "définit le joueur actuel" do
      expect(game.current_player).to eq(game.players[0])
    end
    
    it "change de joueur correctement" do
      first_player = game.current_player
      game.switch_player
      expect(game.current_player).not_to eq(first_player)
      expect(game.current_player).to eq(game.players[1])
    end
    
    it "détecte quand la partie est terminée avec un gagnant" do
      # Simuler une victoire horizontale pour le joueur 1
      game.board.board_cases["A1"].value = "X"
      game.board.board_cases["A2"].value = "X"
      game.board.board_cases["A3"].value = "X"
      
      # On ne teste pas la méthode play_turn car elle utilise gets
      # Mais on peut tester is_game_over?
      expect(game.is_game_over?).to be true
    end
    
    it "détecte quand la partie est terminée par un match nul" do
      # Simuler un plateau plein sans victoire
      game.board.board_cases["A1"].value = "X"
      game.board.board_cases["A2"].value = "O"
      game.board.board_cases["A3"].value = "X"
      game.board.board_cases["B1"].value = "X"
      game.board.board_cases["B2"].value = "O"
      game.board.board_cases["B3"].value = "X"
      game.board.board_cases["C1"].value = "O"
      game.board.board_cases["C2"].value = "X"
      game.board.board_cases["C3"].value = "O"
      
      expect(game.is_game_over?).to be true
    end
  end
  
  describe Application do
    let(:app) { Application.new }
    
    # Ces tests sont plus délicats car ils nécessitent beaucoup d'E/S simulées
    # Nous allons tester superficiellement
    
    it "a une instance de Show" do
      expect(app.instance_variable_get(:@show)).to be_an_instance_of(Show)
    end
    
    if Application.instance_method(:initialize).arity == 0
      it "initialise un tableau de joueurs vide dans la version améliorée" do
        # Uniquement pour la version améliorée
        if Application.instance_method(:initialize).source_location[0].include?("enhanced")
          expect(app.instance_variable_get(:@players)).to eq([])
        end
      end
    end
  end
  
  # Test d'intégration simple
  describe "Intégration" do
    it "joue correctement un tour" do
      game = Game.new("Alice", "Bob")
      
      # Simuler une saisie utilisateur pour jouer un tour
      allow_any_instance_of(Kernel).to receive(:gets).and_return("A1")
      
      output = capture_io do
        game.play_turn
      end
      
      expect(game.board.board_cases["A1"].value).to eq("X")
      expect(output).to include("Alice")
    end
  end
end
