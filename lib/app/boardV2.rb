# Cette classe représente le plateau de jeu
class Board
  attr_accessor :board_cases

  def initialize
    # Créer les 9 cases du plateau
    @board_cases = {}
    ["A", "B", "C"].each do |letter|
      [1, 2, 3].each do |number|
        position = "#{letter}#{number}"
        @board_cases[position] = BoardCase.new(position)
      end
    end
  end

  # Vérifie si la case est valide et disponible
  def valid_move?(position)
    return false unless @board_cases.key?(position)
    @board_cases[position].value == " "
  end

  # Place un symbole sur une case
  def place_symbol(position, symbol)
    @board_cases[position].value = symbol if valid_move?(position)
  end

  # Vérifie si le plateau est plein
  def full?
    @board_cases.values.none? { |case_obj| case_obj.value == " " }
  end

  # Vérifie si un joueur a gagné
  def victory?
    # Lignes horizontales
    ["A", "B", "C"].each do |letter|
      if @board_cases["#{letter}1"].value != " " &&
         @board_cases["#{letter}1"].value == @board_cases["#{letter}2"].value &&
         @board_cases["#{letter}2"].value == @board_cases["#{letter}3"].value
        return @board_cases["#{letter}1"].value
      end
    end

    # Colonnes verticales
    [1, 2, 3].each do |number|
      if @board_cases["A#{number}"].value != " " &&
         @board_cases["A#{number}"].value == @board_cases["B#{number}"].value &&
         @board_cases["B#{number}"].value == @board_cases["C#{number}"].value
        return @board_cases["A#{number}"].value
      end
    end

    # Diagonales
    if @board_cases["A1"].value != " " &&
       @board_cases["A1"].value == @board_cases["B2"].value &&
       @board_cases["B2"].value == @board_cases["C3"].value
      return @board_cases["A1"].value
    end

    if @board_cases["A3"].value != " " &&
       @board_cases["A3"].value == @board_cases["B2"].value &&
       @board_cases["B2"].value == @board_cases["C1"].value
      return @board_cases["A3"].value
    end

    # Pas de victoire
    return nil
  end
end
