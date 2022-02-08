# frozen_string_literal: true

# Method to aid in manipulation of arrays of coordinates (possible moves)
module Element
  def type_to_i
    instance_of?(Array) ? 0 : 1
  end
end

class Object
  include Element
end

# Creates chess board
class Board
  attr_accessor :knight

  def initialize
    @@squares = []
    8.times { |row| 8.times { |column| @@squares << Square.new(row, column) } }
  end

  def self.find(row, column)
    @@squares.find { |square| square.coordinates == [row, column] }
  end

  def add_knight(row, column)
    @knight = Knight.new(Board.find(row, column))
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
  attr_accessor :position, :current

  def initialize(position)
    @position = position
    @row = position.coordinates[0]
    @column = position.coordinates[1]
  end

  def possible_moves
    valid = [[@row + 1, @column + 2], [@row + 1, @column - 2], [@row + 2, @column + 1], [@row + 2, @column - 1],
             [@row - 1, @column + 2], [@row - 1, @column - 2], [@row - 2, @column + 1], [@row - 2, @column - 1]]
    valid.map! do |position|
      position if position.none? { |coordinate| coordinate.negative? || coordinate > 7 }
    end.sort_by!(&:type_to_i)
    valid.map! { |position| Board.find(position[0], position[1]) unless position.nil? }
  end

  def moves_tree
    valid = possible_moves
    @current = Node.new(position)
    @current.one = valid[0]
    @current.two = valid[1]
    @current.three = valid[2]
    @current.four = valid[3]
    @current.five = valid[4]
    @current.six = valid[5]
    @current.seven = valid[6]
    @current.eight = valid[7]
  end
end

# Creates nodes that are contained within the knight's tree of moves
class Node
  attr_accessor :one, :two, :three, :four, :five, :six, :seven, :eight

  def initialize(position)
    @position = position
    @one = nil
    @two = nil
    @three = nil
    @four = nil
    @five = nil
    @six = nil
    @seven = nil
    @eight = nil
  end
end
