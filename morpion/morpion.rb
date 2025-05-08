class BoardCase
  attr_accessor :value, :id

  def initialize(id)
    @id = id
    @value = " "
  end
end

class Board
  attr_accessor :cases, :count_turn

  def initialize
    @cases = {}
    ("A".."C").each do |letter|
      (1..3).each do |num|
        id = "#{letter}#{num}"
        @cases[id] = BoardCase.new(id)
      end
    end
    @count_turn = 0
  end

  def play_turn(player)
    move = nil
    loop do
      puts "#{player.name}, où veux-tu jouer ? (ex: A1, B3...)"
      move = gets.chomp.upcase
      if @cases.key?(move) && @cases[move].value == " "
        @cases[move].value = player.symbol
        @count_turn += 1
        break
      else
        puts "Case invalide ou déjà occupée. Réessaie."
      end
    end
  end

  def victory?
    win_combos = [
      %w[A1 A2 A3], %w[B1 B2 B3], %w[C1 C2 C3], # lignes
      %w[A1 B1 C1], %w[A2 B2 C2], %w[A3 B3 C3], # colonnes
      %w[A1 B2 C3], %w[A3 B2 C1]               # diagonales
    ]
    win_combos.each do |combo|
      values = combo.map { |id| @cases[id].value }
      return true if values.uniq == ["X"] || values.uniq == ["O"]
    end
    return "draw" if @count_turn >= 9
    false
  end
end

class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

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

class Show
  def show_board(board)
    puts "\n   1   2   3"
    ["A", "B", "C"].each do |row|
      print "#{row} "
      (1..3).each do |col|
        print " #{board.cases["#{row}#{col}"].value} "
        print "|" unless col == 3
      end
      puts "\n  ---+---+---" unless row == "C"
    end
    puts
  end
end

class Application
  def perform
    game = Game.new
    loop do
      game.turn while game.status == "on going"
      puts "Voulez-vous rejouer ? (o/n)"
      answer = gets.chomp.downcase
      break unless answer == "o"
      game.new_round
    end
    puts "Merci d'avoir joué !"
  end
end

Application.new.perform
