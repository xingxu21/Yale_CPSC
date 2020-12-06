#chess pieces
from piece import Piece
from piece_factory import PieceFactory
from constants import BLACK, WHITE
from chess.moves import ChessMove, ChessMoveSet




class ChessFactory(PieceFactory):
    "Concrete piece factory for setting up a checkers game"

    def create_piece(self, board, space):
        x = space.row
        y = space.col
        color = None
        if x < 2:
            color = BLACK
            piece_type = self.det_type(space)
            return piece_type(BLACK, board, space)

        if board.size - x < 3:
            color = WHITE
            piece_type = self.det_type(space)
            return piece_type(WHITE, board, space)
        return None

    def det_type(self, space):
        #returns the constructor of the correct chess type
        x = space.row
        y = space.col

        if x == 1 or x == 6: #basic pawns
            return Chess

        elif x == 0 or x == 7: #more complex pieces
            if y == 0 or y == 7: 
                return Rook

            elif y == 1 or y == 6:
                return Knight

            elif y == 2 or y == 5:
                return Bishop

            elif y == 3:
                return Queen

            elif y == 4:
                return King



class Chess(Piece):
    "Concrete piece class for a basic chess pawn"

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.value = 1
        if self._side == WHITE:
            self._symbol = u"♙"
            self._directions = ["n"]
            self._capture_dirs = ["nw", "ne"]
        if self._side == BLACK:
            self._symbol = u"♟"
            self._directions = ["s"]
            self._capture_dirs = ["sw", "se"]

    def enumerate_moves(self):
        moves = ChessMoveSet()

        for direction in self._directions: #regular moves
            one_step = self._board.get_dir(self._current_space, direction)
            if one_step:
                if one_step.is_free():
                    m = ChessMove(self._current_space, one_step, [])
                    moves.append(m)
                    if (self._side == WHITE and one_step.row == 0) or \
                            (self._side == BLACK and one_step.row == self._board.size - 1):
                        m.add_promotion()

                    if self.moved == 0:
                        two_step = self._board.get_dir(one_step, direction)
                        if two_step:
                            if two_step.is_free():
                                m = ChessMove(self._current_space, two_step, [])
                                moves.append(m)
                                if (self._side == WHITE and two_step.row == 0) or \
                                        (self._side == BLACK and two_step.row == self._board.size - 1):
                                    m.add_promotion()

        for direction in self._capture_dirs:
            one_step = self._board.get_dir(self._current_space, direction)
            if one_step:
                if not one_step.is_free() and one_step.piece.side != self.side:
                    captured = [one_step]
                    m = ChessMove(self._current_space, one_step, captured)
                    moves.append(m)
                    if (self._side == WHITE and one_step.row == 0) or \
                            (self._side == BLACK and one_step.row == self._board.size - 1):
                        m.add_promotion()

        return moves


    def promote(self):
        "Overrides promote to return a Queen in the same space for the same side"
        return Queen(self._side, self._board, self._current_space)




class Queen(Chess):
    "Same as a basic checker except that it can move in all 8 directions, has a different symbol, and cannot be promoted further"

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.value = 9
        self._directions = ["ne", "nw", "se", "sw", "n", "s", "e", "w"]
        if self._side == WHITE:
            self._symbol = u"♕"
        if self._side == BLACK:
            self._symbol = u"♛"

    def enumerate_moves(self):
        moves = ChessMoveSet()

        for direction in self._directions:
            start = self._board.get_dir(self._current_space, direction)
            
            while start: #is a valid move
                #check if there is a piece on the same team there
                if not start.is_free() and start.piece.side == self.side: #piece on the same side there. 
                    break

                if not start.is_free() and start.piece.side != self.side: #piece that can be captured
                    captured = [start]
                    m = ChessMove(self._current_space, start, captured)
                    moves.append(m)
                    if (self._side == WHITE and start.row == 0) or \
                            (self._side == BLACK and start.row == self._board.size - 1):
                        m.add_promotion()
                    break

                if start.is_free():
                    m = ChessMove(self._current_space, start, [])
                    moves.append(m)
                    if (self._side == WHITE and start.row == 0) or \
                            (self._side == BLACK and start.row == self._board.size - 1):
                        m.add_promotion()
                    
                    start = self._board.get_dir(start, direction)

        return moves

    def promote(self):
        "Override promote to return self since a king cannot be promoted further"
        return self




