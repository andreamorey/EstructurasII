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
            MOVEM.L D0-D2,-(A7)
  
            MOVE.W  PPOSX,D0                
            MOVE.W  (PWIDTH),D1
            LSR.W   #1,D1                   ;divide entre 2 
            ADD.W   D1,D0
            MOVE.W  #BWIDTH,D1
            LSR.W   #1,D1
            SUB.W   D1,D0
            MOVE.W  D0,BPOSX                ;actualizo la posición 
                    ;a partir de la plataforma
            
            MOVE.W  #PPOSY,D0
            SUB.W   #BWIDTH,D0
            MOVE.W  D0,BPOSY
            
*.LEFT       MOVE.W  BPOSX,D1
*            CMP.W    #0,D1                  ;CHOCA
*            BGT     .RIGHT                  ;SALTA SI CHOCA
*            MOVE.W  BSPEEDX,D2
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
