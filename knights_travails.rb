# frozen_string_literal: true

# Creates chess board
class Board
  attr_accessor :squares, :knight

  def initialize
    @squares = []
    8.times { |row| 8.times { |column| @squares << Square.new(row, column) } }
  end

  def find(row, column)
    @squares.find { |square| square.coordinates == [row, column] }
  end

  def add_knight(row, column)
    @knight = Knight.new(find(row, column))
  end
end

# Creates squares on the chess board
class Square
  attr_accessor :coordinates

  def initialize(horizontal, vertical)
    @coordinates = [horizontal, vertical]
  end
end

# Creates the knight (which goes on the chess board)
class Knight
  attr_accessor :position

  def initialize(position)
    @position = position
    @row = position.coordinates[0]
    @column = position.coordinates[1]
  end

  def possible_moves
    valid = [[@row + 1, @column + 2], [@row + 1, @column - 2], [@row + 2, @column + 1], [@row + 2, @column - 1],
             [@row - 1, @column + 2], [@row - 1, @column - 2], [@row - 2, @column + 1], [@row - 2, @column - 1]]
    valid.map { |position| position if position.none? { |coordinate| coordinate.negative? || coordinate > 7 } }.compact
  end
end
