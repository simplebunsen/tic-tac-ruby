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

  # returns false if move could not be made
  def move(x_pos, y_pos, type)
    # inputs move of type Z at X,Y (if not illegal!)
    return false unless @board[x_pos][y_pos].type == TYPE_EMPTY

    @board[x_pos][y_pos] = type
    true
  end

  def winner?
    # checks if board has winner (or draw) and returns the winner type
    winner_type = winner_rows?
    winner_type ||= winner_collumns?
    winner_type ||= winner_diagonals?
    
    # if a draw
    return TYPE_EMPTY if !empty_spots? && winner_type == false

    winner_type
  end

  private

  def winner_rows?
    @board.each do |row|
      return true if row.all? { |field| field == row[0] }
    end
    false
  end

  def winner_collumns?
  end

  def winner_diagonals? 
  end

  def empty_spots?
    @board.any? { |row| row.any? { |field| field == TYPE_EMPTY } }
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
board.move(1, 1, FieldHelper::TYPE_O)
board.move(1, 1, FieldHelper::TYPE_O)
board.move(1, 1, FieldHelper::TYPE_O)
board.beautify
