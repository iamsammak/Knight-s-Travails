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
