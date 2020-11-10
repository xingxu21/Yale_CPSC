import kalah
import minimax
import test_mcts
import random
import math


class mct_node:
	def __init__(self, parent, position, pos_num):
		self.parent = parent
		self.position = position
		self.pos_num = pos_num
		self.possible_moves = set(position.legal_moves())
		self.wins = 0
		self.plays = 0
		self.children = []


	def expandable_check(self): #check if the current node is a leaf
		if len(self.possible_moves) == 0:
			return False
		return True


	

	def pick_child(self): 
		#if possible moves is not empty, then chose the best move from the possible remaining moves
		if len(self.possible_moves) != 0:
			return random.sample(self.possible_moves, 1)[0]
			

	def traverse(self): #pick the next move based on the UCB heuristics
		c = 1.1	

		if self.position.next_player() == 0:
			UCB = [child.wins/child.plays + c*math.sqrt(math.log(self.plays)/child.plays) for child in self.children]
			selected_child = self.children[UCB.index(max(UCB))]
		else:
			UCB = [child.wins/child.plays - c*math.sqrt(math.log(self.plays)/child.plays) for child in self.children]
			selected_child = self.children[UCB.index(min(UCB))]
		# selected_child = self.children[UCB.index(max(UCB))]
		return selected_child.pos_num

		

	def expand(self,node): #add a node to the mcts tree as a child node, remove the corresponding position from possible moves
		self.children.append(node)
		self.possible_moves.remove(node.pos_num)


	def simulate(self):
		current = self.position

		while current.game_over() != 1:
			possible = current.legal_moves()
			move = random.choice(possible)

			current = current.result(move)
		# pdb.set_trace()
		win = current.winner()
		return win


	def backprop(self, win_val):
		current = self.parent

		while current != None:
			current.reward(win_val)
			current = current.parent


	def reward(self, win_val):
		self.plays += 1

		if win_val == 0:
			self.wins += 0.5
		else:
			self.wins+= win_val



def mcts_strategy(iterations):
	if iterations == 0:
		return 

	def best_move(position):
		count = 0
		
		#create a node at this position
		#set current equal to the start position, keep track of root
		# pdb.set_trace()
		root = mct_node(None, position, float('inf'))
		current = root

		while (count <= iterations):
			#determine if the node is a leaf
			if current.expandable_check():
				#select a child based on heuristic
				#do roll out on child
				new_move = current.pick_child()
				new_pos = current.position.result(new_move)
				new_node = mct_node(current, new_pos, new_move)
				current.expand(new_node)
				win = new_node.simulate()
				new_node.reward(win)
				new_node.backprop(win)
				current = root
				
				#increase count
				count += 1
				

			else: #not expandable
				#select next child node based on heuristic
				#current  = selected child
				if not(current.position.game_over()):
					new_pos = current.traverse()

					#select from the list of children the one that has new_pos as the position
					new_node = None
					for child in current.children:
						if child.pos_num == new_pos:
							new_node = child
							break

					current = new_node
				
				
				elif current.position.game_over():
					win = current.position.winner()
					current.reward(win)
					current.backprop(win)

					current = root
					count += 1

		#select the child with the max value if player 1 and min value if player 2 and return the position(index of pit)

		if position.next_player() == 0:
			max_val = -float('inf')
			best = float('inf')
			for child in root.children:
				if child.wins/child.plays > max_val:
					max_val = child.wins/child.plays
					best = child.pos_num

		else:
			min_val = float('inf')
			best = float('inf')
			for child in root.children:
				if child.wins/child.plays < min_val:
					min_val = child.wins/child.plays
					best = child.pos_num

		# pdb.set_trace()
		return best

	return best_move
