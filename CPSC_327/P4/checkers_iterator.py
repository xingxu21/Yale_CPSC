#checker_piece iterator
import pieces
import piece_factory

class checkers_piece_iterator:
	def __iter__(self):
		return self

	def __next__(self):
		raise NotImplemented


class white_iterator(checkers_piece_iterator):
	def __init__(self, all_pieces):
		self.pieces = all_pieces.white
		self.index = 0

	def __next__(self):
		if self.index >= len(self.pieces):
			raise StopIteration()

		piece = self.pieces[self.index]
		self.index += 1

		if piece.captured == True:
			return self.__next__()
		else:
			return piece

		



class black_iterator(checkers_piece_iterator):
	def __init__(self, all_pieces):
		self.pieces = all_pieces.black
		self.index = 0

	def __next__(self):
		if self.index >= len(self.pieces):
			raise StopIteration()

		piece = self.pieces[self.index]
		self.index += 1

		if piece.captured == True:
			return self.__next__()
			
		else:
			return piece


