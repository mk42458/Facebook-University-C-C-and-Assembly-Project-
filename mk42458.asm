;Lab 6
;Mahek Kakkar
;EID: MK42458

;The purpose of this lab is to write a program that creates an interfacew to move students in a waiting room into the main room. The participants will be organized in a linked list structure. 
;There will be two linked lists, one for the waiting room and the other for the main room.


.ORIG x3000
LD R2, MASK
NOT R2, R2
ADD R2, R2, #1 ; stores negative 2 complement in R2

;first block 

LEA R0, LABEL ;loads R0 with the starting address of the string 
PUTS ;prints instruction on the console 

;second block

LEA R1, USEREID ;tells R1 to point to a reserved block of mem where the user EID will be stored (pointer)

RETURN 

GETC ;user types the characters 
OUT ;characters get displayed on console 


ADD R3, R0, R2 ;determines if contents in R1 is a zero
BRZ ENTER
STR R0, R1, #0 ;store R0 into the contents at R1
ADD R1, R1, #1 ;increment R1

BR RETURN ; return to GETC

ENTER 
LD R3, NULL ;load R3 with the null
STR R3, R1, #0 ;store null into contents of R1

;third block 
LD R2, HEAD
LDR R0, R2, #0  ;load contents of HEAD into R0

RETURN2

BRZ WAITINGROOM ;if zero, list has ended and student is not in the main room, go to the waiting room
ADD R0, R0, #1 ;address of EID to compare
LDR R1, R0, #0 ;store contents of R0 + 1 into R1, R1 has address of EID associated with the linked list node 
LEA R2, USEREID ;loads address of the user eid array into R2, pointer to user EID array 

JSR MATCH ;jump to subroutine MATCH

ADD R4, R4, #0 ;identifies the value in R4 as 1 or 0 

BRP MATCH2 ;if value is a 1, match,  jump to MATCH2
LDR R0, R0, #-1 ;if not a match, load R0 with the pointer again and return
BR RETURN2

MATCH2 
LEA R0, USEREID
PUTS
LEA R0, INMAIN ;if match load R0 with address of "in room"  
PUTS 

BR HALT1





WAITINGROOM 
;WRITE CODE TO SEARCH THE WAITING ROOM 
LD R3, HEADWAIT ;loads R2 with x4001
LDR R0, R3, #0 ;loads R0 with contents at memory location x4001 which is pointer to next node

RETURN3

BRZ NOMATCH ;if not in waiting room, jumps to no match?
ADD R0, R0, #1 ; R0 now has the address of the linked list EID string
LDR R1, R0, #0 ; R1 contains the beginning user eid string in the list
LEA R2, USEREID ;R2 contains the address of user eid that the user types in 

JSR MATCH3 ;jumps to match2 subroutine to determine if there is a match in the waiting room

ADD R4, R4, #0 ;determines if value in R4 is a 1 or 0

BRP DELETE/INSERT ;if match go to delete and insert program

ADD R3, R0, #-1 ;contains previous node pointer
LDR R0, R0, #-1 ; if not a match, load R0 with address to pointer again and return


BR RETURN3


;R0 has the pointer to the node that needs to be deleted
;R3 contains address(pointer) to the node pointer (R0) of the node that needs to be deleted. 





DELETE/INSERT
;DELETE NODE PROGRAM  

;R3 has the pointer (address) to the node pointer of the node that needs to be deleted
;R0-1 has the pointer to node that needs to be deleted



ADD R0, R0, #-1 ;R0 has the pointer to node pointer of node that needs to be deleted
LDR R4, R0, #0
STR R4, R3, #0







;INSERT NODE PROGRAM


;R0 will stay the same  
;R1 will get the current head pointer, contents at the starting address of the main room list 

ADD R2, R0 #0 ;R2 has the pointer to the node that was deleted
LD R5, HEAD ; R5 contains the head address x4000
LDR R0, R5, #0 ;R0 contains the head pointer 

STR R0, R2, #0
STR R2, R5, #0


;DISPLAY ADDED TO MAIN ROOM MESSEGE
LEA R0, USEREID 
PUTS
LEA R0, ADDED
PUTS

BR HALT3

NOMATCH
LEA R0, EIDNOMATCH
PUTS ;displays string on console


BR HALT2


HALT1
HALT2
HALT3



HALT

LABEL .STRINGZ "Type EID and press Enter: "
USEREID .BLKW x6
NULL .FILL x0
HEAD .FILL x4000


SAVER1 .FILL x0
SAVER2 .FILL x0
SAVER5 .FILL x0 
SAVER6 .FILL x0


NUMONE .FILL #1
NUMZERO .FILL #0

MASK .FILL x0A

  
INMAIN .STRINGZ " is already in the main room."  
EIDNOMATCH .STRINGZ "The entered EID does not match."
ADDED .STRINGZ " is added to the main room."
HEADWAIT .FILL X4001


MATCH 

        ST R1, SAVER1
        ST R2, SAVER2
        ST R5, SAVER5
        ST R6, SAVER6
        
        BR LOAD ; on first pass branch to directly load instead of incrementing 
        
        INCREMENT
        
        ADD R1, R1, #1 ;increment R1
        ADD R2, R2, #1 ;increment R2
        
        LOAD 
        
        LDR R5, R1, #0 ;load contents of R0 into R5  
        LDR R6, R2, #0 ;load contents of R2 into R6
        
        BRZ ONE ;if its zero branch to ONE where you store a 1 into R4
        
        NOT R6, R6 ;invert R6
        ADD R6, R6, #1 ; 2s complement 
        ADD R5, R5, R6 ; R5 = R5-R6
        
        
        BRZ INCREMENT ;if zero increment 
        LD R4, NUMZERO ;load R4 with 0 if R5 not a 0 
        
        BR RESTORE 
        
        
        ONE 
        LD R4, NUMONE ;load R4 with a 1
        
        RESTORE
        
        LD R1, SAVER1
        LD R2, SAVER2
        LD R5, SAVER5
        LD R6, SAVER6
        
        RET


MATCH3

     ST R1, SAVER1
        ST R2, SAVER2
        ST R5, SAVER5
        ST R6, SAVER6
        
        BR LOAD3 ; on first pass branch to directly load instead of incrementing 
        
        INCREMENT3
        
        ADD R1, R1, #1 ;increment R1
        ADD R2, R2, #1 ;increment R2
        
        LOAD3 
        
        LDR R5, R1, #0 ;load contents of R0 into R5  
        LDR R6, R2, #0 ;load contents of R2 into R6
        
        BRZ ONE1 ;if its zero branch to ONE where you store a 1 into R4
        
        NOT R6, R6 ;invert R6
        ADD R6, R6, #1 ; 2s complement 
        ADD R5, R5, R6 ; R5 = R5-R6
        
        
        BRZ INCREMENT3 ;if zero increment 
        LD R4, NUMZERO ;load R4 with 0 if R5 not a 0 
        
        BR RESTORE3
        
        
        ONE1 
        LD R4, NUMONE ;load R4 with a 1
        
        RESTORE3
        
        LD R1, SAVER1
        LD R2, SAVER2
        LD R5, SAVER5
        LD R6, SAVER6
        
        RET

.end
