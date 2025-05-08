require_relative 'player'
require_relative 'board'
require_relative 'show'

class Game
  attr_accessor :current_player, :status, :board, :players, :round

  def initialize
    puts "Nom du joueur 1 (X) :"
    name1 = gets.chomp
    puts "Nom du joueur 2 (O) :"
    name2 = gets.chomp

    @players = [Player.new(name1, "X"), Player.new(name2, "O")]
    @board = Board.new
    @current_player = @players[0]
    @status = "on going"
    @round = 1
  end

  def turn
    Show.new.show_board(@board)
    @board.play_turn(@current_player)
    result = @board.victory?
    if result == true
      @status = @current_player
      game_end
    elsif result == "draw"
      @status = "draw"
      game_end
    else
      switch_player
    end
  end

  def switch_player
    @current_player = @players.rotate!.first
  end

  def new_round
    @board = Board.new
    @status = "on going"
    @round += 1
  end

  def game_end
    Show.new.show_board(@board)
    if @status == "draw"
      puts "Match nul !"
    else
      puts "Bravo #{@current_player.name}, tu as gagné !"
    end
  end
end
