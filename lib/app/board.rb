class Board
  POSITIONS = %w[A1 A2 A3 B1 B2 B3 C1 C2 C3]

  attr_reader :cells

  def initialize
    @cells = POSITIONS.map { |lbl| BoardCase.new(lbl) }
  end

  # Récupérer une case par son label
  def cell(label)
    @cells.find { |c| c.label == label.upcase }
  end

  # Afficher le plateau "brut"
  def render
    rows = %w[A B C].map do |row|
      cols = (1..3).map { |col| cell("#{row}#{col}").value }
      cols.join(" | ")
    end
    rows.join("\n---------\n")
  end

  # Vérifier si plein
  def full?
    @cells.all?(&:occupied?)
  end

  # Vériner les lignes gagnantes
  WIN_LINES = [
    %w[A1 A2 A3], %w[B1 B2 B3], %w[C1 C2 C3],
    %w[A1 B1 C1], %w[A2 B2 C2], %w[A3 B3 C3],
    %w[A1 B2 C3], %w[A3 B2 C1]
  ]

  # Détecter victoire pour un symbole
  def winner?(symbol)
    WIN_LINES.any? do |line|
      line.all? { |lbl| cell(lbl).value == symbol }
    end
  end
end
