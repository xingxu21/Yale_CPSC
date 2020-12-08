#pieces
from constants import *

class Piece:
	"Abstract piece class"

	def __init__(self, side, board, space):
		self.space = space
		self._board = board
		self._side = side

	def __str__(self):
		if self._side == WHITE:
			return u"⚆"
		else:
			return u"⚈"

		

	
	