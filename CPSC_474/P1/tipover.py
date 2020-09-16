#pset1 Tipover solver
import pdb
import sys

#set new recursion limit
sys.setrecursionlimit(2500)
#debugging utility to print the board
def p_board():
	import numpy as np
	grid = np.matrix(board)
	print(grid)

# pdb.set_trace()

#read in inputs 
lines = sys.stdin.readlines()
# input_file = open('tipover.dat', 'r')
# lines = input_file.readlines()
# rows = int(lines[0][0])
# columns = int(lines[0][2])
first_line =  lines[0].split()
rows = int(first_line[0])
columns = int(first_line[1])

second_line = lines[1].split()
start = [int(second_line[0]), int(second_line[1])]

temp_board = lines[2:]

#parse board
board = []

for i in temp_board:
	row = []
	for j in i:
		if j == ".":
			row.append(0)
		elif j == "\n":
			board.append(row)
			row = []
		elif j == "*":
			row.append(float('inf'))
		else:
			row.append(int(j))
board.append(row)
del temp_board


#hash map for original values, encoded by [i*columns+j]
"""
[[0,1,2]
 [3,4,5]
 [6,7,8]]
"""
orig_val = {}
for i in range(rows):
	for j in range(columns):
		if board[i][j] != 0:
			orig_val[i*columns + j] = board[i][j]


#Finds valid stating points for a starting position. returns array of bools [up, down, left, right] indicating whether a move in each of those directions is possible
def valid_moves(start):

	i = start[0]
	j = start[1]

	arr = [0,0,0,0]

	if board[i][j] <2:
		return arr

	value = board[i][j]
	#check if up
	if i - value >= 0:
		count = 0
		pos = board[i-value:i]
		for row in pos:
			count += row[j]
		if count ==0:
			arr[0] = 1

	#check if down
	if i + value <= rows-1:
		count = 0
		pos = board[i+1:i + value+1]
		for row in pos:
			count += row[j]
		if count ==0:
			arr[1] = 1		

	#check if left
	if j - value >= 0:
		if sum(board[i][j-value:j]) == 0:
			arr[2] = 1

	#check if right
	if j + value <= columns-1:
		if sum(board[i][j+1:j + value+1]) == 0:
			arr[3] = 1

	return arr


#functions for making and undoing moves
def make_move(start, move_array):
	if move_array == [0,0,0,0]:
		return []
	instruction = [start, move_array]
	moves.append(instruction)

	#set starting position to 0 on board
	board[start[0]][start[1]] = 0
	#list of all the new starts that we found
	new_starts = []
	i = start[0]
	j = start[1]

	new_start = []
	if move_array[0]:
		set_up(start, 1)
		new_start = [i-1,j]
	elif move_array[1]:
		set_down(start, 1)
		new_start = [i+1, j]
	elif move_array[2]:
		set_left(start, 1)
		new_start = [i,j-1]
	elif move_array[3]:
		set_right(start, 1)
		new_start = [i, j+1]

	return new_start

#undo moves. retuns -1 if we have undone moves all the way to the original starting position
def undo_move():
	instruction = moves.pop()

	start = instruction[0]
	i = start[0]
	j = start[1]
	value = orig_val[i*columns +j]

	board[i][j] = value

	move_array = instruction[1]
	if move_array[0]:
		set_up(start, 0)
	elif move_array[1]:
		set_down(start, 0)
	elif move_array[2]:
		set_left(start, 0)
	elif move_array[3]:
		set_right(start, 0)



#utility functions for setting orig_val(start) spaces in direction from start to n_val.
def set_up(start, n_val):
	i = start[0]
	j = start[1]
	value = orig_val[i*columns +j]

	for row in range(i-value,i):
		board[row][j] = n_val


def set_down(start, n_val):
	i = start[0]
	j = start[1]
	value = orig_val[i*columns +j]

	for row in range(i+1,i + value+1):
		board[row][j] = n_val


def set_left(start, n_val):
	i = start[0]
	j = start[1]
	value = orig_val[i*columns +j]

	for column in range(j-value,j):
		board[i][column] = n_val


def set_right(start, n_val):
	i = start[0]
	j = start[1]
	value = orig_val[i*columns +j]

	for column in range(j+1,j + value+1):
		board[i][column] = n_val


#finds the blocks immediately adjacent to start
def adjacent(start):
	i = start[0]
	j = start[1]

	#Values of i/j if we move up, down, left, right
	up = i-1
	down = i+1
	left = j-1
	right = j+1

	array = [up,down,left,right]
	adjacency = []
	#check if these moves land on the board
	if up <0:
		up = 0
	else:
		up = 1

	if down > rows-1:
		down = 0
	else:
		down = 1

	if left <0:
		left = 0
	else:
		left = 1

	if right > columns-1:
		right = 0
	else:
		right = 1

	if up:
		if board[array[0]][j] > 0:
			adjacency.append([array[0],j])
	if down:
		if board[array[1]][j] > 0:
			adjacency.append([array[1],j])
	if left:
		if board[i][array[2]] > 0:
			adjacency.append([i,array[2]])
	if right:
		if board[i][array[3]] > 0:
			adjacency.append([i,array[3]])

	return adjacency






#DFS search to find all the connected components after a move
def DFS(start):
	ret_val = [] #list of values >1 found
	visited = {}
	queue = [start]

	while queue != []:
		current = queue.pop()
		if current[0]*columns+current[1] in visited:
			continue

		if board[current[0]][current[1]] > 1 and current != start:
			ret_val.append(current)

		visited[current[0]*columns+current[1]] = 1

		adj = adjacent(current)
		for point in adj:
			if point[0]*columns+point[1] in visited:
				continue
			else:
				queue.append(point)

	return ret_val

####################################################################################################################
#starting algorithm for searching utilizing the functions provided above. 

#array of possible starting postitions (this is the stack used for our DFS)
pos_starts = [start]

#array of moves in the order they were made. Also used for DFS
moves = []

#list of nodes that have been visited already
visited = {}



#DFS function utilizing the above helper functions to solve for starting position start
def solve(start):
	new_towers = DFS(start) #array of new towers. 
	new_towers.append(start)

	for tower in new_towers:
		#check to see if a new found tower is the goal
		x_t = tower[0]
		y_t = tower[1]

		if  board[x_t][y_t]== float('inf'):

			return True 

		#find possible tipping moves from that tower
		possible_moves_vector = valid_moves(tower)
		possible_moves = [[0]*4 for i in range(4)]

		#convert moves vector into actual move encodings
		for i in range(4):
			possible_moves[i][i] = possible_moves_vector[i]


		for move in possible_moves:
			if move == [0]*4:
				continue
			else:
				new_start = make_move(tower, move)
				solution = solve(new_start)
				if solution != False:
					return solution
				if solution == False:
					undo_move()
	return False
			

		
result = solve(start)
normal_moves = []

if result == True:
	for i in moves:

		line = ""
		position = i[0]
		instruction = i[1]
		end_str = ""

		if instruction == [1,0,0,0]:
			end_str = "-1 0"

		elif instruction == [0,1,0,0]:
			end_str = "1 0"

		elif instruction == [0,0,1,0]:
			end_str = "0 -1"

		elif instruction == [0,0,0,1]:
			end_str = "0 1"

		for i in position:
			line = line + str(i) + " "

		line = line + end_str
		normal_moves.append(line) 
	
	for i in normal_moves:
		print(i)
else:
	pass

