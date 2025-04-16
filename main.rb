# frozen_string_literal: true

# requiered files inside lib folder for app to run correctly
require_relative 'lib/player'
require_relative 'lib/board'
require_relative 'lib/game'

# this class functions as running fuction, meaning that it is only to run the game
class GameRunner
  def self.run
    player1 = Player.new(1, 'x')
    player2 = Player.new(2, 'o')
    Game.new(player1, player2).start_game
  end
end

GameRunner.run
