require_relative 'lib/board'
require_relative 'lib/board_case'
require_relative 'lib/player'
require_relative 'lib/game'
require_relative 'lib/show'

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
