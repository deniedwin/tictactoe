# frozen_string_literal: true

# this class stores player variables and makes the player do a move
class Player
  def initialize(id, marker)
    @id = id
    @marker = marker
  end

  def to_s
    "Player: #{@id} with mark: #{@marker}"
  end

  attr_reader :id, :marker

  def make_move(board)
    puts "Player-#{@marker} choose a number:"
    loop do
      position = gets.to_i
      if board.valid_move?(position)
        board.mark_cell(position, self)
        break
      else
        puts 'invalid move, try again!'
      end
    end
  end
end
