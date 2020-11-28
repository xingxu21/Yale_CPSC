#piece factory
import pieces
from constants import *

class all_checker_pieces:
	white = []
	black = []

class checkers_factory:
	def create_checkers(self, board, position, all_checker_pieces):
		x = position[0]
		y = position[1]
		position = [x,y]

		if board[x][y] == WHITE_SQUARE:
			pass

		else:
			#black pieces
			if x <=2:
				new_piece = pieces.checker_man(BLACK, position)
				board[x][y] = new_piece
				all_checker_pieces.black.append(new_piece)

			#white pieces
			elif x>= len(board)-3:
				new_piece = pieces.checker_man(WHITE, position)
				board[x][y] = new_piece
				all_checker_pieces.white.append(new_piece)



