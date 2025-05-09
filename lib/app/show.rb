class Show
  def self.display_board(board)
    puts "\n   1   2   3"
    %w[A B C].each do |row|
      line = (1..3).map { |col| board.cell("#{row}#{col}").value }
      puts "#{row}  #{line.join(' | ')}"
      puts "  -----------" unless row == "C"
    end
    puts
  end

  def self.prompt_move(player)
    print "#{player.name} (#{player.symbol}), indique une case (ex. B2) : "
  end

  def self.invalid_move
    puts "Coup invalide ! Réessaie."
  end

  def self.game_won(player)
    puts "Bravo #{player.name} ! Tu as gagné 🚀"
  end

  def self.game_draw
    puts "Match nul ! Personne ne gagne 😇"
  end

  def self.ask_replay
    print "Voulez-vous rejouer ? (O/n) : "
  end
end
