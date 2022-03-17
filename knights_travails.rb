# frozen_string_literal: true

# Creates chess board
class Board
  def initialize; end

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
    potential.map do |coordinates|
      coordinates if coordinates.none? { |coordinate| coordinate > 7 || coordinate.negative? }
    end.compact
  end

  def path_slicer(visited, current)
    return visited if move_legitimizer(visited[visited.find_index(current) - 1]).include?(current)

    parent = visited.find { |item| move_legitimizer(item).include?(current) }
    visited = visited[0..visited.find_index(parent)].uniq + visited[visited.find_index(current)...visited.length].uniq
    path_slicer(visited, parent)
  end

  def tree_builder(current, target, queue = [], visited = [])
    visited << current
    moves = move_legitimizer(current)
    return path_slicer(visited, current) + [target] if moves.include?(target)

    moves.each { |move| queue << move }
    next_move = queue.shift
    tree_builder(next_move, target, queue, visited)
  end

  def moves_tree(initial, target)
    tree = tree_builder(initial, target)

    puts "You made it in #{tree.length} moves. Here's your path:"
    tree.each { |step| puts step.to_s }
  end
end

board = Board.new
board.moves_tree([0, 0], [7, 3])
