from Event import Event
from Contact import Contact
from Meeting import Meeting
import Calendar_exceptions
from datetime import datetime

import logging

class Calendar:

    def __init__(self):
        self._contacts = set([])
        self._events = []

    def add_contact(self, contact):
        self._contacts.add(contact)

    def add_event(self, title, day, start_time, end_time, *args):
        if len(args) > 0:
            new_event = Meeting(title, day, start_time, end_time)
        else:
            new_event = Event(title, day, start_time, end_time)
        for event in self._events:
            if new_event.collides_with(event):
                raise Calendar_exceptions.CalendarConflictError(event)

        for invite in args:
            c = Contact(invite)
            logging.debug("%s, Created contact: %s"%(datetime.now().isoformat(), repr(c)))
            new_event.add_participant(c)
            self._contacts.add(c)
        self._events.append(new_event)
        logging.debug("%s, Created event: %s"%(datetime.now().isoformat(), repr(new_event)))



    def show_contacts(self):
        if self._contacts == []:
            raise Calendar_exceptions.EmptyCalendarError()
        elif self._contacts != []:
            return sorted(self._contacts)

    def show_events(self, events=None):
        if events is None:
            events = self._events

        if events == []:
            raise Calendar_exceptions.EmptyCalendarError()
        elif events != []:   
            return sorted(events)

    def show_events_by_contact(self, name):
        c = Contact(name)

        meetings = [event for event in self._events if event.match(c)]
        return self.show_events(events=meetings)

    def delete(self, index):
        logging.debug("%s, Deleted event: %s"%(datetime.now().isoformat(), repr(sorted(self._events)[index])))
        self._events.remove(sorted(self._events)[index])

