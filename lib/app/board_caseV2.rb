# Cette classe représente une case du plateau de jeu
class BoardCase
  attr_accessor :value, :position

  def initialize(position)
    # Au début, la case est vide
    @value = " "
    # Position de la case (ex: "A1", "B2", etc.)
    @position = position
  end

  # Retourne la valeur colorée en fonction du symbole
  def colored_value
    case @value
    when "X"
      @value.red.bold
    when "O"
      @value.blue.bold
    else
      @value
    end
  end
end