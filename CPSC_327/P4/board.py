#board
import piece_factory
from constants import *
import constants

class game_state:
	#stack for keeping track of past states
	orig_board = []
	past_states = []
	future_states = []
	size = 0
	all_pieces = None

	def __init__(self, size, player = WHITE):
		#generate board of specified size
		self.player = player
		self.board = []
		first_row = [1*(-1)**i for i in range(size)]
		self.board.append(first_row)

		for i in range(1, size):
			new_row = [i * -1 for i in self.board[-1]]
			self.board.append(new_row)

		for row in range(size):
			for column in range(size):
				if self.board[row][column] == 1:
					self.board[row][column] = BLACK_SQUARE
				else:
					self.board[row][column] = WHITE_SQUARE


		game_state.size = size
		
		for row in self.board:
			game_state.orig_board.append(row[:])

	def print_board(self):
		"shows the current board"
		count = 1
		alph = 'abcdefghijklmnopqrstuvwxyz'
		for row in self.board:
			print(count, end = " ")
			for e in row:
				print (e, end = " ")
			count +=1
			print("\n", end="")
		
		print("  ", end = "")
		for i in range(count-1):
			print(alph[i], end = " ")
		print("\n", end = "")

		if self.player == WHITE:
			color = "white"
		else:
			color = "black"

		string = "Turn: %s, %s"%(constants.TURN, color)
		print(string)


	def undo_move(self):
		"return the previous game state"
		return game_state.past_states.pop()

	def valid_position(self, position):
		"returns truth value of whether a position is on the board"
		row = position[0]
		col = position[1]

		row_truth = row >= 0 and row < game_state.size
		col_truth = col >= 0 and col < game_state.size

		return col_truth and row_truth


	def set_up(self):
		"sets up board and creates all_pieces object with all of the checker pieces. This is stored in game_state.all_pieces"
		all_pieces = piece_factory.all_checker_pieces()
		factory = piece_factory.checkers_factory()

		for row in range(game_state.size):
			for column in range(game_state.size):
				factory.create_checkers(self.board, (row, column), all_pieces)

		game_state.all_pieces = all_pieces






