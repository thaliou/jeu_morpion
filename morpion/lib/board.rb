require_relative 'board_case'

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
      %w[A1 A2 A3], %w[B1 B2 B3], %w[C1 C2 C3],
      %w[A1 B1 C1], %w[A2 B2 C2], %w[A3 B3 C3],
      %w[A1 B2 C3], %w[A3 B2 C1]
    ]
    win_combos.each do |combo|
      values = combo.map { |id| @cases[id].value }
      return true if values.uniq == ["X"] || values.uniq == ["O"]
    end
    return "draw" if @count_turn >= 9
    false
  end
end
