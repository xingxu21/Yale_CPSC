#Mudi Yang
#file for all classes used in CalendarCLI.py
from datetime import datetime
import csv 
import pdb 
from tabulate import tabulate

class Calendar:
	def __init__(self):
		self.all_events = []
		self.all_contacts = {}
		self.contact_instances = []

	def add_contact(self, contact):
		if contact in self.all_contacts:
			return 0
			pass
		else:
			new_contact = Contact(contact)
			self.all_contacts[contact] = 1
			return 1

	def add_contact_instance(self, contact):
		self.contact_instances.append(contact)

	def add_event(self, event):
		#check for conflicts
		#if there is a confict, delete the event
		#print conflicting event
		#use the defined operators for event
		insert_index = 0
		for i in range(len(self.all_events)):
			if self.all_events[i] < event:
				insert_index += 1
			else:
				break
		insert_flag = 1
		if insert_index -1 >= 0: #check to see if previous element exists
			if self.all_events[insert_index-1].end_time > event.start_time:
				if self.all_events[insert_index-1] == event:
					del event
					return self.all_events[insert_index-1]

				self.delete_event(event)
				return self.all_events[insert_index-1]

		if insert_index <= len(self.all_events)-1: #check to see if there is a next element
			if self.all_events[insert_index].start_time < event.end_time:
				if self.all_events[insert_index] == event:
					del event
					return self.all_events[insert_index]

				self.delete_event(event)
				return self.all_events[insert_index]

		#if not conclicts
		self.all_events.insert(insert_index,event)
		return insert_flag


	def delete_event(self, event):
		#remove event from the list of events for each contact
		for contact in self.contact_instances:
			for i in range(len(contact.meetings)):
				if contact.meetings[i] == event:
					del contact.meetings[i]
		
		if event in self.all_events:
			self.all_events.remove(event)
		del event
		


	def load_file(self, filepath):
		input_file = open(filepath, 'r')
		lines = input_file.readlines()
		for line in lines:
			line = line[:len(line)-1]	
			new_line = line.split(",")

			title = new_line[0]
			date = new_line[1]
			start_time = new_line[2][0:5]
			end_time = new_line[3][0:5]
			if len(new_line) >= 5:
				attendees = new_line[4:]
				new_event = Meeting(attendees, title, date, start_time, end_time)

				for attendee in attendees:
					added = self.add_contact(attendee)
					if added == 0: #contact object already exists
						pass 
					else: #contact does not already exist, so create contact
						new_contact = Contact(attendee)
						#add contact to list of contact names and list of actual contacts
						self.add_contact(attendee)
						self.add_contact_instance(new_contact)

					#add event to contact's list of events
					for contact in self.contact_instances:
						if contact.name == attendee:
							contact.add_meeting(new_event)
			else:
				new_event = Event(title, date, start_time, end_time)
			
			self.add_event(new_event)




	def save_file(self, filepath):
		self.all_events = sorted(self.all_events)

		matrix = []
		for event in self.all_events:
			row = []
			row.append(event.title)
			row.append(event.date)
			row.append(event.start_raw)
			row.append(event.end_raw)
			if event.meeting == 1:
				row = row + event.attendees
			matrix.append(row)

		with open(filepath, 'w') as csvfile:  
		    # creating a csv writer object  
		    csvwriter = csv.writer(csvfile)  
		        
		    # writing the data rows  
		    csvwriter.writerows(matrix)


	def list_contacts(self):
		keys = self.all_contacts.keys()
		keys = sorted(keys)

		for i in keys:
			print(i)



class Event:
	def __init__(self, title, date, start_time, end_time):
		self.title = title
		self.date = date
		self.start_raw =  start_time + ":00"
		self.end_raw = end_time + ":00"
		self.meeting = 0  

		#create datetime objects
		self.start_time = datetime.strptime(self.date + " " + self.start_raw, "%Y-%m-%d %H:%M:%S")
		self.end_time = datetime.strptime(self.date + " " + self.end_raw, "%Y-%m-%d %H:%M:%S")


	def __str__(self): #overload string, use tabular in this. allows for easy printing
		return_str = "%s\nDate: %s\nTime: %s - %s"%(self.title, self.date, self.start_raw, self.end_raw)
		return return_str


	#overload comparison operatons, allows for checking for conflicts. Use the builtin datetime library to help make this easier
	def __eq__(self, other): #overload equal
		return all([self.start_time == other.start_time, self.title == other.title, self.date== other.date, self.end_time==self.end_time]) 

	def __lt__(self, other): #overload lessthan
		return self.start_time < other.start_time

	def __gt__(self, other): #overload greater than
		return self.start_time > other.start_time

	def __ne__(self,other): #overload not equal
		return self.start_time != other.start_time

	def __le__(self,other): #overload less than equal to
		return self.start_time <= other.start_time

	def __ge__(self,other): #overload greater than equal to
		return self.start_time >= other.start_time



class Meeting(Event):
	def __init__ (self, attendees, *args):
		super().__init__(*args)
		self.attendees = attendees
		self.meeting = 1

	def __str__(self): #overload string, use tabular in this. allows for easy printing
		participants = ""
		for i in sorted(self.attendees):
			participants = participants + i + ", "

		participants = participants[:len(participants)-2]
		return_str = "%s\nDate: %s\nTime: %s - %s\nParticipants: %s"%(self.title, self.date, self.start_raw, self.end_raw, participants)
		return return_str

class Contact:
	def __init__(self, name):
		self.name = name
		self.meetings = []

	def add_meeting(self, meeting):
		self.meetings.append(meeting)
		self.meetings = sorted(self.meetings)

	def show_meetings(self):
		for meeting in self.meetings:
			print(tabulate([[meeting]], tablefmt ="grid"))


