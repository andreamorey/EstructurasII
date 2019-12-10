; =============================================================================
; BALL
; =============================================================================

BINIT
            MOVE.W  #BINPOSX,BPOSX
            MOVE.W  #BINPOSY,BPOSY
            MOVE.W  #BINSPEED,BSPEEDX
            MOVE.W  #BINSPEED,BSPEEDY
            RTS
            
BUPD        
            MOVEM.L D1-D2,-(A7)
            
            
            MOVE.W  #BINPOSX,BPOSX
            MOVE.W  #BINPOSY,BPOSY
;.LEFT       MOVE.W  BPOSX,D1
;            CMP.W    #0,D1                  ;CHOCA
;            BGT     .RIGHT                  ;SALTA SI CHOCA
;            MOVE.W  BSPEEDX,D2
*            MULS.W  #$FFFF,D2
*            MOVE.W  D2,BSPEEDX
*.RIGHT       
*            ADD.W   D2,BPOSX
*            MOVE.W  BSPEEDY,D2
*            ADD.W   D2,BPOSY
*            
*            MOVE.W  BPOSX,D1
*            MOVE.W  SCRCTRL,D2
*            SUB.W   #BWIDTH,D2
*            CMP.W    D2,D1
*            BLT     .END
*            MOVE.W  BSPEEDX,D2
*            MULS.W  #$FFFF,D2
*            MOVE.W  D2,BSPEEDX
*.END            
*            ADD.W   D2,BPOSX
*            MOVE.W  BSPEEDY,D2
*            ADD.W   D2,BPOSY
*            

            MOVEM.L (A7)+,D1-D2
            
            RTS
            
BPLOT       
            MOVEM.L  D0-D5,-(A7)
            ;CONTOUR COLOR
            MOVE.L  #BINCOLOR,D1  
            MOVE.B  #80,D0
            TRAP    #15
    
             ;FILL COLOR
            AND.L   #BINCOLOR,D1  
            MOVE.B  #81,D0
            TRAP    #15
 
            ;CIRCLE
            
            MOVE.W  #BWIDTH,D5 
            ADD.W   (BSPEEDX),D5
    
            MOVE.W  BPOSX,D3
            MOVE.W  (BPOSY)+BHEIGHT,D4
            ADD.W   D5,D3
    
            MOVE.W  BPOSX,D1
            MOVE.W  BPOSY,D2
    
            MOVE.W  #88,D0
            TRAP    #15
    
            MOVEM.L  (A7)+,D0-D5

            RTS


*~Font name~Courier New~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
