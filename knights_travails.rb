require 'pry-byebug'

# Creates chess board
class Board
  def initialize
    8.times { |row| 8.times { |column| @@squares << Square.new(row, column) } }
    @intial = nil
  end
end

# Creates squares that are contained within the knight's tree of moves
class Square
  def initialize(row, column)
  end
end
