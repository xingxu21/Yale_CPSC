#Test agents


"""
This file contains all of the tests for my connect 4 minimax agent. In each set of tests, the minimax agent is played against the random agent, and the win rate of the minimax agent for that set of tests is reported. The different sets of tests are described below:

zeroth set:
	random against random 20 times

first set:
	minimax depth 1 against random 20 times

second set:
	minimax depth 2 against random 20 times	

third set:
	minimax depth 3 against random 20 times



typical output:
random(player1) won 9 out of 20 games
minimax depth 1 won 18 out of 20 games
minimax depth 2 won 19 out of 20 games
minimax depth 3 won 20 out of 20 games

I have run this test script a few dozen times, and these are fairly representative results.

I originaly implemented my minimax agent without alpha-beta pruning, but it was way too slow. I then implemented alpha-beta pruning and had to debugg my evaluate function (used by minimax to determine reward for terminal/max depth states) for win/loss and non-terminal gamestates. My heuristic for non-terminal states was originally just to keep track of the 3-in-a-row chains that each player had and return the total number of such chains. However, I seemed to get some better performance when I subtracted the total number of the opponent's 3-in-a-row chains, so I revised my heuristic to be this. In total, this took about 12 hours of work including researching, implementing, debugging, and testing. This project could be further improved by utilizing transposition tables or the SCOUT algorithim. 



If you would like to play against my program:

'python3 main.py human minimax'

the two terms folowing main.py specifies what type of player controls white and black respectively. implemented players are 'human', 'random', and 'minimax'.

the depth for minimax is specified by the intiger immediately after 'minimax', ie 'minimax3' means depth 3. 'minimax' by itself defaults to minimax1. 

"""




##################################### definitions of tests ###########################################
import os

#set0
def test_set_0():
	#clear output file
	os.system("touch output")
	os.system("rm output")
	for run in range(20):
		out = os.system("python3 main.py random random | tail -n 1 >> output")

	results = open("output", "r")

	dic = {"white":0}

	for line in results:
		line = line.strip()
		words = line.split(" ")

		for word in words:
			if word in dic:
				dic[word]+=1


	print("random(player1) won %s out of 20 games"%dic["white"])



#set 1
def test_set_1():
	#clear output file
	os.system("rm output")
	for run in range(20):
		out = os.system("python3 main.py minimax1 random | tail -n 1 >> output")

	results = open("output", "r")

	dic = {"white":0}

	for line in results:
		line = line.strip()
		words = line.split(" ")

		for word in words:
			if word in dic:
				dic[word]+=1


	print("minimax depth 1 won %s out of 20 games"%dic["white"])



#set 2
def test_set_2():
	#clear output file
	os.system("rm output")
	for run in range(20):
		out = os.system("python3 main.py minimax2 random | tail -n 1 >> output")

	results = open("output", "r")

	dic = {"white":0}

	for line in results:
		line = line.strip()
		words = line.split(" ")

		for word in words:
			if word in dic:
				dic[word]+=1


	print("minimax depth 2 won %s out of 20 games"%dic["white"])



#set 3
def test_set_3():
	#clear output file
	os.system("rm output")
	for run in range(20):
		out = os.system("python3 main.py minimax3 random | tail -n 1 >> output")

	results = open("output", "r")

	dic = {"white":0}

	for line in results:
		line = line.strip()
		words = line.split(" ")

		for word in words:
			if word in dic:
				dic[word]+=1


	print("minimax depth 3 won %s out of 20 games"%dic["white"])

#####################################################################################################


######################################## run the tests ##############################################

test_set_0()
test_set_1()
test_set_2()
test_set_3()




