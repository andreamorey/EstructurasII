; =============================================================================
; UTILITY MACROS
; =============================================================================

UTLSPEN     MACRO
; WRAPPER FOR SET PEN TRAP 15 TASK.
; INPUT    - \1 COLOR IN FORMAT $00BBGGRR
; OUTPUT   - NONE
; MODIFIES - D0,D1
; -----------------------------------------------------------------------------
            MOVE.B  #80,D0
            MOVE.L  \1,D1
            TRAP    #15
            ENDM

; -----------------------------------------------------------------------------
UTLSIZC     MACRO
; WRAPPER FOR SET SIZE AND COLOR TRAP 15 TASK.
; INPUT    - \1 COLOR IN FORMAT $00BBGGRR \2 SIZE (8, 9, 10, 12, 14, 16, 18))
; OUTPUT   - NONE
; MODIFIES - D0,D1
; -----------------------------------------------------------------------------
            MOVE.L  \1,D1
            MOVE.L  #\2<<16|1,D2
            MOVE.B  #21,D0
            TRAP    #15
            ENDM
; -----------------------------------------------------------------------------
UTLSFIL     MACRO
; WRAPPER FOR SET FIL TRAP 15 TASK.
; INPUT    - \1 COLOR IN FORMAT $00BBGGRR
; OUTPUT   - NONE
; MODIFIES - D0,D1
; -----------------------------------------------------------------------------
            MOVE.B  #81,D0
            MOVE.L  \1,D1
            TRAP    #15
            ENDM
            
; -----------------------------------------------------------------------------
UTLLOCT     MACRO
; WRAPPER TO TEXT POSITIONNING FROM TRAP 15
; INPUT    - \1 X, \2 Y
; OUTPUT   - NONE
; MODIFIES - D0,D1
; -----------------------------------------------------------------------------
            MOVE.W  #\1<<8|\2, D1
            MOVE.B  #11,D0
            TRAP    #15
            ENDM
   
; -----------------------------------------------------------------------------
UTLSNDS     MACRO
; WRAPPER FOR PLAYING WAV FILE TRAP 15 TASK
; INPUT    - \1 ADDRESS TO STRING WITH NAME OF THE FILE, \2 NUM SOUNDS, 
; OUTPUT   - D0.W=0 IF SOUND NOT PLAYED, NON ZERO IF PLAYED
; MODIFIES - D0,A1
; -----------------------------------------------------------------------------
            LEA     \1, A1             ;PLAY EXPLOSION SOUND
            MOVE.W  \2,D1
            MOVE.B  #71,D0
            TRAP    #15
            MOVE.B  #72,D0
            TRAP    #15
            
            ENDM
            
; -----------------------------------------------------------------------------
UTLSNDST     MACRO
; WRAPPER FOR PLAYING WAV FILE TRAP 15 TASK
; INPUT    - NONE 
; OUTPUT   - D0.W=0 IF SOUND NOT PLAYED, NON ZERO IF PLAYED
; MODIFIES - D0,A1
; -----------------------------------------------------------------------------
            MOVE.L  #3,D2
            MOVE.B  #76,D0
            TRAP    #15
            
            ENDM
            
; =============================================================================
; UTILITY SUBROUTINES
; =============================================================================
; -----------------------------------------------------------------------------
UTLCHCOLW
; CHECKS COLLISION WITH WALL
; INPUT    - D0.W BPOSX1
;            D1.W BPOSY1
;            D2.W BPOSX2
;            D3.W BPOSY2
; OUTPUT   - 
; MODIFIES - 
; -----------------------------------------------------------------------------
            MOVEM.L D0-D3/A0,-(A7)
            LEA.L   .COLLISIONS,A0
            CMP.W   (A0)+,D1      ;UP
            BGT     .LEFT

            NEG.W   BSPEEDY
            CLR.W   BPOSY1
            MOVE.W  #BDIAMET,BPOSY2
            JMP     .END 
