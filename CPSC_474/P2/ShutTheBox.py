#cpsc 4 P2

import pdb
import sys
from itertools import chain, combinations

#probability of rolling each value with two dice
prob2 = {
    2: float(1)/36,
    3: float(2)/36,
    4: float(3)/36,
    5: float(4)/36,
    6: float(5)/36,
    7: float(6)/36,
    8: float(5)/36,
    9: float(4)/36,
    10: float(3)/36,
    11: float(2)/36,
    12: float(1)/36
}



def powerset(iterable):
    "powerset([1,2,3])) --> [[], [1], [2], [3], [1,2], [1,3], [2,3], [1,2,3]]"
    s = list(iterable)
    result = chain.from_iterable(combinations(s, r) for r in range(len(s)+1))
    result = map(list, list(result))
    return result



def subset_sum(arr, val): 
    ret_val = []
    for i in powerset(arr):
        if sum(i) == val:
            ret_val.append(i)
    return ret_val



def end_state(boxes, roll):
    "returns a vector: [True] if end_state and [False, [opt_move]] if not end_state. Also if end state, updates scores hash table"

    if boxes == []:

        return [True]

    moves = subset_sum(boxes,roll)

    if moves == []:

        return [True]

    else:
        return [False, moves[0]]



def optimal_move(boxes, roll):
    "print and return optimal move (or score if endgame)"
    #check if this is an end state first
    end = end_state(boxes, roll)
    if end[0] == True:
        print("Endstate. Score is %s."%end[1])
        return end[1]

    elif sum(boxes) ==  roll:
        print(boxes)
        return boxes

    else:
        move = end[1]
        print(move)
        return move



p1_dic = {}
p2_dic = {}


def v2(s, r, t):
    key = tuple([tuple(s),r,t])
    
    if key in p2_dic:
        return p2_dic[key]


    moves = subset_sum(s, r)
    if moves == [] and sum(s) > t:
        p2_dic[key] = float(0)
        return float(0)

    elif moves == [] and sum(s) == t:
        p2_dic[key] = float(0.5)
        return float(0.5)

    elif moves == [] and sum(s) < t:
        p2_dic[key] = float(1)
        return float(1)

    else:
        ret_val = 0

        values = []
        for move in moves:
            new_board = list(set(s)-set(move))
            running_total = float(0)

            if sum(new_board) > 6:
                for roll in range(2,13):
                    running_total += prob2[roll] * v2(new_board, roll, t)
                values.append(running_total)

            elif sum(new_board) <= 6:
                for roll in range(1,7):
                    running_total += (float(1)/6) * v2(new_board, roll, t)
                values.append(running_total)

        ret_val = max(values)

    p2_dic[key] = ret_val
    return ret_val


def v1(s,r):
    key = tuple([tuple(s),r])
    
    if key in p1_dic:
        return p1_dic[key]


    moves = subset_sum(s, r)
    
    if s == []:
        p1_dic[key] = float(1)
        return float(1)

    values = []
    if moves != []:
        for move in moves:
            new_board = list(set(s)-set(move))
            running_total = float(0)

            if sum(new_board) > 6:
                for roll in range(2,13):
                    running_total += prob2[roll] * v1(new_board, roll)
                values.append(running_total)

            elif sum(new_board) <= 6:
                for roll in range(1,7):
                    running_total += (float(1)/6) * v1(new_board, roll)
                values.append(running_total)


    elif moves == []:
        running_total = float(0)
        for roll in range(2,13):
            running_total += prob2[roll]*v2([1,2,3,4,5,6,7,8,9], roll, sum(s))
        
        p1_dic[key] = 1- running_total
        return 1- running_total

    ret_val = max(values)
    p1_dic[key] = ret_val
    return ret_val


player = 0

if sys.argv[1] == "--one":
    player = 1

elif sys.argv[1] == "--two":
    player = 2

board = []
board_in = sys.argv[3]

for i in range(0, len(board_in)):
    board.append(int(board_in[i]))
del board_in


if sys.argv[2] == "--move":
    if player == 1:
        roll = int(sys.argv[4])
        optimal_move(board, roll)

    if player == 2:
        roll = int(sys.argv[5])
        optimal_move(board, roll)


elif sys.argv[2] == "--expect":
    if player == 2:
        p1_score = int(sys.argv[4])

        vector = []

        if sum(board) >6:
            for i in range(2,13):
                vector.append(prob2[i] * v2(board,i,p1_score))

        else:
            for i in range(1,7):
                vector.append((float(1)/6) * v2(board,i,p1_score))

        ratio = sum(vector)
        print("%.6f"%ratio)


    if player == 1:

        vector = []
        if sum(board) >6:
            for i in range(2,13):
                vector.append(prob2[i] * v1(board,i))

        else:
            for i in range(1,7):
                vector.append((float(1)/6) * v1(board,i))
        
        ratio = sum(vector)
        print("%.6f"%ratio)
