#game state for chess
from game_state import GameState
from chess.moves import ChessMoveSet
from constants import BLACK, WHITE


class ChessGameState(GameState):

    def all_possible_moves(self, side=None):
        if not side:
            side = self._current_side
        pieces = self._board.pieces_iterator(side)
        # uses ChessMoveSet to enforce restriction on basic moves when at least once piece has a jump
        options = ChessMoveSet()
        for piece in pieces:
            options.extend(piece.enumerate_moves())

        return options



    def check_loss(self, side=None):
        if not side:
            side = self._current_side
        # no more pieces
        #returns true if loss
        values = set()
        pieces = self._board.pieces_iterator(side)

        for piece in pieces:
            values.add(piece.value)

        if 100 not in values or len(values) == 0:
            return True
        else:
            return False