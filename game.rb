# module containing Field States
module FieldHelper
  TYPE_X = '[X]'.freeze
  TYPE_O = '[O]'.freeze
  TYPE_EMPTY = '[_]'.freeze

  attr_accessor :TYPE_X, :TYPE_O, :TYPE_EMPTY
end

# A playing board
class Board
  include FieldHelper

  def initialize
    # create a 2D Array with unique empty Field Objects in every slot
    @board = Array.new(3) { Array.new(3) { Field.new(TYPE_EMPTY) } }
  end

  def beautify
    # returns beautiful rendition of the current board
    puts '[ ][A][B][C]'
    @board.map { |x| x.join('') }.each_with_index { |e, i| puts "[#{i + 1}]" << e }
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

    puts "winner type evald as #{winner_type}"

    # if a draw
    return TYPE_EMPTY if !empty_spots? && winner_type == false

    puts "got past draw"

    winner_type
  end

  private

  def winner_rows?
    @board.each do |row|
      return row[0] if row.all? { |field| field == row[0] }
    end
    false
  end

  def winner_collumns?
    @board.transpose.each do |collumn|
      return collumn[0] if collumn.all? { |field| field == collumn[0] }
    end
    false
  end

  def winner_diagonals?
    (0..2).collect { |i| @board[i][i] }.all? { |field| field == @board[1][1] }
    #TODO: Antediagonal
    false
  end

  def empty_spots?
    @board.any? { |row| row.any? { |field| field.type == TYPE_EMPTY } }
  end
end

# A single humble field on a board
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

input_helper_array = ['A', 'B', 'C']

# bootleg type variables
TYPE_X = '[X]'.freeze
TYPE_O = '[O]'.freeze
TYPE_EMPTY = '[_]'.freeze


puts 'Welcome to the bi-annual Tic Tac Ruby Championships!'
board = Board.new
puts 'X starts.'

move_number = 0

loop do
  break if board.winner?

  case move_number.odd?
  when true
    current_type = TYPE_X
  when false
    current_type = Type_0
  end

  board.beautify

  puts 'Chose your move. (input: ROW COLLUMN, for example: 1 A)'
  move = input.split(' ')

  unless (1..3).include?(move[0].to_i) && input_helper_array.include?(move[1]) && move[2].nil?
    puts "Error in your input #{move}, try again!"
    next
  end

  if board.move(move[0], move[1], current_type)
    move_number += 1
    puts 'successful'
  else
    puts "move to #{move[0]} / #{move[1]} invalid. Try again."
  end
end

puts "Winner of current round is: #{board.winner?}"
