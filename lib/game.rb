# frozen_string_literal: true

# this class is in charge of the whole game
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
      puts "the winner is = #{winner}"
    else
      puts 'its a draw'
    end
  end

  def start_game
    current_player = @player1
    loop do
      play_turn(current_player)
      winner = @board.won?([@player1, @player2])
      break announce_result(winner) if winner || @board.draw?

      current_player = switch_player(current_player)
    end
  end

  def switch_player(current_player)
    current_player == @player1 ? @player2 : @player1
  end
end
