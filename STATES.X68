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
.INITBL     DC.L    STAINTRI,STAPLAYI,STAEMPTYP,STAEMPTYG ;EL 0 ES VACIAR LA MEMORIA DEL JUEGO
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
STAEMPTYP
; EMPTY SUBROUTINE FOR CASES WITH NOTHING TO DO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A PLACEHOLDER. NOTHING TO DO.
; -----------------------------------------------------------------------------
            RTS
; -----------------------------------------------------------------------------
STAEMPTYG
; EMPTY SUBROUTINE FOR CASES WITH NOTHING TO DO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A PLACEHOLDER. NOTHING TO DO.
; -----------------------------------------------------------------------------
            JSR     UTLWRRNK                ;ESCRIBE EN EL TABLE
            JSR     UTLWRFILE               ;ESCRIBIMOS EN EL FICHERO
            RTS

; -----------------------------------------------------------------------------
STAPLAYI    ;DEL NIVEL1, COMIENZO

; PLAY STATE INITIALIZATION.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A WRAPPER FOR PLRINIT
; -----------------------------------------------------------------------------
            MOVEM.L D0-D7/A0-A6,-(A7)
            MOVE.W  #BINPOSX,BPOSX1
            MOVE.W  #BINPOSY,BPOSY2
            MOVE.W  #BINPOSX+BDIAMET,BPOSX2
            MOVE.W  #BINPOSY-BDIAMET,BPOSY1
            MOVEM.L (A7)+,D0-D7/A0-A6
            RTS
; -----------------------------------------------------------------------------
STASPACEU
; WAITS FOR SPACE TO BE PRESSED, AND BEGIN THE GAME
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  #PINPOSX1,PPOSX
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
            MOVEM.L D0-D7/A0-A6,-(A7)
            JSR     PLRUPD
            JSR     BUPD    
            JSR     BLUPD
            ;VISUALIZA RNKTABLE
            
 
            MOVEM.L (A7)+,D0-D7/A0-A6          
            RTS
; -----------------------------------------------------------------------------
STAPLAYP
; PLAY STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D7/A0-A6,-(A7)
            JSR     UTLREADRNK
            JSR     BLPLOT
            JSR     PPLOT
            JSR     BPLOT
            JSR     UTLSCTRLP
            
            MOVEM.L (A7)+,D0-D7/A0-A6 
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
              ;LEE TODOS LOS DATOS DEL FICHERO Y LO GUARDA EN LA TABLA
            JSR     UTLREADFILE
             ;GUARDA EL NOMBRE EN LA MEMORIA
            UTLSVNAME
            JSR     DMMINIT
            
            RTS
; -----------------------------------------------------------------------------
STAINTRU
; INTRO STATE UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D7/A0-A6,-(A7)
            
            BTST.B  #KBDBITF1,(KBDEDGE)
            BEQ     .END
            UTLSNDST
            MOVE.W  #STASPACE,(STANEXT)
            JSR     BLINIT
            MOVE.W  #PINLIVE,PLIVES
            CLR.W   PSCORE            
.END        
            MOVEM.L (A7)+,D0-D7/A0-A6
            RTS

; -----------------------------------------------------------------------------
STAINTRP
; INTRO STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D2/A1,-(A7)
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
            
            UTLSNDS .SOUND,#1
            
            MOVEM.L (A7)+,D0-D2/A1
            RTS
.SOUND      DC.L    'start largo.wav',0
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
            ;visualiza el fichero
            UTLSPEN #$00FFFFFF
            UTLSFIL #$00000000
            LEA.L   PNAME,A1
            MOVE.W  #LIVEPOSX,D1
            MOVE.W  #200,D2
            MOVE.B  #95,D0                   ;IMPRIME LA LINEA EN A1
            TRAP    #15
            
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
            UTLSFIL #$00000000
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
