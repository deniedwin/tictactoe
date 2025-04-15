class Game
  WINNER_LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
  #find way to add this to check for winners
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

  def start_game
    game_board = Board.new
    (1..9).each do |i|
      game_board.draw_board

      if i.even?
        @player1.make_move(game_board, player1.marker)
      else
        @player2.make_move(game_board, player2.marker)
      end
      
      if Board.has_won?
        game_board.draw_board
        puts 'stop game!'
        puts "the winner is: #{} player-#{player1.marker}"
        break
      elsif Board.has_draw?
        game_board.draw_board
        puts 'its a draw!'
        break
      end
    end
  end

  def self.winner_lines
    WINNER_LINES
  end
end

class Board
  @@board_state = [1,2,3,4,5,6,7,8,9]

  def draw_board
    col_seperator = '|'
    row_seperator = '--+--+--'
    @@board_state.each_with_index do |i,idx|
      print "#{i} #{col_seperator}"
      if idx == 2 || idx == 5 || idx == 8
        puts "\n"
        puts row_seperator
      end
    end
  end

  def valid_move?(position)
    if position.between?(1,9) && @@board_state[position-1].is_a?(Integer)
      true
    else
      puts 'wrong move, try again!'
      false
    end
  end

  def update_position(position, marker)
    @@board_state.each_with_index do |j,idx|
      if j == position
        @@board_state[idx] = marker
      end
    end
  end

  def self.has_won?
    Game.winner_lines.each do |i_item|
      if @@board_state[i_item[0]-1] == @@board_state[i_item[1]-1] && @@board_state[i_item[0]-1] == @@board_state[i_item[2]-1]
        return true
      end
    end
    return false
  end

  def self.has_draw?
    @@board_state.all? {|cell| cell.is_a?(String)}
  end
end

class Player
  def make_move(game_board, marker)
    puts "player '#{marker}' choose number form 1 to 9:"
    while true
      selection = gets
      selection = selection.to_i
      if game_board.valid_move?(selection) == true
        game_board.update_position(selection, marker)
        break
      end
    end
  end

  def initialize(id, marker)
    @id = id
    @marker = marker
  end
  attr_reader :id, :marker
end

tictactoe = Game.new(Player.new(111,'x'), Player.new(222,'o'))
tictactoe.start_game