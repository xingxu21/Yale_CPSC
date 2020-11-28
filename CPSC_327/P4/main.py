#main
import provided, board, piece_factory, checkers_iterator, players, pieces, moves, sys
from constants import *
import pdb

if __name__ == '__main__':
	#start playing the game
	#set up the board:
	sys.argv.pop(0)
	inputs = sys.argv
	player1 = str(inputs[0])
	player2 = str(inputs[1])
	size = 8
	history = False

	if len(inputs) == 3:
		#determine if second input is size or history
		if inputs[2] == 'history':
			history = True
		else:
			size = int(inputs[2])


	if len(inputs) > 3:
		size = int(inputs[2])
		history = True

	start = board.game_state(size)
	start.set_up()
	start.print_board()

	check_status = moves.check_win_draw(start)
	status = check_status.make_move()
	current_state = start

	if status == 100:
		player_factory = players.player_factory()
		p1 = player_factory.create_player(player1, history)
		p2 = player_factory.create_player(player2, history)

		players = [None, p1, p2]
		player_i = 1

		while status == 100:
			player = players[player_i]
			new_state = player.prompt(current_state)

			check_status = moves.check_win_draw(new_state)
			status = check_status.make_move()

			current_state = new_state
			player_i = player_i*-1


	if status == WHITE:
		print ("white has won")

	if status == BLACK:
		print("black has won")

	if status == -100:
		print("draw")
	