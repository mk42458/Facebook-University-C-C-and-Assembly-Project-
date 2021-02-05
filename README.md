The purpose of this project is to write a program in LC-3 assembly language (similar to assembly code) that
creates a user interface to move students in the waiting room of the EE 306 Zoom classroom to
the main room. The list of participants is organized as a “linked list” data structure. There
are 2 linked lists: one which contains the EIDs of the students already in the main classroom and
the second list contains the EIDs of students currently in the waiting room.

The program searches the main room student list to find a match for the
entered EID. You will find a match only if the student’s EID is in the list. It is possible to not find a match in the list.

If the program finds a match, then it must print out “<EID> is already in the main
room.”. (eg., “XY123 is already in the main room.”)

If a match is not found in the main room student list, then the program checks the
second list of students in the waiting room for the user entered EID. If there is a match
in second list, the program prints out “<EID> is added to the main room.”. (eg., “XY123 is added to
the main room.”)

If the entered EID does not find a match in the second list as well, then the program prints out
the string, “The entered EID does not match."
