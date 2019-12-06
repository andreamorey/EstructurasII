;------------------------------------------------------------------
;           PLOT
;------------------------------------------------------------------

PLOTP


            MOVEM.L  D0-D5,-(A7)
            ;CONTOUR COLOR
            MOVE.L  #PCOLOR,D1  
            MOVE.B  #80,D0
            TRAP    #15
    
    
             ;FILL COLOR
            AND.L   #PCOLOR,D1  
            MOVE.B  #81,D0
            TRAP    #15
 

        ;SQUARE
            MOVE.W  (PWIDTH),D5                     
     
            ADD.W   #PMOVE,D5
    
            MOVE.W  (PPOSX),D3
            MOVE.W  #PPOSY+PHEIGHT,D4
            ADD.W   D5,D3
    
            MOVE.W  (PPOSX),D1
            MOVE.W  #PPOSY,D2
           
            ;ADD.W   D5,D2
    
            MOVE.W  #87,D0
            TRAP    #15
    
            MOVEM.L  (A7)+,D0-D5

            RTS
    
PLOTSCR
            MOVEM.L  D0-D4,-(A7)
            
            MOVE.L  #$00FFFFFF,D1  
            MOVE.B  #80,D0
            TRAP    #15
            
            MOVE.B  #84,D0
            MOVE.W  #SCRCTRL,D1
            MOVE.W  #SCRCTRL,D3
            MOVE.W  #0,D2
            MOVE.W  #SCRHEIGH,D4
            TRAP    #15
            
            MOVEM.L  (A7)+,D0-D4
            RTS

PLOTB       
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
*~Font size~16~
*~Tab type~0~
*~Tab size~4~
