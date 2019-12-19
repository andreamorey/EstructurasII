; =============================================================================
; GAME STATE MANAGEMENT
; =============================================================================

; -----------------------------------------------------------------------------
STAINIT
; INITALIZES THE STATE MANAGER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  #STANONE,(STACUR)       ;STACUR = -1 
           ; TENEMOS QUE SABER SI -1 = CAMBIO O SE QUEDA EN EL MISMO
            MOVE.W  #STAINTR,(STANEXT)      ;STAINTR = LA PANTALLA INTRO = 0
            RTS

; -----------------------------------------------------------------------------
STAUPD
; PERFORMS STATE UPDATE AND INIT IF NECESSARY
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0/A0,-(A7)
            CLR.L   D0
            MOVE.W  (STANEXT),D0
            CMP.W   (STACUR),D0
            BEQ     .DOUPD
            MOVE.W  D0,(STACUR)             ;AHORA ES LA PANTALLA DE INTRO
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .INITBL(A0),A0
            JSR     (A0)
.DOUPD      CLR.L   D0                      ; IN ANY CASE, DO UPDATE
            MOVE.W  (STACUR),D0
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .UPDTBL(A0),A0
            JSR     (A0)
            MOVEM.L (A7)+,D0/A0
            RTS
.INITBL     DC.L    STAINTRI,STAPLAYI,STAEMPTY ;EL 0 ES VACIAR LA MEMORIA DEL JUEGO
                                             ;EL 1 ES LO QUE INICIA EL JUEGO = PINIT
                                             ;EL 2 ES NO HACER NADA 
.UPDTBL     DC.L    STAINTRU,STASPACEU,STAPLAYU,STAGOVRU
                                            ;EL 0 ES SI SE PULSA ESPACIO CAMBIAR EL STANEXT A PLAY
                                            ;EL 2 HACE QUE SE UPDATE 

; -----------------------------------------------------------------------------
STAPLOT
; PERFORMS STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0/A0,-(A7)
            CLR.L   D0
            MOVE.W  (STACUR),D0
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .PLTTBL(A0),A0          ;ELIGE QUE HACER
            JSR     (A0)
            MOVEM.L (A7)+,D0/A0
            RTS
.PLTTBL     DC.L    STAINTRP,STAPLAYP,STAPLAYP,STAGOVRP
                           ;SPACE      NIVEL1   NIVEL2    NIVEL3   

; -----------------------------------------------------------------------------
STAEMPTY
; EMPTY SUBROUTINE FOR CASES WITH NOTHING TO DO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A PLACEHOLDER. NOTHING TO DO.
; -----------------------------------------------------------------------------
            RTS

; -----------------------------------------------------------------------------
STAPLAYI    ;DEL NIVEL1, COMIENZO

; PLAY STATE INITIALIZATION.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A WRAPPER FOR PLRINIT
; -----------------------------------------------------------------------------
            JSR     PLRINIT
            JSR     BINIT
            RTS
; -----------------------------------------------------------------------------
STASPACEU
; WAITS FOR SPACE TO BE PRESSED, AND BEGIN THE GAME
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
           
            BTST.B  #KBDBITF1,(KBDEDGE)
            BEQ     .END
            MOVE.W  #STAPLAY,(STANEXT)
.END        
            RTS
                             

; -----------------------------------------------------------------------------
STAPLAYU
; PLAY STATE UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            
            JSR     PLRUPD
            JSR     BLUPD
            JSR     BUPD                    
            RTS
; -----------------------------------------------------------------------------
STAPLAYP
; PLAY STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            JSR     BPLOT
            JSR     BLPLOT
            JSR     PPLOT
            JSR     SCTRLPLOT
            RTS

; -----------------------------------------------------------------------------
STAINTRI                  ;VACIA LA MEMORIA DEL JUEGO
; PARA QUE EL SCORE LA VIDA SE VUELVAN A REINICIAR

; INTRO STATE INIT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A WRAPPER FOR DMMINIT TO RELEASE ALL MEMORY
; -----------------------------------------------------------------------------
            UTLSNDS .SOUND,#1
            JSR     DMMINIT
            RTS
.SOUND      DC.L    'start largo.wav',0
; -----------------------------------------------------------------------------
STAINTRU
; INTRO STATE UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            
            BTST.B  #KBDBITF1,(KBDEDGE)
            BEQ     .END
            UTLSNDST
            MOVE.W  #STASPACE,(STANEXT)
            JSR     BLINIT
            MOVE.W  #PINLIVE,PLIVES
            CLR.W   PSCORE            
.END        RTS

; -----------------------------------------------------------------------------
STAINTRP
; INTRO STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L A1/D0-D2,-(A7)
            ;TITULO
            UTLLOCT INTTITX,INTTITY      
            UTLSIZC #INTTITC,TXBSIZE
            LEA     .TITSTR,A1            
            MOVE.B  #14,D0
            TRAP    #15
            
            ;START
            UTLLOCT INTPRSX,INTPRSY
            UTLSIZC #INTPRSC,TXSSIZE
            LEA     .PRSSTR,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            MOVEM.L (A7)+,A1/D0-D2
            RTS

.TITSTR     DC.B    'Breaking Blocks',0
.PRSSTR     DC.B    'PUSH FIRE TO START',0
            DS.W    0
; -----------------------------------------------------------------------------
STAGOVRU
; GAME OVER STATE UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            BTST.B  #KBDBITF1,(KBDEDGE)
            BEQ     .END
            UTLSNDST
            MOVE.W  #STAINTR,(STANEXT)
.END        RTS

; -----------------------------------------------------------------------------
STAGOVRP
; GAME OVER STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------

            MOVEM.L A1/D0-D2,-(A7)
            
            ;GAME OVER TEXT
            UTLLOCT GOVERX,GOVERY            
            UTLSIZC #GOVERC,TXBSIZE
            LEA     .GOVSTR,A1              ;PONE EL TEXTO
            MOVE.B  #14,D0
            TRAP    #15

            MOVEM.L (A7)+,A1/D0-D2
            RTS
.GOVSTR     DC.B    'GAME OVER',0
            DS.W    0





*~Font name~Courier New~
*~Font size~16~
*~Tab type~0~
*~Tab size~4~
