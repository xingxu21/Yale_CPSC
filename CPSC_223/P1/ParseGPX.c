#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

enum state {findtagstart, findt, findr, findk, findp, findt2, findl, finda, findeq, findqoutestart, findqouteend, findl2, findo, findn, findeq2, findqoutestart2, findqouteend2,
	    findattributestart, finde, findl3, finde2, findattributeend, findattributestart2, findslash, finde3, findl4, finde4, findattributeend2, findattributestart3, findt3, findt4,
findi, findm, finde5, findattributeend3, findattributestart4, end, latmaybe, notlat, lonmaybe, notlon,
goodele, badele, goodtime, badtime};	

enum state current_state;

enum state where; //checks to see if any of our attributes are within a qoute
int previous; //when our attributes are in a qoute, remembers what sort of qoute so we can skip to next instance of it

enum state error; //check for if there are qoutes inside tags
int past; //when qoutes are inside tags, remembers what sort of qoute so we can skip to next instance of

int ch; 

int main()
{
	enum state current_state = findtagstart;

//search for <trkpt in that order. if we make it to eof before we find it, it just stops. If it makes it to eof before 
	//finding any attribute or tag we are looking for it will also stop
	while ((ch = getchar()) != EOF) {
		if ((current_state == findtagstart) && (ch == '<'))
		{
			current_state = findt;
		}

		 else if ((current_state == findt) && ((ch == 't') || (ch == 'T')))
		 {
		 	current_state = findr;
		 } 

		 else if ((current_state == findr) && ((ch == 'r') || (ch == 'R')))
		 {
		 	current_state = findk;
		 }
 
		 else if ((current_state == findk) && ((ch == 'k') || (ch == 'K')))
		 {
		 	current_state = findp;
		 }

		 else if ((current_state == findp) && ((ch == 'p') || (ch == 'P')))
		 {
		 	current_state = findt2;
		 }

		 else if ((current_state == findt2) && ((ch == 't') || (ch == 'T')))
		 {
		 	current_state = findl;
		 	where = latmaybe;
		 }

//we have found <trkpt, but the next attributes we are looing for may be in qoutes. if we find " or '. if we find that,
		 //we skip to the next " or ' before continuing the search for lat
		 else if ((current_state == findl) && (where == latmaybe) && ((ch == '\"') || (ch == '\'')))
		 {
		 	where    = notlat;
		 	previous = ch;
		 }

		 else if ((current_state == findl) && (where == notlat) && (ch == previous))
		 {
		 	where = latmaybe;
		 }

		 else if (((isspace(ch) == 0)) && (current_state == findl) && (where == latmaybe) && ((ch == 'l') || (ch == 'L')))
		 {
		 	 current_state = finda;
		 }

		 else if ((current_state == finda) && ((ch == 'a') || (ch == 'A')))
		 {
		 	current_state = findt4;
		 }

		 else if ((current_state == findt4) && ((ch == 't') || (ch == 'T')))
		 {
		 	current_state = findeq;
		 }

		 else if (((isspace(ch) == 0)) && (current_state == findeq) && (ch == '='))
		 {
		 	current_state = findqoutestart;
		 }
		 
		 else if (((isspace(ch) == 0)) && (current_state == findqoutestart) && ((ch == '\"') || (ch == '\'')))
		 {
		 	current_state = findqouteend;
		 }

//we have found lat=". now we will indiscrimately print everything in "..."
		 else if ((current_state == findqouteend) && ((ch != '\"') && (ch != '\'')))
		 {
		 	putchar(ch);
		 }

//we have printed everything. Now we are looking for lon=" We also do a similar thing to make sure lon is not in 
		 //qoutes
		 else if ((current_state == findqouteend) && ((ch == '\"') || (ch == '\'')))
		 {
		 	current_state = findl2;
		 	printf(",");
		 	where = lonmaybe;
		 }

		 else if ((current_state == findl2) && (where == lonmaybe) && ((ch == '\"') || (ch == '\'')))
		 {
		 	where    = notlon;
		 	previous = ch;
		 }

		 else if ((current_state == findl2) && (where == notlon) && (ch == previous))
		 {
		 	where = lonmaybe;
		 }

		 else if (((isspace(ch) == 0)) && (current_state == findl2) && (where == lonmaybe) && ((ch == 'l') || (ch == 'L')))
		 {
		 	current_state = findo;
		 }

		 else if ((current_state == findo) && ((ch == 'o') || (ch == 'O')))
		 {
		 	current_state = findn;
		 }

		  else if ((current_state == findn) && ((ch == 'n') || (ch == 'N')))
		 {
		 	current_state = findeq2;
		 }

		 else if (((isspace(ch) == 0)) && (current_state == findeq2) && (ch == '='))
		 {
		 	current_state = findqoutestart2;
		 }
		 
		 else if (((isspace(ch) == 0)) && (current_state == findqoutestart2) && ((ch == '\"') || (ch == '\'')))
		 {
		 	current_state = findqouteend2;
		 }

// found lon=" we now indiscrimanately print everything in "..."
		 else if ((current_state == findqouteend2) && ((ch != '\"') && (ch != '\'')))
		 {
		 	putchar(ch);
		 }

//searching for <ele> 
		 else if ((current_state == findqouteend2) && ((ch == '\"') || (ch == '\'')))
		 {
		 	current_state = findattributestart;
		 	printf(",");
		 }

		 else if (((isspace(ch) == 0)) && (current_state == findattributestart) && (ch == '<'))
		 {
		 	current_state = finde;
		 	error = goodele;
		 }

//makes sure that we don't have any " or ' in ele
		 else if (((current_state == finde)
		 	|| (current_state == findl3)
		 	|| (current_state == finde2)
		 	|| (current_state == findattributeend)) && (error == goodele)
		 	&& ((ch == '\"') || (ch == '\'')))
		 {
		 	error = badele;
		 	past = ch;
		 }

		 else if (((current_state == finde)
		 	|| (current_state == findl3)
		 	|| (current_state == finde2)
		 	|| (current_state == findattributeend)) && (error == badele)
		 	&& (ch == past))
		 {
		 	error = goodele;
		 }

		 else if ((current_state == finde) && (error == goodele) && ((ch == 'e') || (ch == 'E')))
		 {
		 	current_state = findl3;
		 } 

		 else if ((current_state == findl3) && (error == goodele) && ((ch == 'l') || (ch == 'L')))
		 {
		 	current_state = finde2;
		 } 

		 else if ((current_state == finde2) && (error == goodele) && ((ch == 'e') || (ch == 'E')))
		 {
		 	current_state = findattributeend;
		 }

		 else if ((current_state == findattributeend) && (error == goodele) && (ch == '>'))
		 {
		 	current_state = findattributestart2;
		 }

//found <ele> now we print until we find a <
		 else if ((current_state == findattributestart2) && (ch != '<'))
		 {
		 	putchar(ch);
		 }

// found the < so not printing anymore. looking for the </ele> attibute
		 else if ((current_state == findattributestart2) && (ch == '<'))
		 {
		 	current_state = findslash;
		 	printf(",");
		 }

		  else if ((current_state == findslash) && (ch == '/'))
		 {
		 	current_state = finde3;
		 }

		 else if ((current_state == finde3) && ((ch == 'e') || (ch == 'E')))
		 {
		 	current_state = findl4;
		 } 

		 else if ((current_state == findl4) && ((ch == 'l') || (ch == 'L')))
		 {
		 	current_state = finde4;
		 } 

		 else if ((current_state == finde4) && ((ch == 'e') || (ch == 'E')))
		 {
		 	current_state = findattributeend2;
		 }

		 else if ((current_state == findattributeend2) && (ch == '>'))
		 {
		 	current_state = findattributestart3;
		 }

//good times. found the end of ele. now we look for <time>
		 else if (((isspace(ch) == 0)) && (current_state == findattributestart3) && (ch == '<'))
		 {
		 	current_state = findt3;
		 	error = goodtime;
		 }

//makes sure that we don't have any " or ' in time
		  else if (((current_state == findt3)
		 	|| (current_state == findi)
		 	|| (current_state == findm)
		 	|| (current_state == finde5)
		 	|| (current_state == findattributeend3)) && (error == goodtime)
		 	&& ((ch == '\"') || (ch == '\'')))
		 {
		 	error = badtime;
		 	past = ch;
		 }

		 else if (((current_state == findt3)
		 	|| (current_state == findi)
		 	|| (current_state == findm)
		 	|| (current_state == finde5)
		 	|| (current_state == findattributeend3)) && (error == badtime)
		 	&& (ch == past))
		 {
		 	error = goodtime;
		 }

		 else if ((current_state == findt3) && (error == goodtime) && ((ch == 't') || (ch == 'T')))
		 {
		 	current_state = findi;
		 } 

		 else if ((current_state == findi) && (error == goodtime) && ((ch == 'i') || (ch == 'I')))
		 {
		 	current_state = findm;
		 } 

		 else if ((current_state == findm) && (error == goodtime) && ((ch == 'm') || (ch == 'M')))
		 {
		 	current_state = finde5;
		 } 

		 else if ((current_state == finde5) && (error == goodtime) && ((ch == 'e') || (ch == 'E')))
		 {
		 	current_state = findattributeend3;
		 } 

		 else if ((current_state == findattributeend3) && (error == goodtime) && (ch == '>'))
		 {
		 	current_state = findattributestart4;
		 }
// found <time>. we replace all commas in time with &comma: and look for the next < for </time>
		 else if ((current_state == findattributestart4) && (ch == ','))
		 {
		 	printf("&comma;");
		 }

		 else if ((current_state == findattributestart4) && ((ch != ',') && (ch != '<')))
		 {
		 	putchar(ch);
		 }

// we don't really need to find the entirety of </time>. now we just go to next one. 
		 else if ((current_state == findattributestart4) && (ch == '<'))
		 {
		 	current_state = findtagstart;
		 	putchar('\n');
		 }
	}
}



