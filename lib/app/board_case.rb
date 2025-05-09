class BoardCase
  attr_accessor :value
  attr_reader :label

  def initialize(label)
    @label = label      # "A1", "B3", etc.
    @value = " "        # vide, ou "X"/"O"
  end

  def occupied?
    !(@value == " ")
  end

  def to_s
    @value
  end
end
