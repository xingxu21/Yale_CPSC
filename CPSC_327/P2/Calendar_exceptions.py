import Event

class EmptyCalendarError(Exception):
	pass

class InvalidDateError(Exception):
	def __init__(self, value):
		self.val = value

class InvalidTimeError(Exception):
	def __init__(self, value):
		self.val = value

class CalendarConflictError(Exception):
	def __init__(self, value):
		self.val = value