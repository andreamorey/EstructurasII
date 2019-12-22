*-----------------------------------------------------------
* Title      : StringToFile
* Written by : Charles Kelly
* Date       : Dec. 18th 2015
* Description: Get a string from the keyboard and save to file.
*-----------------------------------------------------------
        ORG     $1000
START:                  ; first instruction of program
; Display description
        lea     description,A1          ; location of text to display
        move.b  #14,D0                  ; trap task #14, displays null terminated string at (A1)
        trap    #15                     ; perform task
; Prompt for input string
        lea     prompt,A1               ; location of text to display
        move.b  #14,D0                  ; trap task #14, displays null terminated string at (A1)
        trap    #15                     ; perform task
; Get input string from keyboard and store in buffer
        lea     string,A1               ; location of buffer
        move.b  #2,D0                   ; trap task #2, reads string from keyboard to buffer at (A1)
        trap    #15                     ; perform task
        move.w  D1,strSize              ; save size of string
; Attempt to open file for output (erases existing file)
        lea     fileName,A1             ; name of file to create
        move.b  #52,D0                  ; trap task #52, open new file
        trap    #15                     ; perform task
        move.l  D1,fileID               ; save file ID
; Check for file errors
        if.w D0 <NE> #0 then.s          ; if file error
            lea     errorFile,A1        ; location of text to display
            move.b  #14,D0              ; trap task #14, displays null terminated string at (A1)
            trap    #15                 ; perform task
            bra     EXIT                ; halt program
        endi
; Write buffer to file
        lea     string,A1               ; location of text to write to file
        move.l  fileID,D1               ; file ID of file to write to
        clr.l   D2
        move.w  strSize,D2              ; number of bytes to write
        add.w   #1,D2                   ; add 1 to include NULL character
        move.b  #54,D0                  ; trap task #54, write to file
        trap    #15                     ; perform task
; Close file to complete write
        move.b  #56,D0                  ; trap task #56, close file, D1 contains fileID
        trap    #15                     ; perform task
; Display success message
        lea     success,A1              ; location of text to display
        move.b  #14,D0                  ; trap task #14, displays null terminated string at (A1)
        trap    #15                     ; perform task

EXIT    SIMHALT         ; halt simulator

* Variables and constants
CR              EQU     $D              ; ASCII code for carriage return
LF              EQU     $A              ; ASCII code for line feed
SIZE            EQU     80              ; Max string size
description     DC.B    'Demonstrates reading a string from the keyboard and saving to a text file. ',CR,LF,CR,LF,0
prompt          DC.B    'Enter text: ',0
fileName        DC.B    'textOPRUEBA.txt',0   ; name of text file
errorFile       DC.B    'A file error occurred.',CR,LF,0
success         DC.B    'File write complete.',CR,LF,0
string          DS.B    80              ; I/O buffer
strSize         DS.W    1               ; Size if input string
fileID          DS.L    1               ; File ID
        END     START                   ; last line of source
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
