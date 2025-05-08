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
