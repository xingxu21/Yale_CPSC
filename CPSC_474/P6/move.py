#moves
from constants import *
import piece

class Move:
	"""
	Implements a command pattern for moves
	start and end must be space objects
	captures may be empty
	"""

	def __init__(self, space):
		self._space = space
		
	def __str__(self) -> str:
		return "%s"%(ALPHABET[self._space.col])
		

	def execute(self, game_state):
		"Interacts with the start end and capture Space objects to carry out this move command"
		empty_slot = self._space
		p = piece.Piece(game_state._current_side, game_state._board, empty_slot)
		empty_slot.piece = p
		game_state.last_placed = p

		# advance turn and update draw counter
		game_state.next_turn() 
		
