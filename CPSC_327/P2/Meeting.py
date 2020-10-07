from Event import Event
import Calendar_exceptions

class Meeting(Event):
    def __init__(self, *args):
        super().__init__(*args)
        self._participants = []

    def __str__(self):
        return super().__str__() + "Participants: {}\n".format(", ".join((str(x) for x in self._participants)))

    def __repr__(self):
        return super().__repr__() + "," + ",".join((str(x) for x in self._participants))

    def add_participant(self, contact):
        self._participants.append(contact)

    def is_participant(self, contact):
        return contact in self._participants

    def match(self, criteria):
        "Not implemented for this class. Always returns False."
        return self.is_participant(criteria)
