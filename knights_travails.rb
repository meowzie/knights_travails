# frozen_string_literal: true

# Creates chess board
class Board
  attr_accessor :positions

  def initialize
    @positions = []
    8.times { |row| 8.times { |column| @positions << [row, column] } }
  end
end

# Creates positions on the chess board
class Position
  def initialize(horizontal, vertical)
    @horizontal = horizontal
    @vertical = vertical
  end
end
