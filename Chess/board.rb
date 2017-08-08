require "colorize"

class Board

  attr_reader :grid
  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate_board

  end

  def populate_board
    i = 0
    2.times do
      @grid[i].map! { |pos| pos = Piece.new }
      i += 1
    end
    i = 6
    2.times do
      @grid[i].map! { |pos| pos = Piece.new }
      i += 1
    end
  end

  def valid_move?(start_pos, end_pos)
    x, y = start_pos
    z, w = end_pos
    raise InvalidStartPos if @grid[x][y] == nil
    # raise InvalidEndPos if @grid[z][w].is_a?(Object)
  end


  def move_piece(start_pos, end_pos)
    begin
     x, y = start_pos
     z, w = end_pos
     valid_move?(start_pos, end_pos)

     @grid[z][w] = @grid[x][y]
     @grid[x][y] = nil

     p @grid[z][w]
     p @grid[x][y]
    rescue InvalidStartPos => e
      e.message
    rescue InvalidEndPos => e
      e.message
    end

  end

end


class InvalidStartPos < TypeError
  def message
    puts "Invalid start position!"
  end
end

class InvalidEndPos < TypeError
  def message
    puts "Invalid end position!"
  end
end


class Piece
  def initialize
  end
end

board = Board.new
board.move_piece([0, 0], [4, 4])
print board.grid
