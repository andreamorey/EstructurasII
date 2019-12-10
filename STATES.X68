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
.INITBL     DC.L    STAINTRI,STAPLAYI,STAEMPTY     ;EL 0 ES VACIAR LA MEMORIA DEL JUEGO
                                             ;EL 1 ES LO QUE INICIA EL JUEGO = PINIT
                                             ;EL 2 ES NO HACER NADA 
.UPDTBL     DC.L    STAINTRU,STAPLAYU,STAGOVRU
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
.PLTTBL     DC.L    STAINTRP,STAPLAYP,STAGOVRP
                                             ; EL 0 ES DIBUJAR LA PANTALLA DE INICIO

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
STAPLAYI    EQU     PLRINIT
; PLAY STATE INITIALIZATION.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A WRAPPER FOR PLRINIT
; -----------------------------------------------------------------------------
           
; -----------------------------------------------------------------------------
STAPLAYU
; PLAY STATE UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            JSR     PLRUPD
            JSR     BUPD                    
            RTS
; -----------------------------------------------------------------------------
STAPLAYP
; PLAY STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)
            JSR     PPLOT
            JSR     BPLOT

      
                        
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

; -----------------------------------------------------------------------------
STAINTRI    EQU     DMMINIT                 ;VACIA LA MEMORIA DEL JUEGO
; PARA QUE EL SCORE LA VIDA SE VUELVAN A REINICIAR

; INTRO STATE INIT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A WRAPPER FOR DMMINIT TO RELEASE ALL MEMORY
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
STAINTRU
; INTRO STATE UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            BTST.B  #KBDBITF1,(KBDEDGE)
            BEQ     .END
            MOVE.W  #STAPLAY,(STANEXT)
.END        RTS

; -----------------------------------------------------------------------------
STAINTRP
; INTRO STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L A1/D0-D1,-(A7)
            MOVE.W  #INTTITX<<8|INTTITY, D1 ;COORDENADAS DEL TEXTO TITULO
            MOVE.B  #11,D0
            TRAP    #15
            
            MOVE.L  #INTTITC,D1
            MOVE.L  #18<<16|1,D2
            MOVE.B  #21,D0
            TRAP    #15

            LEA     .TITSTR,A1              ;PONE EL TEXTO
            MOVE.B  #14,D0
            TRAP    #15

            MOVE.W  #INTPRSX<<8|INTPRSY, D1 ;COORDENADAS DEL TEXTO START
            MOVE.B  #11,D0
            TRAP    #15
            
            MOVE.L  #INTPRSC,D1
            MOVE.L  #10<<16|1,D2
            MOVE.B  #21,D0
            TRAP    #15
            
            LEA     .PRSSTR,A1
            MOVE.B  #14,D0
            TRAP    #15
            MOVEM.L (A7)+,A1/D0-D1
            RTS

.TITSTR     DC.B    '   Breaking Blocks   ',0
.PRSSTR     DC.B    ' PUSH FIRE TO START ',0
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
            MOVE.W  #STAINTR,(STANEXT)
.END        RTS

; -----------------------------------------------------------------------------
STAGOVRP
; GAME OVER STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L A1/D0-D1,-(A7)
            MOVE.W  #GOVSTRX<<8|GOVSTRY, D1 ;COORDENADAS DEL TEXTO TITULO
            MOVE.B  #11,D0
            TRAP    #15
            
            MOVE.B  #80,D0                  ;DEFINIMOS COLOR DE TITULO
            MOVE.L  #GOVSTRC,D1
            TRAP    #15
            
            MOVE.B  #81,D0                  ;RELLENA COLOR 
            MOVE.L  #$00FF0000,D1
            TRAP    #15
            
            LEA     .GOVSTR,A1
            MOVE.B  #14,D0
            TRAP    #15
            MOVEM.L (A7)+,A1/D0-D1
            RTS

.GOVSTR     DC.B    'GAME  OVER',0
            DS.W    0





*~Font name~Courier New~
*~Font size~16~
*~Tab type~0~
*~Tab size~4~
