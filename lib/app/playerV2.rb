# Cette classe représente un joueur
class Player
  attr_reader :name, :symbol
  attr_accessor :score

  def initialize(name, symbol)
    @name = name
    @symbol = symbol # "X" ou "O"
    @score = 0  # Initialisation du score à 0
  end

  # Méthode pour augmenter le score après une victoire
  def increment_score
    @score += 1
  end

  # Méthode pour obtenir le nom coloré du joueur
  def colored_name
    @symbol == "X" ? @name.red.bold : @name.blue.bold
  end
end