.LEFT        
            CMP.W   (A0)+,D0
            BGT     .RIGHT
            NEG.W   BSPEEDX
            CLR.W   BPOSX1
            MOVE.W  #BDIAMET,BPOSX2
            JMP     .END
.RIGHT      
            
            CMP.W   (A0)+,D2
            BLT     .DOWN
            NEG.W   BSPEEDX
            MOVE.W  #SCRCTRL,BPOSX2
            MOVE.W  #SCRCTRL-BDIAMET,BPOSX1
            JMP     .END
.DOWN       
            CMP.W   (A0)+,D3         
            BGT     .MINLIVE                  
            JMP     .END  
.MINLIVE       
            UTLSNDS .SOUNDL,#1
            MOVE.W  #SCRHEIGH,BPOSY2
            MOVE.W  #SCRHEIGH-BDIAMET,BPOSY1 
            SUB.W   #1,PLIVES                
            BNE     .RESET               ;SALTA SI NO SE HAN AGOTADO LAS VIDAS              
            UTLSNDST
            UTLSNDS .SOUNDG,#1
            MOVE.W  #STAGOVR,(STANEXT)
            JMP     .END
.RESET     
            MOVE.W  #STASPACE,(STANEXT)            
.END        
            MOVEM.L (A7)+,D0-D3/A0
            RTS
.COLLISIONS DC.W    0,0,SCRCTRL,SCRHEIGH
.SOUNDG      DC.L    'game over.wav',0
.SOUNDL     DC.L    'lose life.wav',0
; -----------------------------------------------------------------------------
UTLCHCOLP
; CHECKS COLLISION WITH PLATAFORM
; INPUT    - D0.W BPOSX1
;            D1.W BPOSY1
;            D2.W PPOSX2
;            D3.W PPOSY2
; OUTPUT   
;           
; MODIFIES - D4,D5
; -----------------------------------------------------------------------------
            MOVEM.L D4-D5,-(A7)
            MOVE.W  #PPOSY,D4
            CMP.W   D4,D3
            BLT     .END                    ;SI ESTÁ MÁS A ARRIBA DE LA PLATAFORMA NO HAY COLISIÓN
            MOVE.W  PPOSX,D4
            CMP.W   D4,D2
            BLT     .END                    ;SI ESTÁ MÁS A LA IZQUIERDA DE LA PLATAFORMA NO HAY COLISIÓN
            ADD.W   PWIDTH,D4
            CMP.W    D4,D0
            BGT     .END                    ;SI ESTÁ MÁS A LA DERECHA NO HAY COLISIÓN
            ;AQUÍ HAY COLISIÓN, TENEMOS QUE DETECTAR CUAL
            MOVE.W  #PPOSY,D4
            CMP.W   D4,D1
            BGT     .LADOS
            NEG.W   BSPEEDY                 ;COLISIÓN CON LA PARTE DE ARRIBA
            MOVE.W  D4,BPOSY2
            SUB.W   #BDIAMET,D4
            MOVE.W  D4,BPOSY1       
.PLRXMIDDLE 
            MOVE.W  PWIDTH,D4
            LSR.W   #1,D4
            MOVE.W  PPOSX,D5 
            ADD.W   D4,D5                   ;D5 = CENTRO PLATAFORMA
            CMP.W   D2,D5                   ;CENTRO - POS PEL
            BMI     .PLRXRIGHT
            MOVE.W  BSPEEDX,D4
            BMI     .END
                                         
            NEG.W   D4
            MOVE.W  D4,BSPEEDX
            JMP     .END
            
.PLRXRIGHT             
            MOVE.W  BSPEEDX,D4
            BPL     .END              ;SI ES POSITIVO SOLO NEGAMOS Y
            NEG.W   D4
            MOVE.W  D4,BSPEEDX
            JMP     .END

