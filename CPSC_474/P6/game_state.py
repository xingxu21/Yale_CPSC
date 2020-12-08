#game_state
from constants import *
import move

class GameState():
	def __init__(self, board, side, players):
		
		self._players = players
		self._turn_counter = 1
		# read only properties
		self._current_side = side
		self._board = board
		self.last_placed = None
		self._p1_3s = 0
		self._p2_3s = 0

	@property
	def current_side(self):
		return self._current_side

	@property
	def board(self):
		return self._board

	def __str__(self):
		if self._current_side == WHITE:
			side_string = "white"
		elif self._current_side == BLACK:
			side_string = "black"
		else:
			raise ValueError("Current player is neither black nor white")
		return f"{self._board}\nTurn: {self._turn_counter}, {side_string}"


	def next_turn(self):
		self._current_side = not self._current_side
		self._turn_counter += 1

		new_threes = self.new_threes()
		disturbed = self.disrupted_threes()

		if self._current_side == WHITE:
			self._p2_3s += new_threes
			self._p1_3s += disturbed
		else:
			self._p1_3s += new_threes
			self._p2_3s += disturbed




	def all_possible_moves(self):
		options = []
		spaces = self._board.space_iterator()
		for space in spaces:
			act = move.Move(space)
			options.append(act)

		return options




	def open_cols(self):
		options = []
		spaces = self._board.space_iterator()
		for space in spaces:
			options.append(ALPHABET[space.col])

		return options




	def check_draw(self, side=None):
		options = self.open_cols()
		if len(options) == 0:
			return True


	def valid_coords(self, coord):
		x = coord[0]
		y = coord[1]

		return x in range(6) and y in range(7)


	def check_loss(self):
		chains = self.new_chains()

		for chain in chains:
			if chain >= 4:
				return True	
		return False

	def new_threes(self):
		chains = self.new_chains()
		return sum(map(lambda x: x==3, chains))


	def new_chains(self):
		piece = self.last_placed

		if piece == None:
			return [0,0,0,0]

		side = piece._side

		x = piece.space.row
		y = piece.space.col
		connectedh = 0
		connectedv = 0
		connecteddd = 0
		connectedud = 0
		board = self._board._board

		#check horrizontal 
		#move as far left as possible, walking on same color. Then walk right.
		while y != 0 and board[x][y-1].piece and board[x][y-1].piece._side == side:
			y -= 1

		while self.valid_coords([x,y]) and board[x][y].piece and board[x][y].piece._side == side:
		 	y +=1
		 	connectedh += 1
		
		#check vertical win
		#first reset x and y
		x = piece.space.row
		y = piece.space.col

		#move as far up as possible, walking on same color. Then walk down.
		while x !=0 and board[x-1][y].piece and board[x-1][y].piece._side == side:
			x-=1

		while self.valid_coords([x,y]) and board[x][y].piece and board[x][y].piece._side == side:
			x+=1
			connectedv += 1


		#check diagonial win down
		#first reset x and y
		x = piece.space.row
		y = piece.space.col

		#move as far up left as possible, walking on same color. then walk down right
		while y !=0 and x !=0 and board[x-1][y-1].piece and board[x-1][y-1].piece._side == side:
			y-=1
			x-=1

		while self.valid_coords([x,y]) and board[x][y].piece and board[x][y].piece._side == side:
			y+=1
			x+=1
			connecteddd += 1


		#check diagonal win up
		#first reset x and y
		x = piece.space.row
		y = piece.space.col

		#move as far up right as possible, walking on same color. then walk down left
		while y !=6 and x !=0 and board[x-1][y+1].piece and board[x-1][y+1].piece._side == side:
			y+=1
			x-=1

		while self.valid_coords([x,y]) and board[x][y].piece and board[x][y].piece._side == side:
			y-=1
			x+=1
			connectedud += 1

		return [connecteddd, connectedud, connectedh, connectedv]



	def disrupted_threes(self):
		piece = self.last_placed

		if piece == None:
			return 0

		x = piece.space.row
		y = piece.space.col
		board = self._board._board

		side = not piece._side

		disturbed = 0

		
		up = x-3
		down = x+3
		left = y-3
		right = y+3
		

		#check up:
		if up >= 0:
			#check if the two up adjacent are opposite color
			if board[up][y].piece and board[up+1][y].piece and board[up][y].piece._side == side and board[up+1][y].piece._side == side:
				disturbed -=1

		#check down:
		if down <= 5:
			#check if the two up adjacent are opposite color
			if board[down][y].piece and board[down-1][y].piece and board[down][y].piece._side == side and board[down-1][y].piece._side == side:
				disturbed -=1


		#check left:
		if left >= 0:
			#check if the two up adjacent are opposite color
			if board[x][left].piece and board[x][left+1].piece and board[x][left].piece._side == side and board[x][left+1].piece._side == side:
				disturbed -=1


		#check right:
		if right <= 6:
			#check if the two up adjacent are opposite color
			if board[x][right].piece and board[x][right-1].piece and board[x][right].piece._side == side and board[x][right-1].piece._side == side:
				disturbed -=1


		#check upleft diag:
		if up >= 0 and left >= 0:
			#check if the two up adjacent are opposite color
			if board[up][left].piece and board[up+1][left+1].piece and board[up][left].piece._side == side and board[up+1][left+1].piece._side == side:
				disturbed -=1


		#check upright diag:
		if up >= 0 and right <=6:
			#check if the two up adjacent are opposite color
			if board[up][right].piece and board[up+1][right-1].piece and board[up][right].piece._side == side and board[up+1][right-1].piece._side == side:
				disturbed -=1


		#check downleft diag:
		if down <= 5 and left >= 0:
			#check if the two up adjacent are opposite color
			if board[down][left].piece and board[down-1][left+1].piece and board[down][left].piece._side == side and board[down-1][left+1].piece._side == side:
				disturbed -=1


		#check downright:
		if down <=5 and right <=6:
			#check if the two up adjacent are opposite color
			if board[down][right].piece and board[down-1][right-1].piece and board[down][right].piece._side == side and board[down-1][right-1].piece._side == side:
				disturbed -=1 

		return disturbed















