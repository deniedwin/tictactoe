# frozen_string_literal: true

# this class is in charge of the state of the board while it update
class Board
  WINNER_LINES = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [1, 5, 9], [3, 5, 7]
  ].freeze

  def initialize
    @state = (1..9).to_a
  end

  def draw_board
    col_seperator = '|'
    row_seperator = '--+--+--'
    @state.each_with_index do |i, idx|
      print "#{i} #{col_seperator}"
      if [2, 5, 8].include?(idx)
        puts "\n"
        puts row_seperator
      end
    end
  end

  def valid_move?(position)
    position.between?(1, 9) && @state[position - 1].is_a?(Integer)
  end

  def mark_cell(position, player)
    @state[position - 1] = player.marker
  end

  def won?(players)
    WINNER_LINES.each do |line|
      first = @state[line[0] - 1]
      if line.all? { |pos| @state[pos - 1] == first } && first.is_a?(String)
        return players.find { |player| player.marker == first }
      end
    end
    false
  end

  def draw?
    @state.all? { |cell| cell.is_a?(String) }
  end
end
