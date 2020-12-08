#main driver
from constants import *
from board import Board
from players import Player, HumanPlayer
import sys
import game_state

class GameDriver:
	def __init__(self, player1, player2):
		board = Board()
		self._game_state = game_state.GameState(board, WHITE, None)

		self._players = {
			WHITE: player1,
			BLACK: player2
		}

		player1.side = WHITE
		player2.side = BLACK


	def start_game(self):
		# game loop
		while(True):
			print(self._game_state)

			if self._game_state.check_loss():
				if self._game_state.current_side == WHITE:
					print("black has won")
				else:
					print("white has won")
				return

			if self._game_state.check_draw():
				print("draw")
				return

			player = self._players[self._game_state.current_side]
			player.take_turn(self._game_state)


if __name__ == "__main__":
	# take in arguments and setup defaults if necessary
	if len(sys.argv) > 1:
		player1 = Player.create_player(sys.argv[1])
		if not player1:
			sys.exit()
	else:
		player1 = Player.create_player("human")

	if len(sys.argv) > 2:
		player2 = Player.create_player(sys.argv[2])
		if not player2:
			sys.exit()
	else:
		player2 = Player.create_player("human")


	# create driver and start game
	game = GameDriver(player1, player2)
	game.start_game()






