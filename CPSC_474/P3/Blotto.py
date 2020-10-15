#cpsc 474
import sys
import scipy.optimize
import pdb
from itertools import combinations_with_replacement, permutations
import numpy as np


#get all possible moves for a game of blotto for given battlefields and total units
def gen_moves(total_units, battlefields):
	result = []
	combs = []

	number_fields = len(battlefields)
	array = range(total_units+1)
	moves_set = combinations_with_replacement(array,number_fields)

	for i in moves_set:
		if sum(i) == total_units:
			combs.append(i)

	for i in combs:
		perms = list(permutations(i))
		for j in perms:
			result.append(j)

	result = list(set(result))
	result.sort()
	return result



#compare two moves to see which one wins. player 1 makes move1, player two makes move 2. returns array [p1 score, p1 win/loss/tie]
def compare(move1, move2, battlefields):
	score1 = []
	score2 = []

	for i in range(len(battlefields)):
		p1_move = move1[i]
		p2_move = move2[i]
		field = battlefields[i]
		
		if p1_move > p2_move:
			score1.append(field)
		elif p2_move > p1_move:
			score2.append(field)
		elif p1_move == p2_move:
			amt = float(field)/2
			score1.append(amt)
			score2.append(amt)

	score1 = sum(score1)
	score2 = sum(score2)
	
	win = 0
	if score1 > score2:
		win = 1
	elif score1 < score2:
		win = 0
	elif score1 == score2:
		win = 0.5

	return [score1, win]



#populate matrix based on win or scores. Row is player 1, column is player 2
def populate(moves, battlefields, evaluation):
	n_moves = len(moves)
	matrix = [[0]*n_moves for i in range(n_moves)]

	SCORE = 0
	WIN = 1
	scheme = "win or score"

	if evaluation == "--score":
		scheme = SCORE
	elif evaluation == "--win":
		scheme = WIN

	for row in range(n_moves):
		for column in range(n_moves):
			move1 = moves[row]
			move2 = moves[column]

			outcome = compare(move1,move2,battlefields)
			matrix[row][column] = outcome[scheme]

	return matrix



#calculate probabilities for mixed strategy:
def probabilities(matrix, evaluation):
	rows = len(matrix[0])
	cols = rows

	a1 = np.array(matrix)

	minimum = np.min(a1)

	if minimum == 0:
		bounds = (0.0, float('inf'))

	else:
		bounds = (0.0,1/minimum)

	b_ub = [-1.0] * cols
	c = [1.0] * rows

	result = scipy.optimize.linprog(c, np.transpose(a1)*-1, b_ub, None, None, bounds)

	value = 1.0 / result.fun
	x = [xi * value for xi in result.x]

	return x



def equlibrium(moves, probabilities, tolerance):
	result = [[],[]]

	for i in range(len(moves)):
		if probabilities[i] > tolerance:
			result[0].append(moves[i])
			result[1].append(probabilities[i])

	if len(result[0]) == 1:
		return [result[0],[1.0]]
	return result



#calculate expected value of strategy:
def Expected(strategy, evaluation):
	moves = strategy[0]
	probs = strategy[1]
	n_moves = len(moves)

	outcome_val = 0

	SCORE = 0
	WIN = 1
	scheme = "win or score"

	if evaluation == "--score":
		scheme = SCORE
	elif evaluation == "--win":
		scheme = WIN

	for row in range(n_moves):
		for column in range(n_moves):
			move1 = moves[row]
			move2 = moves[column]

			prob1 = probs[row]
			prob2 = probs[column]

			outcome = compare(move1,move2,battlefields)
			outcome_val+= outcome[scheme]*prob1*prob2

	return outcome_val



#check if something is an equlibrium
def verify_eq(eq, evaluation, moves, battlefields, tolerance):
	SCORE = 0
	WIN = 1
	scheme = "win or score"

	if evaluation == "--score":
		scheme = SCORE
	elif evaluation == "--win":
		scheme = WIN

	probs = eq[1]
	if 1-sum(probs) > tolerance:
		return "FAILED"

	expected_val = Expected(eq, evaluation)
	outcomes = []

	strats = eq[0]
	probs = eq[1]

	for move in moves:
		outcome = 0.0
		for index in range(len(strats)):
			value =  compare(move, strats[index], battlefields)
			value = value[scheme]
			value = value*probs[index]

			outcome += value

		outcomes.append(outcome)

	for out in outcomes:
		if expected_val >= out:
			continue
		else:
			if out - expected_val > tolerance:
				return "FAILED"
			else:
				continue

	return "PASSED"


# moves = gen_moves(total_units, battlefields)
# tolerance = 10**(-6)
# verify_eq(strategy, "--win", moves, battlefields)



#read in input
cmd = sys.argv[:]
cmd.pop(0)

mode = "find or verify"
evaluation = "win or score"
tolerance = 10**(-6)
total_units = 0
battlefields = []
strategy = [[],[]]

if cmd[0] == "--find":
	mode = cmd.pop(0)

	if cmd[0] == "--tolerance":
		cmd.pop(0)
		tolerance = float(cmd.pop(0))

	if cmd[0] == "--win":
		evaluation = cmd.pop(0)

	elif cmd[0] == "--score":
		evaluation = cmd.pop(0)

	cmd.pop(0)

	total_units = int(cmd.pop(0))
	battlefields = list(map(int, cmd))

	moves = gen_moves(total_units, battlefields)
	matrix = populate(moves, battlefields, evaluation)
	probs = probabilities(matrix, evaluation)
	eq = equlibrium(moves, probs, tolerance)
	
	for index in range(len(eq[0])):
		move = eq[0][index]
		prob = eq[1][index]

		for i in move:
			print("%s"%i, end = ",")

		print(prob)


elif cmd[0] == "--verify":

	mode = cmd.pop(0)

	if cmd[0] == "--tolerance":
		cmd.pop(0)
		tolerance = float(cmd.pop(0))

	if cmd[0] == "--win":
		evaluation = cmd.pop(0)

	elif cmd[0] == "--score":
		evaluation = cmd.pop(0)

	battlefields = list(map(int, cmd))


	#read in things from standard input
	infile = sys.stdin
	#infile = input_file = open('blotto.dat', 'r')
	for line in infile:
		line = line.split(",")

		prob = line.pop()
		prob = prob.replace("\n","")
		prob = float(prob)
		strategy[1].append(prob)
		
		line = list(map(int, line))
		strategy[0].append(line)


	total_units = sum(strategy[0][0])

	moves = gen_moves(total_units, battlefields)
	print(verify_eq(strategy, evaluation, moves, battlefields, tolerance))



