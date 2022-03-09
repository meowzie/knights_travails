# frozen_string_literal: true

# require 'pry-byebug'

# Creates chess board
class Board
  attr_accessor :squares

  def initialize
    @squares = []
    8.times { |row| 8.times { |column| @squares << Square.new([row, column]) } }
  end

  def find(position)
    result = nil
    squares.each do |square|
      if square.position == position
        result = square
        break
      end
    end
    result
  end

  def move_finder(position, row = position[0], column = position[1])
    [[row + 2, column + 1],
     [row + 1, column + 2],
     [row - 2, column + 1],
     [row - 1, column + 2],
     [row + 2, column - 1],
     [row + 1, column - 2],
     [row - 1, column - 2],
     [row - 2, column - 1]]
  end

  def move_legitimizer(position)
    potential = move_finder(position)
    squares = []
    potential.each do |coordinate|
      squares << find(coordinate)
    end
    squares
  end

  def move_assigner(position)
    square = find(position)
    legal = move_legitimizer(position)

    square.ruv = legal[0]
    square.ruh = legal[1]
    square.rdv = legal[2]
    square.rdh = legal[3]
    square.luv = legal[4]
    square.luh = legal[5]
    square.ldh = legal[6]
    square.ldv = legal[7]
  end
end

# Creates squares that are contained within the knight's tree of moves
class Square
  attr_accessor :position, :ruv, :ruh, :rdv, :rdh, :luv, :luh, :ldh, :ldv

  def initialize(position)
    @position = position
    # each of the following denotes one of the square's possible chidren
    # r means it's to the right of the square, l to the left
    # u means it's above the square, d below
    # v means the distance to the move is 2 squares vertical and 1 horizontal, h is 1 vertical and 2 horizontal
    @ruv = nil
    @ruh = nil
    @rdv = nil
    @rdh = nil
    @luv = nil
    @luh = nil
    @ldh = nil
    @ldv = nil
  end
end

# board = Board.new
# binding.pry
