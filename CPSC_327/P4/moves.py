#moves
import checkers_iterator
import board
import piece_factory
import pieces
from constants import *
import constants
import provided
from random import randint
import pdb

class move_command:
	past_moves = []
	future_moves = []
	undos = []

def make_move(self):
	raise NotImplemented

class check_win_draw(move_command):
	def __init__(self, gamestate):
		self.gamestate = gamestate
	
	def make_move(self):
		"returns the winner or 0 for draw, none for just keep going"
		white_iterator = checkers_iterator.white_iterator(self.gamestate.all_pieces)
		black_iterator = checkers_iterator.black_iterator(self.gamestate.all_pieces)
		white_moves = []
		black_moves = []
		gamestate = self.gamestate

		for bp in black_iterator:
			bp.gen_encoded_and_str_moves(gamestate)
			moves = bp.show_encoded_moves()
			black_moves.append(moves)

		for wp in white_iterator:
			wp.gen_encoded_and_str_moves(gamestate)
			moves = wp.show_encoded_moves()
			white_moves.append(moves)

		white_moves = len(white_moves)
		black_moves = len(black_moves)

		if white_moves == 0 and black_moves != 0:
			return BLACK

		if white_moves !=0 and black_moves == 0:
			return WHITE

		if white_moves !=0 and black_moves !=0:
			return 100

		if white_moves == 0 and black_moves == 0:
			return -100



class check_avail_moves(move_command):
	def __init__(self, gamestate, piece):
		self.piece = gamestate.board[piece[0]][piece[1]]
		self.gamestate = gamestate
	
	def make_move(self):
		piece = self.piece
		piece.gen_encoded_and_str_moves(self.gamestate)
		moves = piece.show_encoded_moves()

		if moves == []:
			return False
		else:
			return True




class undo(move_command):
	"returns the old gamestate with pieces uncaptured/demoted"
	def __init__ (self, gamestate):
		self.gamestate = gamestate

	def make_move(self):
		if move_command.past_moves == []:
			return self.gamestate
		else:
			self.past_move = move_command.past_moves.pop()
			move_command.future_moves.append(self.past_move)
			move = self.past_move
			current_state = self.gamestate

			current_state.future_states.append(current_state)
			past_state = current_state.past_states.pop()

			promoted = move.prom_cap[0]
			captured = move.prom_cap[1]

			if promoted != None:
				man = promoted[0]
				king = promoted[1]

				man.mark_uncaptured()
				king.mark_captured()
				demoted = [king, man]
			else:
				demoted = None

			uncaptured = captured
			self.dem_ucap = [demoted, uncaptured]

			if captured != None:
				for piece in captured:
					piece.mark_uncaptured()

			move_command.undos.append(self)
			
			constants.TURN -= 1
			return past_state


class redo(move_command):
	def __init__(self, gamestate):
		self.gamestate = gamestate

	def make_move(self):
		if move_command.future_moves == []:
			return self.gamestate
		else:
			self.gamestate.past_states.append(self.gamestate)
			self.future_move = move_command.future_moves.pop()
			move = self.future_move
			undo = move_command.undos.pop()
			move_command.past_moves.append(self.future_move)

			dem_ucap = undo.dem_ucap
			demoted = dem_ucap[0]
			uncaptured = dem_ucap[1]

			if demoted != None:
				king = demoted[0]
				man = demoted[1]
				king.mark_uncaptured()
				man.mark_captured()

			if uncaptured != None:
				for piece in uncaptured:
					piece.mark_captured()

			
			new_state = self.gamestate.future_states.pop()
			constants.TURN += 1
			return new_state


class next(move_command):
	def __init__(self, gamestate):
		self.gamestate = gamestate

	def make_move(self):
		if move_command.future_moves == []:
			pass
		else:
			while move_command.future_moves != []:
				move_command.future_moves.pop()
				self.gamestate.future_states.pop()

		return self.gamestate





class human_move(move_command):
	def __init__(self, gamestate, piece, index):
		self.board = gamestate.board
		self.piece = self.board[piece[0]][piece[1]]
		self.move_index = index
		self.old_state = gamestate
		self.all_pieces = gamestate.all_pieces


	def make_move(self):
		"returns a new gamestate with the move made"
		old_state = self.old_state
		old_state.past_states.append(old_state)

		new_color = old_state.player * -1
		new_size = old_state.size
		new_state = board.game_state(new_size, new_color)
		new_state.board = []
		for row in old_state.board:
			new_state.board.append(row[:])


		self.prom_cap = self.piece.make_move(new_state, self.move_index)

		if self.prom_cap[0]!=None:
			king = self.prom_cap[0][1]
			if king.color == WHITE:
				self.all_pieces.white.append(king)
			else:
				self.all_pieces.black.append(king)

		move_command.past_moves.append(self)

		constants.TURN += 1
		return new_state



