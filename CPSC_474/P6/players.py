#players
import random
import sys
from constants import *
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
		elif player_type[:7] == "minimax":
			if len(player_type) == 7:
				return MiniMaxPlayer(1)
			depth = int(player_type[7:])
			return MiniMaxPlayer(depth)
		else:
			return None


class HumanPlayer(Player):
	"Concrete player class that prompts for moves via the command line"

	def take_turn(self, game_state):
		b = game_state.board
		while True:
			chosen_space = input("Select a column\n")
			if chosen_space not in ALPHABET:
				print("chose a valid column")
				continue
			
			open_cols = game_state.open_cols()
			if chosen_space not in open_cols:
				print("no open spots in that column")
				continue

			options = game_state.all_possible_moves()
			index = open_cols.index(chosen_space)

			return options[index].execute(game_state)


class RandomCompPlayer(Player):
	"Concrete player class that picks random moves"

	def take_turn(self, game_state):
		options = game_state.all_possible_moves()
		m = random.choice(options)
		print(m)
		m.execute(game_state)


class MiniMaxPlayer(Player):
	"minimax player that choses moves based on minimax tree search. Depth is passed in as an integer following minimax. default is 6"

	def __init__(self, depth, *args, **kwargs):
		super().__init__(*args, **kwargs)
		self._depth = depth


	def take_turn(self, game_state):
		options = game_state.all_possible_moves()
		states = self._children(game_state)
		max_val = L
		best_move = None

		for index in range(len(options)):
			move = options[index]
			state = states[index]

			value = self._minimax(state, state.current_side, self._depth, L, W)

			if value >= max_val:
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
		loss = game_state.check_loss()
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

		if player == BLACK:
			return game_state._p1_3s #- game_state._p2_3s 
		else:
			return game_state._p2_3s #- game_state._p1_3s


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






















