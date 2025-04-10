class Board
  @@board_state = [1,2,3,4,5,6,7,8,9]
  def draw_board
    col_seperator = '|'
    row_seperator = '--+--+--'
    @@board_state.each do |i| 
      print "#{i} #{col_seperator}"
      if i%3 == 0
        puts "\n"
        puts row_seperator
      end
    end
  end
end

class Player
  def intro_player
    puts 'put new player'
  end
end

main_board = Board.new
main_board.draw_board

# player1 = Player.new
# player2 = Player.new