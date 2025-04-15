class Game
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = Board.new
  end

  def play_turn(player)
    @board.draw_board
    player.make_move(@board)
  end

  def announce_result(winner)
    @board.draw_board
    if winner
      puts "the winner is #{winner}"
    else
      puts "its a draw"
    end
  end

  def start_game
    @board = Board.new
    current_player = @player1
    loop do
      play_turn(current_player)
      winner = @board.has_won?([@player1, @player2])
      break announce_result(winner) if winner || @board.has_draw?
      current_player = switch_player(current_player)
    end
  end
end

class Board
  WINNER_LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
  
  def initialize
    @state = (1..9).to_a
  end

  def draw_board
    col_seperator = '|'
    row_seperator = '--+--+--'
    @state.each_with_index do |i,idx|
      print "#{i} #{col_seperator}"
      if idx == 2 || idx == 5 || idx == 8
        puts "\n"
        puts row_seperator
      end
    end
  end

  def valid_move?(position)
    position.between?(1,9) && @state[position-1].is_a?(Integer)
  end

  def update_position(position, marker)
    @state.each_with_index do |j,idx|
      if j == position
        @state[idx] = marker
      end
    end
  end

  def has_won?(players)
    WINNER_LINES.each do |i_item|
      if @state[i_item[0]-1] == @state[i_item[1]-1] && @state[i_item[0]-1] == @state[i_item[2]-1]
        return players.find {|player| player.marker == (i_item[0]-1)}
      end
    end
    return false
  end

  def has_draw?
    @state.all? {|cell| cell.is_a?(String)}
  end
end

class Player

  def initialize(id, marker)
    @id = id
    @marker = marker
  end

  attr_reader :id, :marker

  def make_move(game_board) #UPDATE THIS!
    puts "player '#{@marker}' choose number form 1 to 9:"
    while true
      selection = gets
      selection = selection.to_i
      if game_board.valid_move?(selection) == true
        game_board.update_position(selection, @marker)
        break
      end
    end
  end
end

tictactoe = Game.new(Player.new(1,'x'), Player.new(2,'o'))
tictactoe.start_game