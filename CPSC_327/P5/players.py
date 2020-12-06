import random
import sys
from constants import W, L, WHITE, BLACK
from copy import deepcopy

class Player:
    "Abstract player class"

    def __init__(self, side=None) -> None:
        self.side = side

    def take_turn(self):
        raise NotImplementedError()

    @staticmethod
    def create_player(player_type):
        "Factory method for creating players"
        if player_type == "human":
            return HumanPlayer()
        elif player_type == "random":
            return RandomCompPlayer()
        elif player_type == "simple":
            return SimpleCompPlayer()
        elif player_type[:7] == "minimax":
            if len(player_type) == 7:
                print("no depth specified for minimax")
                sys.exit()
            depth = int(player_type[7:])
            return MiniMaxPlayer(depth)
        else:
            return None


class HumanPlayer(Player):
    "Concrete player class that prompts for moves via the command line"

    def take_turn(self, game_state):
        b = game_state.board
        while True:
            chosen_piece = input("Select a piece to move\n")
            chosen_piece = b.get_space(chosen_piece).piece
            if chosen_piece is None:
                print("no piece at that location")
                continue
            if chosen_piece.side != self.side:
                print("that is not your piece")
                continue
            options = chosen_piece.enumerate_moves()
            if len(options) == 0 or options[0] not in game_state.all_possible_moves():

                print("that piece cannot move")
                continue

            self._prompt_for_move(options).execute(game_state)
            return

    def _prompt_for_move(self, options):
        while True:
            for idx, op in enumerate(options):
                print(f"{idx}: {op}")
            chosen_move = input(
                "Select a move by entering the corresponding index\n")
            try:
                chosen_move = options[int(chosen_move)]
                return chosen_move
            except ValueError:
                print("not a valid option")


class RandomCompPlayer(Player):
    "Concrete player class that picks random moves"

    def take_turn(self, game_state):
        options = game_state.all_possible_moves()
        m = random.choice(options)
        print(m)
        m.execute(game_state)


class SimpleCompPlayer(Player):
    "Concrete player class that chooses moves that capture the most pieces while breaking ties randomly"

    def take_turn(self, game_state):
        options = game_state.all_possible_moves()
        max_value = 0
        potential_moves = []
        for m in options:
            if m.capture_values() > max_value:
                potential_moves = [m]
                max_value = m.capture_values()
            elif m.capture_values() == max_value:
                potential_moves.append(m)

        selected_move = random.choice(potential_moves)
        print(selected_move)
        selected_move.execute(game_state)



class MiniMaxPlayer(Player):
    "minimax player that choses moves based on minimax tree search. Depth is passed in as a paramater when initially creating"

    def __init__(self, depth, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.depth = depth

    # def take_turn(self, game_state):
    #     options = game_state.all_possible_moves()
    #     max_value = 0
    #     potential_moves = []
    #     for m in options:
    #         if m.capture_values() > max_value:
    #             potential_moves = [m]
    #             max_value = m.capture_values()
    #         elif m.capture_values() == max_value:
    #             potential_moves.append(m)

    #     selected_move = random.choice(potential_moves)
    #     print(selected_move)
    #     selected_move.execute(game_state)


    def take_turn(self, game_state):
        options = game_state.all_possible_moves()
        states = self._children(game_state)
        max_val = L
        best_move = None

        for index in range(len(options)):
            move = options[index]
            state = states[index]

            value = self._minimax(state, state.current_side, self.depth, L, W)

            if value > max_val:
                max_val = value
                best_move = move

        print(best_move)
        best_move.execute(game_state)
    
    def _minimax(self, node, player, depth, minv, maxv):
        if self._leaf(node) or depth == 0:
            return self._evaluate(node, player)

        if node.current_side == player:
            v  = minv
            for child in self._children(node):
                v_prime  = self._minimax (child, player, depth-1, v, maxv)
                if v_prime > v:
                    v = v_prime
                if v > maxv:
                    return maxv
            return v

        if node.current_side != player:
            v  = maxv
            for child in self._children(node):
                v_prime = self._minimax (child, player, depth-1 ,minv, v)
                if v_prime < v:
                    v = v_prime
                if v < minv:
                    return minv
            return v


    def _leaf(self, game_state): #see if this game_state is an end game position
        draw = game_state.check_draw()
        loss = game_state.check_loss(WHITE) or game_state.check_loss(BLACK)
        if draw or loss:
            return True
        else:
            return False



    def _evaluate(self, game_state, player): #return the value of this gamestate
        winloss = game_state.check_loss()
        if winloss:
            if game_state.current_side == player:
                return W
            else:
                return L

        draw = game_state.check_draw()
        if draw:
            return 0

        black_value = 0
        white_value = 0

        b_pieces = game_state._board.pieces_iterator(BLACK)
        w_pieces = game_state._board.pieces_iterator(WHITE)

        for piece in b_pieces:
            black_value += piece.value

        for piece in w_pieces:
            white_value += piece.value

        if player == WHITE:
            return black_value - white_value
        else:
            return white_value - black_value




    def _children(self, game_state): #return the children gamestates
        options = game_state.all_possible_moves()
        children = []

        for index in range(len(options)):
            image = deepcopy(game_state)
            moves = image.all_possible_moves()
            move = moves[index]
            move.execute(image)
            children.append(image)

        return children






















