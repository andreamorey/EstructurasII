;--------------------------------------------------------------------------
;SCREEN CONTROL
;--------------------------------------------------------------------------
SCTRLINIT
            MOVEM.L D0-D4,-(A7)       
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
            
            MOVEM.L  (A7)+,D0-D4

            RTS
*~Font name~Courier New~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
