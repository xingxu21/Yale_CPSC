#Mudi Yang
#homework 1
import datetime as dt
import csv 
import pdb
from tabulate import tabulate
import class_defs

def main():
	starting = input("Enter command\nview, contacts, create, delete, load, save, quit\n")
	main_calendar = class_defs.Calendar()

	while starting != "quit":
		#create a meeting or event
		if starting == "create":
			title = input("Title?\n")
			date = input("Date? (YYYY-MM-DD)\n")
			start_time = input("Start time? (HH:MM in 24-hour format)\n")
			end_time = input("End time? (HH:MM in 24-hour format)\n")

			meeting_flag = input("Invite others? \"yes\" or \"no\"\n")#if yes, then read in names of participants and create a meeting

			if meeting_flag == "yes":#create meeting object
				attendees = []

				attendee = input("\"<Contact name>\" or \"done\"\n")
				while attendee != "done":
					attendees.append(attendee)
					attendee = input("\"<Contact name>\" or \"done\"\n")

			
				new_event = class_defs.Meeting(attendees, title, date, start_time, end_time)

				#insert new_event into the calendar:
				success = main_calendar.new_event(new_event)

				if isinstance(success, int):
					#create a contact object for each attendee if needed
					for attendee in attendees:
						added = main_calendar.add_contact(attendee)

						if added == 0: #contact object already exists
							pass 
						else: #contact does not already exist, so create contact
							new_contact = class_defs.Contact(attendee)
							#add contact to list of contact names and list of actual contacts
							main_calendar.add_contact(attendee)
							main_calendar.add_contact_instance(new_contact)

						#add event to contact's list of events
						for contact in main_calendar.contact_instances:
							if contact.name == attendee:
								contact.add_meeting(new_event) 

				else:#print out the conflicting event
					print("Cannot add this event because it conflicts with this event...\n", tabulate([[str(success)]], tablefmt ="grid"))



			else:#create regular event object
				new_event = class_defs.Event(title, date, start_time, end_time)
				#insert new_event into the calendar:
				success = main_calendar.add_event(new_event)
				if isinstance(success, int):
					pass
				else:
					print("Cannot add this event because it conflicts with this event...\n",tabulate([[str(success)]], tablefmt ="grid")) #print out the conficting object

		if starting == "view":
			all_or_contact = input("\"all\" or \"<contat name>\"\n")
			if all_or_contact == "all": #print all events:
				for event in main_calendar.all_events:
					print(tabulate([[str(event)]], tablefmt ="grid"))
			else:
				if all_or_contact not in main_calendar.all_contacts:
					print("Contact not found!\n")
				else:
					for contact in main_calendar.contact_instances:
						if all_or_contact == contact.name:
							contact.show_meetings()

		if starting == "contacts":
			if main_calendar.all_contacts == {}:
				print("No contacts to show!")
			else:
				main_calendar.list_contacts()

		if starting == "delete":
			event_to_delete = input("Which event?\nEnter an index 1..n to identify the event from the sorted list\n")
			event_to_delete = int(event_to_delete)-1
			if event_to_delete <0 or event_to_delete > len(main_calendar.all_events)-1:
				print("Index out of range!")
			else:
				event_to_delete = main_calendar.all_events[event_to_delete]
				print("Deleted this event...")
				print(tabulate([[str(event_to_delete)]], tablefmt="grid"))

				main_calendar.delete_event(event_to_delete)

		if starting == "save":
			print("Saved to calendar.csv")
			main_calendar.save_file("calendar.csv")

		if starting =="load":
			print("Loaded from calendar.csv\n")
			main_calendar.load_file("calendar.csv")

		print("\n")
		starting = input("Enter command\nview, contacts, create, delete, load, save, quit\n")

if __name__ == "__main__":
    main()

