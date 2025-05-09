# Cette classe gère l'affichage du jeu
class Show
  def display_board(board)
    system("clear") || system("cls") # Efface l'écran
    
    puts "    1   2   3  ".yellow
    puts "  ┌───┬───┬───┐".yellow
    puts "A │ #{board.board_cases["A1"].colored_value} │ #{board.board_cases["A2"].colored_value} │ #{board.board_cases["A3"].colored_value} │".yellow
    puts "  ├───┼───┼───┤".yellow
    puts "B │ #{board.board_cases["B1"].colored_value} │ #{board.board_cases["B2"].colored_value} │ #{board.board_cases["B3"].colored_value} │".yellow
    puts "  ├───┼───┼───┤".yellow
    puts "C │ #{board.board_cases["C1"].colored_value} │ #{board.board_cases["C2"].colored_value} │ #{board.board_cases["C3"].colored_value} │".yellow
    puts "  └───┴───┴───┘".yellow
  end

  def display_welcome
    puts "╔═════════════════════════════════════╗".green
    puts "║       BIENVENUE AU JEU MORPION      ║".green.bold
    puts "╚═════════════════════════════════════╝".green
  end

  def display_victory(player_name, symbol)
    color = symbol == "X" ? :red : :blue
    puts "🎮 #{player_name} a gagné la partie! 🎮".colorize(color).bold
  end

  def display_draw
    puts "🤝 Match nul! Le plateau est rempli. 🤝".yellow.bold
  end

  def ask_new_game
    puts "Voulez-vous jouer une nouvelle partie? (O/N)".cyan
    gets.chomp.upcase
  end

  def display_scores(players)
    puts "\n═════════ SCORES ═════════".green.bold
    players.each do |player|
      puts "#{player.colored_name}: #{player.score} #{'victoire'.pluralize(player.score)}"
    end
    puts "═════════════════════════".green.bold
    puts ""
  end
end