.LADOS      NEG.W   BSPEEDX                 ;COLISIÓN CON LOS LADOS
.END        MOVEM.L (A7)+,D4-D5 
            RTS


; -----------------------------------------------------------------------------
UTLCOLBL   
; CHECKS COLLISION WITH BLOCKS
; INPUT    - POSITION BALL \1 X \2 Y TO CHECK COLLISION WITH BLOCK
; OUTPUT   
;           
; MODIFIES - NONE
; -----------------------------------------------------------------------------
*            MOVEM.L D0-D3,-(A7)            
            LSR.L  #4,D1                    ;POSY/BLHEIGHT. D1 -> FILA
            MOVE.W  #BLROW-1,D2
            CMP.W   D1,D2                   ;SI ESTÁ POR DEBAJO DE LA ÚLTIMA FILA SALTA DIRECTO A END
            BLT     .END                    
            LEA.L   BLMATRIX,A0
            ADDA.L  D1,A0                   ;CARGAMOS EN A0 LA DIRECCIÓN DEL BYTE DE LA FILA
                                        
            LSR.L  #6,D0                    ;D0 -> COLUMNA 
            MOVE.W  #BLCOL-1,D3                           
            SUB.W   D0,D3                   ;D3 -> COLUMNA (DESDE DRCHA) DONDE ESTÁ LA BOLA
            BPL     .TEST  
            CLR.L   D3                        ;POR SI SALE NEGATIVO LA REAJUSTAMOS
.TEST
            BTST.B  D3,(A0)                 ;MIRAMOS EL BIT DONDE ESTA 
            BEQ     .END                    ;SALTA SI EN ESA POSICION YA HABIA UN 0
*            NEG.W   BSPEEDY                 ;****
*            BCLR    D3,(A0)                 ;****
            MOVE.W  BPOSX1,D2
            LSL.L   #6,D0                   ;COORDENADA IZQUIERDA DEL BLOQUE
            CMP     D2,D0
            BLT     .RIGHT
            NEG.W   BSPEEDX
            JMP     .COLBL
.RIGHT      MOVE.W  BPOSX2,D2
            LSL.L   #1,D0
            CMP     D2,D0                   ;POSBLOQUE - POS X (DERECHA) DE LA BOLA 
            BGT     .NEGY                   ;5-7= -2 
            NEG.W   BSPEEDX
            JMP     .COLBL
.NEGY       NEG.W   BSPEEDY
            
.COLBL
            MOVE.W  #1,D4
            BCLR    D3,(A0)
            SUB.W   #1,BLCOUNTER
            UTLSNDS  .SOUND,#1
            ADD.W   #100,PSCORE
                                
.END            
*            MOVEM.L (A7)+,D0-D3/A0
            RTS
.SOUND      DC.L    'blocks.wav',0
; -----------------------------------------------------------------------------
UTLCHCOL
; CHECKS COLLISION
; INPUT    - D0.W X0 COORDINATE ball
;            D1.W Y0 COORDINATE ball
;            D2.W X1 COORDINATE plataforma
;            D3.W Y1 COORDINATE plataforma
;            D4.W WIDTH 0      ball
;            D5.W WIDTH 1      plataforma 
;            D6.W HEIGHT 0     ball
;            D7.W HEIGHT 1     plataforma
; OUTPUT   - D0.B=FF - COLLISION, =0 - NO COLLISION
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.W D4-D7,-(A7)
            ADD.W   D0,D4
            CMP.W   D2,D4
            BLE     .NOCOL
            ADD.W   D2,D5
            CMP.W   D0,D5
            BLE     .NOCOL
            ADD.W   D1,D6
            CMP.W   D3,D6
            BLE     .NOCOL
            ADD.W   D3,D7
            CMP.W   D1,D7
            BLE     .NOCOL
            MOVE.B  #$FF,D0
            BRA     .END
.NOCOL      CLR.B   D0
.END        MOVEM.W (A7)+,D4-D7
            RTS








*~Font name~Courier New~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