class random_move(move_command):
	def __init__(self, gamestate):
		self.board = gamestate.board
		self.all_pieces = gamestate.all_pieces
		self.old_state = gamestate

	def make_move(self):
		if self.old_state.player == 1:
			self.iterator = checkers_iterator.white_iterator(self.all_pieces)
		else:
			self.iterator = checkers_iterator.black_iterator(self.all_pieces)

		all_moves = []

		for piece in self.iterator:
			piece.gen_encoded_and_str_moves(self.old_state)
			moves = piece.show_encoded_moves()
			for move in moves:
				all_moves.append(move)

		jumps = []

		for move in all_moves:
			if len(move) == 3:
				jumps.append(move)

		if jumps == []:
			old_state = self.old_state
			old_state.past_states.append(old_state)

			if old_state.player == 1:
				pieces = self.all_pieces.white
			else:
				pieces = self.all_pieces.black

			index = randint(0, len(pieces) -1)
			piece = pieces[index]
			moves = []
			while piece.captured == True or moves == []:
				index = randint(0, len(pieces) -1)
				piece = pieces[index]
				piece.gen_encoded_and_str_moves(old_state)
				moves = piece.show_encoded_moves()

			index = randint(0, len(moves)-1)
		else:
			old_state = self.old_state
			index = randint(0, len(jumps) -1)
			piece = jumps[index][0]
			x = piece[0]
			y = piece[1]

			piece = old_state.board[x][y]
			index = piece.encoded_moves.index(jumps[index])


		new_color = old_state.player * -1
		new_size = old_state.size
		new_state = board.game_state(new_size, new_color)
		new_state.board = []
		for row in old_state.board:
			new_state.board.append(row[:])


		self.prom_cap = piece.make_move(new_state, index)

		if self.prom_cap[0]!=None:
			king = self.prom_cap[0][1]
			if king.color == WHITE:
				self.all_pieces.white.append(king)
			else:
				self.all_pieces.black.append(king)

		move_command.past_moves.append(self)
		constants.TURN += 1
		return new_state 



class simple_move(move_command):
	def __init__(self, gamestate):
		self.board = gamestate.board
		self.old_state = gamestate
		self.all_pieces = gamestate.all_pieces

	def make_move(self):
		if self.old_state.player == 1:
			# print("WHITE PIECES ############################")
			# for element in self.all_pieces.white:
			# 	print(element.position, element.captured)
			# print("#########################################\n")
			self.iterator = checkers_iterator.white_iterator(self.all_pieces)
		else:
			# print("BLACK PIECES ############################")
			# for element in self.all_pieces.black:
			# 	print(element.position, element.captured)
			# print("#########################################\n")
			self.iterator = checkers_iterator.black_iterator(self.all_pieces)


		all_moves = []

		for piece in self.iterator:
			piece.gen_encoded_and_str_moves(self.old_state)
			moves = piece.show_encoded_moves()
			
			if moves != []:
				if moves[0][0] != tuple(piece.position):
					culprit = piece
					pdb.set_trace()
					culprit.gen_encoded_and_str_moves(self.old_state)


			for move in moves:
				all_moves.append(move)

		jumps = []

		for move in all_moves:
			if len(move) == 3:
				jumps.append(move)

		jumps.sort(key = lambda x : len(x[2]), reverse= True)

		if jumps == []:
			index = 0
			if len(all_moves) > 1:
				index = randint(0, len(all_moves)-1)
			move =  all_moves[index]

			if len(all_moves) ==0:
				return self.old_state

		else:
			move = jumps[0]

		x = move[0][0]
		y = move[0][1]
		[(1, 5), [7, 3], [(2, 4), (4, 2), (6, 2)]]
		old_state = self.old_state
		piece = old_state.board[x][y]

		old_state = self.old_state
		old_state.past_states.append(old_state)

		new_color = old_state.player * -1
		new_size = old_state.size
		new_state = board.game_state(new_size, new_color)
		new_state.board = []
		for row in old_state.board:
			new_state.board.append(row[:])

		piece.gen_encoded_and_str_moves(self.old_state)
		moves = piece.show_encoded_moves()
		index = moves.index(move)

		self.prom_cap = piece.make_move(new_state, index)

		if self.prom_cap[0]!=None:
			king = self.prom_cap[0][1]
			if king.color == WHITE:
				self.all_pieces.white.append(king)
			else:
				self.all_pieces.black.append(king)

		move_command.past_moves.append(self)

		constants.TURN += 1
		return new_state














