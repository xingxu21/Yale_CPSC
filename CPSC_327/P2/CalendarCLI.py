from Calendar import Calendar
import sys
from tabulate import tabulate
import Calendar_exceptions
from datetime import datetime
import os

import logging

class CalendarCLI():
    def __init__(self):
        self.calendar = Calendar()

        self.choices = {
            "view": self.view,
            "create": self.create,
            "contacts": self.contacts,
            "delete": self.delete,
            "load": self.load,
            "save": self.save,
            "quit": self.quit
        }

    def _print_event(self, event):
        print(tabulate([[str(event)]], tablefmt='grid'))

    def display_menu(self):
        print("Enter command \nview, contacts, create, delete, load, save, quit")

    def run(self):
        """Display the menu and respond to choices."""
        logging.basicConfig(filename='calendar.log', filemode='w', level=logging.DEBUG)
        try:
            while True:
                self.display_menu()
                choice = input(">")
                action = self.choices.get(choice)
                if action:
                    action()
                else:
                    print("{0} is not a valid choice".format(choice))

        except Exception as e:
            print("Sorry! Something unexpected happened. If this problem persists please contact our support team for assistance.")
            logging.exception(str(e))
            return

    def view(self):
        view_type = input('"all" or "<contact name>"\n>')
        if view_type == "all":
            try:
                events = self.calendar.show_events()
            except Calendar_exceptions.EmptyCalendarError:
                print("No meetings to show")
                return
        else:
            try:
                events = self.calendar.show_events_by_contact(view_type)
            except Calendar_exceptions.EmptyCalendarError:
                print("No meetings to show")
                return

        for event in events:
            self._print_event(event)

    def contacts(self):
        for contact in self.calendar.show_contacts():
            print(contact)

    def create(self):
        title = input("Title?\n>")
        date = input("Date? (YYYY-MM-DD)\n>")
        start = input("Start time? (HH:MM in 24-hour format)\n>")
        end = input("End time? (HH:MM in 24-hour format)\n>")
        is_meeting = input('Invite others? "yes" or "no"\n>')
        if is_meeting == "yes":
            invites = []
            invite = input('"<Contact name>" or "done"\n>')
            while (invite != "done"):
                invites.append(invite)
                invite = input('"<Contact name>" or "done"\n>')
            try:
                self.calendar.add_event(
                    title, date, start, end, *invites)
            except Calendar_exceptions.InvalidDateError as e:
                print("Cannot create an event with a date of %s. Try again with this date format YYYY-MM-DD."%e.val)
                return

            except Calendar_exceptions.InvalidTimeError as e:
                print("Cannot create an event with a time of %s. Try again with this time format HH:MM."%e.val)
                return

            except ValueError as e:
                print(e.args[0])
                return

            except Calendar_exceptions.CalendarConflictError as e:
                print("Cannot add this event because it conflicts with this event...")
                self._print_event(e.val)
                return
            

        else:
            try:
                self.calendar.add_event(title, date, start, end)
            except Calendar_exceptions.InvalidDateError as e:
                print("Cannot create an event with a date of %s. Try again with this date format YYYY-MM-DD."%e.val)
                return

            except Calendar_exceptions.InvalidTimeError as e:
                print("Cannot create an event with a time of %s. Try again with this time format HH:MM."%e.val)
                return

            except ValueError as e:
                print(e.args[0])
                return

            except Calendar_exceptions.CalendarConflictError as e:
                print("Cannot add this event because it conflicts with this event...")
                self._print_event(e.args[0])
                return


    def delete(self):
        index = input(
            "Which event?\nEnter an index 1..n to identify the event from the sorted list\n>")
        try:
            self.calendar.delete(int(index) - 1)
        except IndexError:
            print("No such event.")
            return

    def load(self):
        self.calendar = Calendar()
        with open("save.csv", "r") as f:
            for line in f.readlines():
                fields = line.strip().split(",")
                self.calendar.add_event(*fields)
            path = os.getcwd() + "/save.csv"
            logging.debug("%s, Loaded calendar from %s"%(datetime.now().isoformat(), path))


    def save(self):
        with open("save.csv", "w") as f:
            try:
                events = self.calendar.show_events()
            except Calendar_exceptions.EmptyCalendarError:
                print("No meetings to show")
                return
            else:
                for e in self.calendar.show_events():
                    f.write(repr(e) + "\n")

                path = os.getcwd() + "/save.csv"
                logging.debug("%s, Saved calendar to %s"%(datetime.now().isoformat(), path))

    def quit(self):
        sys.exit(0)


if __name__ == "__main__":
    CalendarCLI().run()
