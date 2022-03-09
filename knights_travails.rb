require 'pry-byebug'

# Creates chess board
class Board
  def initialize
    @@squares = []
    8.times { |row| 8.times { |column| @@squares << Square.new(row, column) } }
  end

  def self.find(position)
    @@squares.find { |square| square.position == position }
  end

  def add_knight(position)
    @knight = Knight.new(position)
  end
end

# Creates squares that are contained within the knight's tree of moves
class Square

  def initialize(row, column)
  end
end
