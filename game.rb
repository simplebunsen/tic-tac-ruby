class Board
  @@TYPE_X = "[X]"
  @@TYPE_O = "[O]"
  @@TYPE_EMPTY = "[_]"  

  def initialize()
    3.times do 
      @board = []
      3.times {board.push Field.new(@@TYPE_EMPTY)}
    end
  end

  def beautify()
    #returns beautiful rendition of the current board
  end

  def move(x, y, type)
    #inputs move of type Z at X,Y
  end

  def winner?()
    #checks if board has winner (or draw) and returns the winner type
  end


end



class Field < Board
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def to_s()
    return @type
  end

end
