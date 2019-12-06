; -----------------------------------------------------------------------------
;           PLAYER
; -----------------------------------------------------------------------------
PLRINIT
; INITIALIZES THE PLAYER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
     ;       JSR     BINIT
            MOVE.W  #PINPOSX,PPOSX
            MOVE.W  #PINWIDTH,PWIDTH
            MOVE.W  #PINLIVE,PLIVES
            CLR.W   PSCORE
           
            RTS


; -----------------------------------------------------------------------------

PLRUPD      
            MOVEM.L D1-D2,-(A7)
            
            
            MOVE.B  (KBDVAL),D1  
            ROR.B   #1,D1                   ;IZQUIERDA
            BCC     .RIGHTKEY                  ;CUANDO C = 0
            ;CUANDO PPOSX ES 0 NO TINENE QUE MOVERSE MAS A LA IZQ
            MOVE.W  (PPOSX),D2
            CMP.W    #0,D2
            BLE     .RIGHTKEY
            SUB.W   #PMOVE,(PPOSX)
.RIGHTKEY
            LSR.B   #1,D1                   ;NO NOS IMPORTA EL DE ARRIBA
            ROR.B   #1,D1                   ;
            BCC     .END
            ;CUANDO PPOSX ES IGUAL A SCRWIDTH+PWIDTH NO TIENE QUE MOVERSE A LA DERECHA
            MOVE.W  (PPOSX),D2
            ADD.W   (PWIDTH),D2 
            ADD.W   #PMOVE,D2 
            CMP.W    #SCRCTRL,D2
            BGE     .END
            ADD.W   #PMOVE,(PPOSX)
.END
            MOVEM.L (A7)+,D1-D2
            RTS





*~Font name~Courier New~
*~Font size~16~
*~Tab type~0~
*~Tab size~4~
