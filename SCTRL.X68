;--------------------------------------------------------------------------
;SCREEN CONTROL
;--------------------------------------------------------------------------


SCTRLPLOT
            MOVEM.L D0-D5/A1,-(A7)       
            
            ;DIBUJA LA BARRA DE SEPARACIÓN
            MOVE.L  #$00FFFFFF,D1  ;COLOR
            MOVE.B  #80,D0
            TRAP    #15
            
            AND.L   #$00FFFFFF,D1  ;COLOR
            MOVE.B  #81,D0
            TRAP    #15
            
            MOVE.B  #87,D0
            MOVE.W  #SCRCTRL,D1
            MOVE.W  #SCRCTRL+SCRLWIDTH,D3
            CLR.L   D2
            MOVE.W  #SCRHEIGH,D4
            TRAP    #15
            
            ;SCORE
            

            UTLLOCT PSCORETX,PSCORETY            
            UTLSIZC #PSCORECOL,TXMSIZE           ;PENCOLOR Y TAMAÑO
            UTLSFIL #$00000000
            LEA     .TXTSCORE,A1              ;PONE EL TEXTO
            MOVE.W  PSCORE,D1
            MOVE.B  #17,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D5/A1
            RTS   


.TXTSCORE   DC.B    'SCORE: ',0
            DS.W    0


*~Font name~Courier New~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
