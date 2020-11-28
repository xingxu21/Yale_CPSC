#pieces
import board
import provided
from constants import * 
import pdb

class checker_piece:
	"default checker piece class"
	def __init__(self, color, position):
		self.color = color
		self.position = position
		self.captured = False
		self.move_strings = []
		self.encoded_moves = []

		#predecessors keeps track of how jumps were made. Destination mapped to (origin, jumped_piece_location)
		self.predecessors = {}

	def find_valid_moves(self, game_state):	
		"returns a list of the ending positions of all valid moves from the start position for the color of the calling piece. All positions are tupples"

		#find all the jump move terminuses, jump move terminals are triples with the last element indicating how many captures the move made
		start = self.position
		board = game_state.board
		stack = []
		stack.append(start + [0])
		visited = set()
		jumps = []
		ret_val = []

		while stack!=[]:
			current = stack.pop()
			current_t = (current[0], current[1])

			if current_t in visited:
				continue

			else:
				visited.add(current_t)
				adj = self.adjacent(game_state, current)
				new = []

				for i in adj:
					i_t = (i[0], i[1])
					if i_t not in visited:
						new.append(i)
						stack.append([i[0], i[1], current[2]+1])

				if new == []:
					jumps.append(current)

		#find all the simple moves that are not jumps
		non_jumps = self.usable_corners(game_state)
		temp_val = []

		#make sure that we are not returning the same position.
		for i in jumps+non_jumps:
			if i[0] == start[0] and i[1] == start[1]:
				continue
			else:
				temp_val.append(i)

		#restrict movement of men
		if self.piece == WHITE_MAN:
			for pos in temp_val:
				row = pos[0]
				if row < start[0]:
					ret_val.append(pos)

		elif self.piece == BLACK_MAN:
			for pos in temp_val:
				row = pos[0]
				if row > start[0]:
					ret_val.append(pos)

		else:
			ret_val = temp_val

		return ret_val

		

	def all_corners(self, game_state, start):
		row = start[0]
		col = start[1]
		
		#first check direct moves
		upleft = [row-1, col-1]
		upright = [row-1, col+1]
		downleft = [row+1, col-1]
		downright = [row+1, col+1]

		#get a list of valid board positions
		valid_board_pos = []
		for i in [upleft, upright, downleft, downright]:
			if game_state.valid_position(i) == 1:
				valid_board_pos.append(i)

		return valid_board_pos

	def usable_corners(self, game_state):
		start = self.position
		valid_board_pos = self.all_corners(game_state, self.position)

		#for each vaild board position, check if you can move there directly.
		valid_straight_moves = []
		for i in valid_board_pos:
			row = i[0]
			col = i[1]

			if game_state.board[row][col] == BLACK_SQUARE:
				valid_straight_moves.append(i)

		return valid_straight_moves

	def adjacent(self, game_state, start):
		"returns all places accessible by jumps"
		all_positions = self.all_corners(game_state, start)
		valid_board_pos = all_positions	
		
		#now check jumps
		valid_jump_moves = []
		#first check if each of the four valid corner spots are filled with a piece of the opposite color
		color = self.color
		board = game_state.board
		opposite_color_corners = []
		for i in valid_board_pos:
			row = i[0]
			col = i[1]
			corner = board[row][col]

			if self.color == WHITE and isinstance(corner, checker_piece):
				if  corner.color == BLACK:
					opposite_color_corners.append(i)

			elif self.color == BLACK and isinstance(corner, checker_piece):
				if corner.color == WHITE:
					opposite_color_corners.append(i)

		#now check if there is an space behind the corner.
		valid_ends = []
		for corner in opposite_color_corners:
			row_dif = corner[0] - start[0]
			col_dif = corner[1] - start[1]

			jump_end = [corner[0]+row_dif, corner[1]+col_dif]
			if game_state.valid_position(jump_end):
				valid_ends.append(jump_end)

		#now check if that space is empty
		for i in valid_ends:
			row = i[0]
			col = i[1]
			if game_state.board[row][col] == BLACK_SQUARE:
				i_t = (row,col)
				s_t = (start[0], start[1])

				if i_t in self.predecessors:
					pass
				else:
					x = (s_t[0] + i_t[0]) /2
					y = (s_t[1] + i_t[1]) /2
					middle = (int(x),int(y))
					self.predecessors[i_t] = [s_t,middle]

				valid_jump_moves.append(i)


		return valid_jump_moves

	def __str__(self):
		raise NotImplemented

	def gen_encoded_and_str_moves(self, game_state):
		"prints moves, returns the moves as a list [start, stop, [jumped positions]]"
		self.predecessors = {}
		start = self.position
		moves = self.find_valid_moves(game_state)
		encoded_moves = []

		start_alp = provided.convert_matrix_coord(start)
		ends = []

		for i in moves:
			end = [i[0],i[1]]
			end_alp = provided.convert_matrix_coord(end)
			ends.append([end_alp, end])

		if ends == []:
			self.move_strings = []
			self.encoded_moves = []

		start = tuple(start)
		move_strings = []
		for i in range(len(moves)):
			move = moves[i]
			if len(move) == 3:
				jumped_arr = []
				jumped_arr_alp = []
				#use predecessor array to find the jumped pieces
				coords = [move[0], move[1]]

				current = tuple(coords)
				while current != start:
					if current not in self.predecessors:
						pdb.set_trace()
					mapping = self.predecessors[current]
					jumped = mapping[1]
					current = mapping[0]
					jumped_alp = provided.convert_matrix_coord(jumped)
					jumped_arr_alp = [jumped_alp] + jumped_arr_alp
					jumped_arr = [jumped] + jumped_arr

				
				encoded_moves.append([start, ends[i][1], jumped_arr])
				seperator = ", "
				thingy = seperator.join(jumped_arr_alp)
				jump_move = "jump move: %s->%s, capturing [%s]"%(start_alp, ends[i][0], thingy)
				move_strings.append(jump_move)

			else:
				#normal move
				encoded_moves.append([start, ends[i][1]])
				basic_move = "basic move: %s->%s"%(start_alp, ends[i][0])
				move_strings.append(basic_move)


		Z = list(zip(move_strings, encoded_moves))
		Z.sort()

		jumpz = []
		for item in Z:
			if len(item[1]) > 2:
				jumpz.append(item)

		if jumpz == []:
			self.move_strings = [element[0] for element in Z]
			self.encoded_moves = [element[1] for element in Z]
		else:
			self.move_strings = [element[0] for element in jumpz]
			self.encoded_moves = [element[1] for element in jumpz]




	def show_moves(self):
		count = 0
		for i in self.move_strings:
			print ("%s: %s"%(count,i))
			count += 1

	def show_encoded_moves(self):
		return self.encoded_moves

	def make_move(self, game_state, index):
		"make sure you pass in a NEW game state!"
		self.gen_encoded_and_str_moves(game_state)

		moves = self.show_encoded_moves()
		move = moves[index]
		start = move[0]
		end = move[1]

		board = game_state.board
		start_x, start_y = start[0], start[1]
		end_x, end_y= end[0], end[1]

		board[start_x][start_y] = game_state.orig_board[start_x][start_y]

		board[end_x][end_y] = self
		self.position = [end_x, end_y]
		promoted = self.promote(game_state)

		if len(move)==3:
			captured = move[2]
			for i in captured:
				x = i[0]
				y = i[1]
				board[x][y].mark_captured()
				board[x][y] = game_state.orig_board[x][y]
		else:
			captured = None

		return [promoted, captured]



	def mark_captured(self):
		self.captured = True

	def mark_uncaptured(self):
		self.captured = False
		

class checker_man(checker_piece):
	def __init__(self, *args):
		super().__init__(*args)

		if self.color == WHITE:
			self.piece = WHITE_MAN
		else:
			self.piece = BLACK_MAN 

	def promote(self, game_state):
		"make sure you pass a new game_state!"

		#check if need promotion:
		black_promotion = self.color == BLACK and self.position[0] == game_state.size -1
		white_promotion = self.color == WHITE and self.position[0] == 0

		if black_promotion or white_promotion:
			position = self.position
			board = game_state.board
			x, y = position[0], position[1]

			self.mark_captured()

			board[x][y] = checker_king(self.color, self.position)
			king = board[x][y]


			return [self, king]
		else:
			return None

	def __str__(self):
		return self.piece



class checker_king(checker_piece):
	def __init__(self, *args):
		super().__init__(*args)

		if self.color == WHITE:
			self.piece = WHITE_KING
		else:
			self.piece = BLACK_KING

	def __str__(self):
		return self.piece

	def promote(self, game_state):
		return None


