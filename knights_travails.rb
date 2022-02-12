# Creates chess board
class Board
  attr_accessor :knight

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

# Creates the knight (which goes on the chess board)
class Knight
  attr_accessor :row, :column, :position

  def initialize(position)
    @position = position
    @square = Board.find(position)
  end

  def possible_moves(coordinates)
    row = coordinates[0]
    column = coordinates[1]
    valid = [[row + 1, column + 2], [row + 1, column - 2], [row + 2, column + 1], [row + 2, column - 1],
             [row - 1, column + 2], [row - 1, column - 2], [row - 2, column + 1], [row - 2, column - 1]]
    valid.map! do |position|
      position if position.none? { |coordinate| coordinate.negative? || coordinate > 7 }
    end.compact!
    valid.map! { |position| Board.find(position) unless position.nil? }
  end

  def moves_tree(current, target, visited = [])
    visited << current
    return visited.pop if visited.include?(target)

    possible = possible_moves(current)
    return if possible.all? { |square| visited.include?(square) }

    possible.each do |square|
      moves_tree(square.position, target, visited) unless visited.include?(square.position)
    end
  end
end

# Creates squares that are contained within the knight's tree of moves
class Square
  attr_accessor :position, :row, :column

  def initialize(row, column)
    @row = row
    @column = column
    @position = [@row, @column]
  end
end
