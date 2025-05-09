class Game
  attr_reader :board, :players, :current_player

  def initialize(player1, player2)
    @board = Board.new
    @players = [player1, player2]
    @current_player = @players.sample  # qui commence
  end

  def switch_player
    @current_player = (@current_player == @players[0] ? @players[1] : @players[0])
  end

  def play
    until @board.full? || @board.winner?(@current_player.symbol)
      Show.display_board(@board)
      Show.prompt_move(@current_player)

      move = gets.chomp.upcase
      cell = @board.cell(move)
      if cell && !cell.occupied?
        cell.value = @current_player.symbol
      else
        Show.invalid_move
        next
      end

      if @board.winner?(@current_player.symbol)
        Show.display_board(@board)
        Show.game_won(@current_player)
        return
      end

      switch_player
    end

    Show.display_board(@board)
    Show.game_draw
  end
end
