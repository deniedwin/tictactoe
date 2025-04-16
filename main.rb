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

# this class is in charge of the state of the board while it update
class Board
  WINNER_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze

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

# this class functions as running fuction, meaning that it is only to run the game
class GameRunner
  def self.run
    player1 = Player.new(1, 'x')
    player2 = Player.new(2, 'o')
    Game.new(player1, player2).start_game
  end
end

GameRunner.run
