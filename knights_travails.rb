class Board
  attr_reader :board
  def initialize
    @board = Array.new(8) { Array.new(8) {"*"} }
  end

  def render
    puts "  " + "#{(0..7).to_a.join(" ")}"
    @board.each_with_index do |row, index|
      puts "#{index} #{row.join(" ")}"
    end
    nil
  end
end

class KnightPathFinder
  def self.valid_moves
    #take potential moves - visited positions
    #add ^ into visited postiions
    #potential move permutations (-1=>-2,+2)(+1=>-2,+2)(-2=>-1,+1)(+2=>-1,+1)
  end

  def initialize(start_pos = [0,0])#, end_pos = [0,0])
    @start_pos = start_pos
    # @end_pos = end_pos
    @visited_pos = [@start_pos]
  end

  def build_move_tree

  end

  def find_path(end_pos)

  end

  def new_move_pos(pos)
  end



end
