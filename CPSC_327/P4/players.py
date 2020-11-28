#players
import provided
import pieces
import moves
import board
from constants import *
import checkers_iterator

class player_factory:
	player = WHITE

	def create_player(self, string, history = False):
		if string == 'human':
			return self.create_human(history)
		if string == 'simple':
			return self.create_simple()
		if string == 'random':
			return self.create_random()

	def create_human(self, history):
		player = human(player_factory.player, history)
		player_factory.player = player_factory.player * -1
		return player

	def create_simple(self):
		player = simple(player_factory.player)
		player_factory.player = player_factory.player * -1
		return player

	def create_random(self):
		player = random(player_factory.player)
		player_factory.player = player_factory.player * -1
		return player



class player:
	def __init__(self, color):
		self.color = color

	def prompt(self, gamestate):
		raise NotImplemented
	
	def take_turn(self, gamestate):
		raise NotImplemented 

class human(player):
	def __init__(self, color, history):
		super().__init__(color)
		self.history = history

	def prompt(self, gamestate):
		if self.history == False:
			return self.next(gamestate)
		else:
			choice = input('undo, redo, or next\n')
			if choice == 'next':
				command = moves.next(gamestate)
				gamestate = command.make_move()
				return self.next(gamestate)

			elif choice == 'undo':
				command = moves.undo(gamestate)
				nstate = command.make_move()

				if nstate == gamestate:
					command = moves.next(gamestate)
					gamestate = command.make_move()
					return self.next(gamestate)
				
				else:
					nstate.print_board()
					return nstate

			elif choice == 'redo':
				command = moves.redo(gamestate)
				nstate = command.make_move()
				nstate.print_board()
				
				if nstate == gamestate:
					command = moves.next(gamestate)
					gamestate = command.make_move()
					return self.next(gamestate)
				
				else:
					nstate.print_board()
					return nstate
					

	def next(self, gamestate):
		#find all jump moves:
		color = gamestate.player
		if color == 1:
			iterator = checkers_iterator.white_iterator(gamestate.all_pieces)
		else:
			iterator = checkers_iterator.black_iterator(gamestate.all_pieces)

		all_moves = []

		for piece in iterator:
			piece.gen_encoded_and_str_moves(gamestate)
			moves_a = piece.show_encoded_moves()
			for move in moves_a:
				all_moves.append(move)

		jumps = []

		for move in all_moves:
			if len(move) == 3:
				jumps.append([move[0][0], move[0][1]])


		piece = input("Select a piece to move\n")
		piece = str(piece)
		piece = provided.convert_checker_coord(piece)
		a_piece = gamestate.board[piece[0]][piece[1]]

		if not isinstance(a_piece, pieces.checker_piece):
			print("no piece at that location\n")
			return self.prompt(gamestate)

		if a_piece.color != self.color:
			print("that is not your piece\n")
			return self.prompt(gamestate)

		avail_moves_checker = moves.check_avail_moves(gamestate, piece)
		avail_moves = avail_moves_checker.make_move()

		if avail_moves == False or (jumps != [] and [piece[0], piece[1] ]not in jumps):
			print("that piece cannot move\n")
			return self.prompt(gamestate)
		
		else:
			a_piece.show_moves()
			index = input("Select a move by entering the corresponding index\n")
			index = int(index)
			return self.take_turn(gamestate, piece, index)
		

	def take_turn(self, gamestate, piece, index):
		command = moves.human_move(gamestate, piece, index)
		nstate = command.make_move()
		nstate.print_board()
		return nstate


class simple(player):
	def __init__(self, color):
		super().__init__(color)

	def prompt(self, gamestate):
		return self.take_turn(gamestate)

	def take_turn(self, gamestate):
		command = moves.simple_move(gamestate)
		nstate = command.make_move()
		nstate.print_board()
		return nstate



class random(player):
	def __init__(self, color):
		super().__init__(color)

	def prompt(self, gamestate):
		return self.take_turn(gamestate)

	def take_turn(self, gamestate):
		command = moves.random_move(gamestate)
		nstate = command.make_move()
		nstate.print_board()
		return nstate




