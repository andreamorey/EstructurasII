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
            
            ;VIDAS
            
            MOVE.L  #$00FFFFFF,D1  ;COLOR
            MOVE.B  #80,D0
            TRAP    #15
            
            AND.L   #LIVECOLOR,D1  ;COLOR
            MOVE.B  #81,D0
            TRAP    #15
            MOVE.W  PLIVES,D5
            BEQ     .END
            SUB.W   #1,D5                   ;DBRA 
            
            MOVE.B  #87,D0
            MOVE.W  #LIVEPOSX,D1
            MOVE.W  D1,D3
            ADD.W   #LIVEWIDTH,D3
            MOVE.W  #LIVEPOSY,D2
            MOVE.W  D2,D4
            ADD.W   #LIVEHEIGHT,D4
.LOOP           
            TRAP    #15
            MOVE.W  D3,D1
            ADD.W   #LIVEWIDTH,D3
            DBRA    D5,.LOOP
.END
            ;SCORE
            

            MOVE.W  #PSCORETX<<8|PSCORETY, D1 ;COORDENADAS DEL TEXTO TITULO
            MOVE.B  #11,D0
            TRAP    #15
            
            MOVE.L  #PSCORECOL,D1           ;PENCOLOR Y TAMAÑO
            MOVE.L  #16<<16|1,D2
            MOVE.B  #21,D0
            TRAP    #15
            
            MOVE.L  #$00000000,D1           ;COLOR FONDO
            MOVE.B  #81,D0
            TRAP    #15

            LEA     .TXTSCORE,A1              ;PONE EL TEXTO
            CLR.L   D1
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
