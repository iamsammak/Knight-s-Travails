require_relative '00_tree_node'
require "byebug"

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) {"*"} }
  end

  def [](pos)
    # byebug
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, piece)
    # byebug
    row, col = pos
    @grid[row][col] = piece
  end

  def render(knights_path)
    populate_knights_path(knights_path)
    puts "  " + "#{(0..7).to_a.join(" ")}"
    @grid.each_with_index do |row, index|
      puts "#{index} #{row.join(" ")}"
    end
    nil
  end

#[[0, 0], [1, 2], [0, 4], [1, 6], [3, 5], [5, 6], [7, 7]]
  def populate_knights_path(knights_path)
    # byebug
    knights_path.each do |pos|
      self[pos] = '♞'
    end
  end

end


class KnightPathFinder

  MOVES = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
  ]

  attr_reader :start_pos
  attr_accessor :root_node, :visited_pos

  def self.valid_moves(pos)
    #take potential moves - visited positions
    #add ^ into visited postiions
    #potential move permutations (-1=>-2,+2)(+1=>-2,+2)(-2=>-1,+1)(+2=>-1,+1)
    valid_moves = []

    coord_x, coord_y = pos
    MOVES.each do |dx, dy|
      new_pos = [coord_x + dx, coord_y + dy]

      if new_pos.all? { |coord| coord.between?(0, 7) }
        valid_moves << new_pos
      end
    end

    valid_moves
  end

  def initialize(start_pos = [0,0])#, end_pos = [0,0])
    @start_pos = start_pos
    # @end_pos = end_pos
    @visited_pos = [@start_pos]

    build_move_tree
  end

  def build_move_tree
    self.root_node = PolyTreeNode.new(start_pos)

    nodes = [root_node]
    until nodes.empty?
      current_node = nodes.shift #shift takes the first

      current_pos = current_node.value
      new_move_positions(current_pos).each do |next_pos|
        next_node = PolyTreeNode.new(next_pos)
        current_node.add_child(next_node)
        nodes << next_node
      end
    end
  end

  def find_path(end_pos)
    end_node = root_node.dfs(end_pos)

    trace_path_back(end_node)
      .reverse
      .map(&:value) #each nodes' value is the pos that Knight can move
  end

  def new_move_positions(pos)
    #class method so type KnightPathFinder instead of self
    KnightPathFinder.valid_moves(pos)
      .reject { |new_pos| visited_pos.include?(new_pos) }
      .each { |new_pos| visited_pos << new_pos }
  end

  def trace_path_back(end_node)
    nodes = []

    current_node = end_node
    until current_node.nil?
      nodes << current_node
      current_node = current_node.parent
    end

    nodes
  end
end

if __FILE__ == $PROGRAM_NAME
  sam = KnightPathFinder.new([0, 0])
  # p sam.find_path([7, 7])
  #would be create a Board instance
  #then give render an argument which will be
  # the knight's path
  #iterate through the path
  #and then highlight each square that the knight touched(aka path)
  path = Board.new
  path.render(sam.find_path([7, 7]))
end
