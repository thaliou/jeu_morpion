class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name   = name
    @symbol = symbol  # "X" ou "O"
  end
end
