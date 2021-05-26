# module containing Field States
module FieldHelper
  TYPE_X = '[X]'.freeze
  TYPE_O = '[O]'.freeze
  TYPE_EMPTY = '[_]'.freeze
end

# A playing board
class Board
  include FieldHelper
  def initialize
    @board = Array.new(3) { Array.new(3) { Field.new(TYPE_EMPTY) } }
  end

  def beautify
    # returns beautiful rendition of the current board
    puts(@board.map { |x| x.join('') })
  end

  def move(x_pos, y_pos, type)
    # inputs move of type Z at X,Y (if not illegal!)
    return false unless @board[x_pos][y_pos] == TYPE_EMPTY

    @board[x_pos][y_pos] = type
    true
  end

  def winner?
    # checks if board has winner (or draw) and returns the winner type
  end

  private

  def winner_rows?
    @board.each do |row|
      row.all? { |field| field == row[0] }
    end
  end

  def winner_collums?

  end

  def winner_diagonals?

  end

  def draw?
    @board.none? { |field| field == TYPE_EMPTY }
  end


end

# A single field on a board
class Field
  include FieldHelper
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def to_s
    @type
  end
end

board = Board.new
board.beautify
