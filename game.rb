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
    # create a 2D Array with unique empty Field Objects in every slot
    @board = Array.new(3) { Array.new(3) { Field.new(TYPE_EMPTY) } }
  end

  def beautify
    # returns beautiful rendition of the current board
    puts '[ ][A][B][C]'
    @board.map { |x| x.join('') }.each_with_index { |e, i| puts "[#{i + 1}]" << e }
  end

  # Put in beatify related values, returns false if move could not be made
  def move(x_pos, y_pos, type)
    # convert y_pos and x_pos to proper array index integer!
    y_pos = y_pos.ord - 65
    x_pos = x_pos.to_i - 1

    # inputs move of type Z at X,Y (if not illegal!)
    return false unless @board[x_pos][y_pos].type == TYPE_EMPTY

    @board[x_pos][y_pos].type = type
    true
  end

  def winner?
    # checks if board has winner (or draw) and returns the winner type
    puts "winner row: #{winner_rows?}, cols: #{winner_collumns?}, diags: #{winner_diagonals?}"
    winner_type = winner_rows?
    winner_type ||= winner_collumns?
    winner_type ||= winner_diagonals?

    puts "winner type evald as #{winner_type}"

    # if a draw
    return TYPE_EMPTY if !empty_spots? && winner_type == false

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
    # Diagonal
    return false unless (1..2).collect { |i| @board[i][i] }.all? { |field| field == @board[0][0] }
    # Antediagonal
    return false unless (@board[0][2] == @board[1][1]) == @board[2][0]

    true
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

  def ==(other)
    @type == other.type
  end
end

input_helper_array = ['A', 'B', 'C']

puts 'Welcome to the bi-annual Tic Tac Ruby Championships!'
board = Board.new

move_number = 0

until board.winner?

  case move_number.odd?
  when true
    current_type = FieldHelper::TYPE_O
  when false
    current_type = FieldHelper::TYPE_X
  end

  board.beautify

  puts "Player #{current_type}: Chose your move. (input: ROW COLLUMN, for example: 1 A)"
  current_move = gets.chomp.upcase.split(' ')

  # TODO: Might be better done with error handling, got to learn it first though
  unless (1..3).include?(current_move[0].to_i) && input_helper_array.include?(current_move[1]) && current_move[2].nil?
    puts "Error in your input #{current_move}, try again!"
    next
  end

  if board.move(current_move[0], current_move[1], current_type)
    move_number += 1
    puts 'successful'
  else
    puts "move to #{current_move[0]} / #{current_move[1]} invalid. Try again."
  end
end

puts "Winner of current round is: #{board.winner?}"
