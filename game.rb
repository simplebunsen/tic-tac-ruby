class Field
  @@TYPE_X = "[X]"
  @@TYPE_O = "[O]"
  @@TYPE_EMPTY = "[_]"
  
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def Field.empty_board()
    board = []

    3.times do 
      3.times {board.push Field.new(Field.@@TYPE_EMPTY)}
    end
    
    return board
  end
end