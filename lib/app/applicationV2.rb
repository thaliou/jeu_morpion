# Cette classe gère l'exécution du programme
class Application
  def initialize
    @show = Show.new
    @players = []  # Pour stocker les joueurs entre les parties
  end

  def run
    @show.display_welcome
    
    # Demander les noms des joueurs une seule fois
    puts "Entrez le nom du premier joueur:".cyan
    player1_name = gets.chomp
    
    puts "Entrez le nom du deuxième joueur:".cyan
    player2_name = gets.chomp
    
    # Boucle principale du jeu
    loop do
      # Créer une nouvelle partie en réutilisant les mêmes joueurs
      if @players.empty?
        game = Game.new(player1_name, player2_name)
        @players = game.players  # Sauvegarder les références aux joueurs
      else
        # Créer une nouvelle partie avec les joueurs existants
        game = Game.new(@players[0].name, @players[1].name)
        # Conserver les scores
        game.players[0].score = @players[0].score
        game.players[1].score = @players[1].score
        @players = game.players  # Mettre à jour les références
      end
      
      # Afficher les scores avant de commencer
      @show.display_scores(@players)
      
      # Boucle de jeu
      loop do
        game.play_turn
        break if game.is_game_over?
        game.switch_player
      end
      
      # Demander si on veut rejouer
      response = @show.ask_new_game
      break if response != "O"
    end
    
    # Afficher les scores finaux
    puts "\n🏆 SCORES FINAUX 🏆".green.bold
    @show.display_scores(@players)
    puts "Merci d'avoir joué!".green.bold
  end
end
