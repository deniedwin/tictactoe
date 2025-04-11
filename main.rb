class Game
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @won = false
  end

  def start_game
    game_board = Board.new
    (1..9).each do |i|
      game_board.draw_board

      if i%2 == 0
        @player1.make_move(game_board, 'x')
      else
        @player2.make_move(game_board, 'o')
      end
    end
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
end

tictactoe = Game.new(Player.new, Player.new)
tictactoe.start_game