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
    @board = Array.new(3) { Array.new(3, TYPE_EMPTY) }
  end

  def beautify()
    # returns beautiful rendition of the current board
    puts @board
  end

  def move(x, y, type)
    # inputs move of type Z at X,Y (if not illegal!)
  end

  def winner?()
    # checks if board has winner (or draw) and returns the winner type
  end


end

# A single field on a board
class Field < Board
  include FieldHelper
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def to_s
    return @type
  end

end
