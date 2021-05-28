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
  end

  def empty_spots?
    @board.any? { |row| row.any? { |field| field == TYPE_EMPTY } }
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

puts 'Welcome to the bi-annual Tic Tac Ruby Championships!\n Chose if you want to play against your friend or the computer! [F/C]'
while (input = gets.chomp)
  case input
  when 'F'
    start_game_human
  when 'C'
    start_game_comp
  else
    puts 'wrong input, please choose'
  end
end

def start_game_human
  board = Board.new
  puts "X starts."
  board.beautify
  puts 'Chose your move. (input: ROW COLLUMN, for example: 1 A)'
  #pseudocode!!!
  move = gets.chomp.split(' ')
  if move[0].number? && (A..C) == move[1] && !move[2].exist?

  end
end

def start_game_comp
  puts gay
end
