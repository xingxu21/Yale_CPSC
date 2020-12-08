#game board
from constants import *


class Space:
	def __init__(self, row, col):
		self.row = row
		self.col = col
		self.piece = 0 

	def is_free(self) -> bool:
		return self.piece == 0

	def draw(self):
		if self.piece == 0:
			return u"◻"
		else:
			return str(self.piece) 
		





#object for 6x7 connect four board
class Board:
	def __init__(self):
		self._board = [[Space(i, j) for j in range(7)] for i in range(6)]


	def __str__(self):
		"string representation of the board"
		output = ""
		for x in range(6):
			for y in range(7):
				output += (self._board[x][y]).draw() + " "
			output += "\n"
		output += " ".join(ALPHABET[:7])
		return output	



	def space_iterator(self	):
		"Iterator over all free spaces on the board that pieces can be placed on"
		for space in self:
			if space.piece == 0:
				if space.row == 5 or not self._board[space.row+1][space.col].is_free():
					yield space



	def __iter__(self):
		"Iterator over all spaces in the board"
		for x in range(6):
			for y in range(7):
				yield self._board[x][y]









