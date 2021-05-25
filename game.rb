class Board
  @@TYPE_X = "[X]"
  @@TYPE_O = "[O]"
  @@TYPE_EMPTY = "[_]"
  

  def self.empty()
    board = []

    3.times do 
      3.times {board.push Field.new(@@TYPE_EMPTY)}
    end

    return board
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

puts Field.empty_board