class King(Chess):
    "Same as a basic checker except that it can move in all 8 directions, has a different symbol, and cannot be promoted further"

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.value = 100
        self._directions = ["ne", "nw", "se", "sw", "n", "s", "e", "w"]
        if self._side == WHITE:
            self._symbol = u"♔"
        if self._side == BLACK:
            self._symbol = u"♚"

    def enumerate_moves(self):
        moves = ChessMoveSet()

        for direction in self._directions:
            one_step = self._board.get_dir(self._current_space, direction)
            if one_step:
                if not one_step.is_free() and one_step.piece.side == self.side:
                    continue
                
                captured = []
                if not one_step.is_free() and one_step.piece.side != self.side and one_step not in captured:
                    captured = [one_step]

                m = ChessMove(self._current_space, one_step, captured)
                if (self._side == WHITE and one_step.row == 0) or \
                        (self._side == BLACK and one_step.row == self._board.size - 1):
                    m.add_promotion()
                moves.append(m)

        return moves

    def promote(self):
        "Override promote to return self since a king cannot be promoted further"
        return self




class Rook(Chess):
    "Same as a basic checker except that it can move 4 cardinal directions, has a different symbol, and cannot be promoted further"

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.value = 5
        self._directions = ["n", "s", "e", "w"]
        if self._side == WHITE:
            self._symbol = u"♖"
        if self._side == BLACK:
            self._symbol = u"♜"

    def enumerate_moves(self):
        moves = ChessMoveSet()

        for direction in self._directions:
            start = self._board.get_dir(self._current_space, direction)
            
            while start: #is a valid move
                #check if there is a piece on the same team there
                if not start.is_free() and start.piece.side == self.side: #piece on the same side there. 
                    break

                if not start.is_free() and start.piece.side != self.side: #piece that can be captured
                    captured = [start]
                    m = ChessMove(self._current_space, start, captured)
                    moves.append(m)
                    if (self._side == WHITE and start.row == 0) or \
                            (self._side == BLACK and start.row == self._board.size - 1):
                        m.add_promotion()
                    break

                if start.is_free():
                    m = ChessMove(self._current_space, start, [])
                    moves.append(m)
                    if (self._side == WHITE and start.row == 0) or \
                            (self._side == BLACK and start.row == self._board.size - 1):
                        m.add_promotion()
                    
                    start = self._board.get_dir(start, direction)

        return moves

    def promote(self):
        "Override promote to return self since a king cannot be promoted further"
        return self




class Bishop(Chess):
    "Same as a basic checker except that it can move in all 4 semi cardinal directions, has a different symbol, and cannot be promoted further"

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.value = 3
        self._directions = ["ne", "nw", "se", "sw"]
        if self._side == WHITE:
            self._symbol = u"♗"
        if self._side == BLACK:
            self._symbol = u"♝"

    def enumerate_moves(self):
        moves = ChessMoveSet()

        for direction in self._directions:
            start = self._board.get_dir(self._current_space, direction)
            
            while start: #is a valid move
                #check if there is a piece on the same team there
                if not start.is_free() and start.piece.side == self.side: #piece on the same side there. 
                    break

                if not start.is_free() and start.piece.side != self.side: #piece that can be captured
                    captured = [start]
                    m = ChessMove(self._current_space, start, captured)
                    moves.append(m)
                    if (self._side == WHITE and start.row == 0) or \
                            (self._side == BLACK and start.row == self._board.size - 1):
                        m.add_promotion()
                    break

                if start.is_free():
                    m = ChessMove(self._current_space, start, [])
                    moves.append(m)
                    if (self._side == WHITE and start.row == 0) or \
                            (self._side == BLACK and start.row == self._board.size - 1):
                        m.add_promotion()
                    
                    start = self._board.get_dir(start, direction)

        return moves

    def promote(self):
        "Override promote to return self since a king cannot be promoted further"
        return self




class Knight(Chess):
    "Same as a basic checker except that it can move in all 4 semi cardinal directions, has a different symbol, and cannot be promoted further"

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.value = 3
        self._directions = ["n", "s", "e", "w"]
        if self._side == WHITE:
            self._symbol = u"♘"
        if self._side == BLACK:
            self._symbol = u"♞"

    def enumerate_moves(self):
        moves = ChessMoveSet()

        for direction in self._directions:
            first_step = self._board.get_dir(self._current_space, direction)

            if first_step:
                split_point = self._board.get_dir(first_step, direction)
            else:
                continue

            #set up directions 1 and 2:
            if direction == "w" or direction == "e":
                direction1 = "n"
                direction2 = "s"

            if direction == "n" or direction == "s":
                direction1 = "w"
                direction2 = "e"

            if split_point:
                a_step = self._board.get_dir(split_point, direction1)
                b_step = self._board.get_dir(split_point, direction2)
            else:
                continue

            for step in [a_step, b_step]:
                if step:
                    if not step.is_free() and step.piece.side == self.side:
                        continue    

                    captured = []
                    if not step.is_free() and step.piece.side != self.side and step not in captured:
                        captured = [step]

                    m = ChessMove(self._current_space, step, captured)
                    moves.append(m)
                    if (self._side == WHITE and step.row == 0) or \
                            (self._side == BLACK and step.row == self._board.size - 1):
                        m.add_promotion()


        return moves

    def promote(self):
        "Override promote to return self since a king cannot be promoted further"
        return self




