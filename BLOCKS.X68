;-----------------------------------------------------------
;           BLOCKS
;-----------------------------------------------------------
  
BLUPD
            


BLPLOT

            MOVEM.L D0-D6,-(A7)
            MOVE.B  #80,D0
            MOVE.L  #0,D1
            TRAP    #15
            
            CLR.W   D2                      ;UPPER Y
            MOVE.W  #BLHEIGHT,D4            ;DOWN Y
            LEA     COLORS,A0
            
            MOVE.W  #BLROW-1,D6
            
.LOOP2           
 
            MOVE.B  #81,D0
            MOVE.L  (A0)+,D1
            TRAP    #15
                                      ;BUCLE FILAS
            MOVE.W #BLCOL-1,D5
            MOVE.W  #BLWIDTH,D3             ;RIGHT X
            CLR.W   D1                      ;LEFT X
            
.LOOP1                                      ;BUCLE COLUMNAS
            MOVE.B  #87,D0
            TRAP    #15
            MOVE.W  D3,D1
            ADD.W   #BLWIDTH, D3
            DBRA    D5,.LOOP1  

            MOVE.W  D4,D2
            ADD.W   #BLHEIGHT,D4
            DBRA    D6,.LOOP2
            MOVEM.L (A7)+,D0-D6
            RTS




*~Font name~Courier New~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
