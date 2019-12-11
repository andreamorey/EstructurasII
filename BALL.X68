; =============================================================================
; BALL
; =============================================================================

BINIT
            MOVE.W  #BINPOSX,BPOSX
            MOVE.W  #BINPOSY,BPOSY  
            MOVE.W  #BINSPEED,BSPEEDX
            MOVE.W  #BINSPEED,D0
            NEG.W   D0
            MOVE.W  D0,BSPEEDY
            RTS
            
BUPD        
            MOVEM.L D0-D2,-(A7)
            
            
.UP         MOVE.W  BPOSY,D1
            CMP.W   #0,D1
            BGT     .LEFT
            NEG.W   BSPEEDY
            
.LEFT       MOVE.W  BPOSX,D1                ;CHOQUE IZQUIERDA
            CMP.W    #0,D1                 
            BGT     .RIGHT     
            NEG.W   BSPEEDX

.RIGHT     
            MOVE.W  BPOSX,D1
            MOVE.W  #SCRCTRL,D2
            ADD.W   #BWIDTH,D1
            CMP.W    D2,D1
            BLT     .DOWN
            NEG.W   BSPEEDX
            
.DOWN       
            MOVE.W  BPOSY,D1
            CMP.W   #SCRHEIGH,D1
            BLT     .END
            MOVE.W   #STAGOVR,(STANEXT)
.END            

            MOVE.W  BSPEEDX,D0
            ADD.W   D0,BPOSX
            
            MOVE.W  BSPEEDY,D1
            ADD.W   D1,BPOSY

            MOVEM.L (A7)+,D0-D2
            
            RTS
            
BPLOT       
            MOVEM.L  D0-D5,-(A7)
            ;CONTOUR COLOR
            MOVE.L  #BINCOLOR,D1  
            MOVE.B  #80,D0
            TRAP    #15
    
             ;FILL COLOR
            MOVE.L   #BINCOLOR,D1  
            MOVE.B  #81,D0
            TRAP    #15
 
            ;CIRCLE

            MOVE.W  #BWIDTH,D5 
    
            MOVE.W  BPOSX,D3
            MOVE.W  BPOSY,D4
            MOVE.W  D3,D1
            MOVE.W  D4,D2
            
            ADD.W   D5,D4
            ADD.W   D5,D3
    

            MOVE.B  #88,D0
            TRAP    #15
    
            MOVEM.L  (A7)+,D0-D5

            RTS







*~Font name~Courier New~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
