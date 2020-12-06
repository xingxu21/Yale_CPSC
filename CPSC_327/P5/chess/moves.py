#chess moves

from move import Move

class ChessMove(Move):
    def __repr__(self):
        return str(self)

    def __str__(self):
        return f"move: {self._start}->{self._end}"




class ChessMoveSet(list):
    """
    An extension to a list meant to hold checkers moves. When using append this ensures that the list does not mix jumps and non-jumps.
    """
    def append(self, move):
        super().append(move)

    def extend(self, other):
        """
        Overrides extend to use this version of append
        """
        for m in other:
            self.append(m)

