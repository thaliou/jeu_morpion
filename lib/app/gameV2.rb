# Cette classe gère la logique du jeu
class Game
  attr_accessor :players, :board, :current_player, :show

  def initialize(player1_name, player2_name)
    # Création des joueurs
    @players = [
      Player.new(player1_name, "X"),
      Player.new(player2_name, "O")
    ]
    
    # Création du plateau de jeu
    @board = Board.new
    
    # Le joueur 1 commence
    @current_player = @players[0]
    
    # Création de l'affichage
    @show = Show.new
  end

  def switch_player
    @current_player = (@current_player == @players[0]) ? @players[1] : @players[0]
  end

  def play_turn
    @show.display_board(@board)
    
    position = nil
    loop do
      puts "#{@current_player.colored_name}, c'est à vous de jouer (ex: A1, B2, C3):"
      position = gets.chomp.upcase
      break if @board.valid_move?(position)
      puts "Mouvement invalide. Réessayez.".red
    end
    
    @board.place_symbol(position, @current_player.symbol)
  end

  def is_game_over?
    # Vérifier s'il y a un gagnant
    winner_symbol = @board.victory?
    if winner_symbol
      winner = @players.find { |player| player.symbol == winner_symbol }
      winner.increment_score  # Incrémenter le score du gagnant
      @show.display_board(@board)
      @show.display_victory(winner.name, winner.symbol)
      @show.display_scores(@players)
      return true
    end
    
    # Vérifier si le plateau est plein (match nul)
    if @board.full?
      @show.display_board(@board)
      @show.display_draw
      @show.display_scores(@players)
      return true
    end
    
    # La partie continue
    return false
  end
end
