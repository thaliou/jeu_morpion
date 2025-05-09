class Application
  SYMBOLS = %w[X O]

  def initialize
    @player1 = create_player(1, SYMBOLS[0])
    @player2 = create_player(2, SYMBOLS[1])
  end

  def perform
    loop do
      Game.new(@player1, @player2).play

      Show.ask_replay
      answer = gets.chomp.strip.downcase
      break if answer == "n"
    end
    puts "Merci d'avoir joué ! 👋"
  end

  private

  def create_player(num, symbol)
    print "Prénom du joueur #{num} (symbole #{symbol}) : "
    name = gets.chomp.strip
    Player.new(name.empty? ? "Joueur#{num}" : name, symbol)
  end
end
