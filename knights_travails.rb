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

  def path_builder
    @squares[0]
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
