import sys
import math
import random
import time 
import itertools
from collections import defaultdict


def convert_position(pos):
	yards2score = pos[0]
	downs_left = pos[1]

	distance = pos[2]
	ticks = pos[3]

	if (ticks == 0):
		tick_yards = float('inf')
	else:
		tick_yards = yards2score/ticks

	if (downs_left == 0):
		down_dist = float('inf')
	else:
		down_dist = distance/downs_left

	if (tick_yards <= 1.5):
		bin1 = 0
	elif (tick_yards <= 2.5):
		bin1 = 1
	elif (tick_yards <= 2.9):
		bin1 = 2
	elif (tick_yards <= 3.2):
		bin1 = 3
	elif (tick_yards <= 3.333333335):
		bin1 = 4
	elif (tick_yards <= 3.47):
		bin1 = 5
	elif (tick_yards <= 3.6):
		bin1 = 6
	elif (tick_yards <= 3.9):
		bin1 = 7
	elif (tick_yards <= 4.5):
		bin1 = 8
	elif (tick_yards <= 10.0):
		bin1 = 9
	else:
		bin1 = 10

	if (down_dist < 2.5):
		bin2 = 0
	elif (down_dist == 2.5):
		bin2 = 1
	else:
		bin2 = 2

	return (bin1, bin2)
 
def best_act(pos, playbook_size, q_table):
	conv_pos = convert_position(pos)
	max_val = -1
	play_index = -1
	for index in range (0, playbook_size):
		if (q_table[conv_pos, index] > max_val):
			max_val = q_table[conv_pos, index]
			play_index = index
	return play_index

def get_reward(new_position_out, new_position):
	yards2score = new_position[0]
	downs_left = new_position[1]
	distance = new_position[2]
	ticks = new_position[3]

	yards_gained = new_position_out[0]
	ticks_elapsed = new_position_out[1]
	turnover = new_position_out[2]
	immediateRewardBonus = 0

	if (downs_left == 4):
	 	immediateRewardBonus += 0.1

	return immediateRewardBonus


def play_nfl(pos, q_table, model, playbook_size, limit, start):
	alpha = 0.1
	gamma = 1.0
	while (time.time() - start) < (limit - 0.01):
		current = pos
		while (model.game_over(current) == False):
			randInt = random.randint(1,100)
			if (randInt <= 20):
				play_index = random.randint(0,playbook_size - 1)
			else:

				play_index = best_act(current, playbook_size, q_table)
			new_position, new_position_out = model.result(current, play_index)

			if (model.game_over(new_position) == True and model.win(new_position) == True):
				r = 1
			else:
				r = 0

			conv_pos = convert_position(current)
			converted_next = convert_position(new_position)
			nextplay_index = best_act(new_position, playbook_size, q_table)


			q_table[conv_pos, play_index] += alpha * (r + (gamma * (q_table[converted_next, nextplay_index]) - q_table[conv_pos, play_index]))
			current = new_position


			alpha -= 0.000001
			if (alpha < 0.01):
				alpha = 0.01

	bestIndex = best_act(pos, playbook_size, q_table)
	return bestIndex

#return the index of the best offensive play
def q_learn(model, limit):
	q_table = defaultdict(int)
	playbook_size = model.offensive_playbook_size()
	currTime = time.time()
	intialPos = model.initial_position()
	start = time.time()
	
	def fxn(pos):
		index_off_play = play_nfl(pos, q_table, model, playbook_size, limit, start)
		return index_off_play
	return fxn
