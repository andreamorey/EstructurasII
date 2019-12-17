;--------------------------------------------------------------------------
;SCREEN CONTROL
;--------------------------------------------------------------------------
SCTRLINIT
            MOVEM.L D0-D5,-(A7)       
            
            ;DIBUJA LA BARRA DE SEPARACIÓN
            MOVE.L  #$00FFFFFF,D1  ;COLOR
            MOVE.B  #80,D0
            TRAP    #15
            
            AND.L   #$00FFFFFF,D1  ;COLOR
            MOVE.B  #81,D0
            TRAP    #15
            
            MOVE.B  #87,D0
            MOVE.W  #SCRCTRL,D1
            MOVE.W  #SCRCTRL+10,D3
            MOVE.W  #0,D2
            MOVE.W  #SCRHEIGH,D4
            TRAP    #15
            
            ;DIBUJA LAS VIDAS
            MOVE.W  PLIVES,D5
            SUB.W   #1,D5
            MOVE.L  #$00FFFFFF,D1  ;COLOR
            MOVE.B  #80,D0
            TRAP    #15
            
            AND.L   #LIVECOLOR,D1  ;COLOR
            MOVE.B  #81,D0
            TRAP    #15
            
            MOVE.B  #87,D0
            MOVE.W  #SCRCTRL+25,D1
            MOVE.W  D1,D3
            ADD.W   #LIVEWIDTH,D3
            MOVE.W  #30,D2
            MOVE.W  D2,D4
            ADD.W   #LIVEHEIGHT,D4
.LOOP           
            
            
            TRAP    #15
            
            MOVE.W  D3,D1
            ADD.W   #LIVEWIDTH,D3
            
            DBRA    D5,.LOOP
            
            
            MOVEM.L  (A7)+,D0-D5

            RTS


*~Font name~Courier New~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
