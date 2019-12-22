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
; WRAPPER FOR STOPPING WAV FILE TRAP 15 TASK
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
*            MOVEM.L D0-D7/A0,-(A7)            
            LSR.W   #4,D1           ;POSY/BLHEIGHT. D1 -> FILA
            MOVE.W  #BLROW-1,D2
            CMP.W   D1,D2           ;SI ESTÁ POR DEBAJO DE LA ÚLTIMA FILA SALTA DIRECTO A END
            BLT     .ENDNOCOLISION                    
            LEA.L   BLMATRIX,A0
            ADDA.L  D1,A0           ;CARGAMOS EN A0 LA DIRECCIÓN DEL BYTE DE LA FILA
                                        
            LSR.W   #6,D0           ;D0 -> COLUMNA 
            MOVE.W  #BLCOL-1,D3                           
            SUB.W   D0,D3           ;D3 -> COLUMNA (DESDE DRCHA) DONDE ESTÁ LA BOLA
            MOVE.W  D3,D7
            BPL     .TEST  
            CLR.L   D3              ;POR SI SALE NEGATIVO LA REAJUSTAMOS
.TEST
            BTST.B  D3,(A0)         ;MIRAMOS EL BIT DONDE ESTA 
            BEQ     .ENDNOCOLISION  ; SALTA SI EN ESA POSICION YA HABIA UN 0

.IZQ        
            LSR.W   #6,D5           ;D5 -> COLUMNA
            MOVE.W  #BLCOL-1,D2
            SUB.W   D5,D2           ;D2 -> COLUMNA (DESDE DERECHA) DONDE ESTA EL PUNTO CONTRARIO (SI 1 ENTONCES 2)
            CMP     D3,D2                  
            BLE     .CHOQUEDOBLE
            NEG.W   BSPEEDX
            
            JMP     .ENDCOLISION    ;  (|)______|  COLISION DELADO IZQUIERDO COLISIONANDO POR LA IZQ DEL NLOQUE 
            



.CHOQUEDOBLE                        ;SI ESTA EN MEDIO DEL BLOQUE  |___()___| COLISION EN MEDIO
                                    ;COMPARAMOS SI LE HA DADO A DOS A LA VEZ |______(|)______|
            CMP     D3,D2
            BEQ     .ENMEDIO
            
            ADDI.W  #BDIAMET/2,D0
            LSR.W   #6,D0
            MOVE.W  #BLCOL-1,D5     ;D1 -> COLUMNA DONDE SE ENCUENTRA EL PUNTO MEDIO DE LA BOLA                         
            
            SUB.W   D0,D5
            BPL     .TEST2  
            CLR.L   D5              ;POR SI SALE NEGATIVO LA REAJUSTAMOS
.TEST2
            
            BTST.B  D5,(A0)         ;MIRAMOS EL BIT DONDE ESTA 
            BEQ     .ENMEDIO
            CMP     D5,D7
            BEQ     .CHOQUEDOBLEIZQ
            NEG.W   BSPEEDY
            JMP     .ENDCOLISION
.CHOQUEDOBLEIZQ
            NEG.W   BSPEEDX
            JMP     .ENDCOLISION

            
.ENMEDIO            
            ;COMPARAMOS SI LA PARTE CONTRARIA ESTA DENTO DEL BLOQUE O FUERA
            CMP     D3,D2
            BLT     .DERECHA
            NEG.W   BSPEEDY
            JMP     .ENDCOLISION
.DERECHA
            NEG.W   BSPEEDX
            JMP     .ENDCOLISION
            

.ENDCOLISION
            MOVE.W  #1,D4
            BCLR    D3,(A0)
            SUB.W   #1,BLCOUNTER       
            ADD.W   #100,PSCORE
            UTLSNDST
            UTLSNDS  .SOUND,#1
            SUB.W   #1,BLCOUNTER
.ENDNOCOLISION
            RTS
*            MOVEM.L (A7)+,D0-D7/A0
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



UTLSCTRLP
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


; -----------------------------------------------------------------------------
UTLWRF    MACRO
; WRAPPER TO WRITE TEXT IN AN EXISTING FILE FROM TRAP 15
; INPUT    - \1 FILENAME, \2 CONTENIDO QUE TIENE QUE ESCRIBIR,  
; OUTPUT   - NONE
; MODIFIES - D0-D2,A1
; -----------------------------------------------------------------------------
            MOVE.B  #50,D0
            TRAP    #15                     ;CIERRA TODOS LOS FICHEROS
            
            LEA     \1,A1
            MOVE.B  #51,D0
            TRAP    #15                     ;ABRE UN FICHERO EXISTENTE, D1 = FILE ID
            ; CON EL 55 HAY QUE POSICIONAR EL FICHERO, SINO SIEMPRE ESCRIBE A PARTIR DEL BYTE 0
            LEA     .BUFFER,A1
            MOVE.W  \2,(A1)                 ;GUARDA EN EL BUFFER
            MOVE.W  #2,D2                   ;BYTES QUE TIENE QUE ESCRIBIR
            MOVE.B  #54,D0                  ;ESCRIBE EL BUFFER EN EL FICHERO
            TRAP    #15                     
            
            MOVE.B  #56,D0
            TRAP    #15                     ;CIERRA EL FICHERO
  
.BUFFERW     DS.B 80
   
            ENDM


; -----------------------------------------------------------------------------
UTLRF    MACRO
; WRAPPER TO READ TEXT FROM AN EXISTING FILE FROM TRAP 15
; INPUT    - \1 FILENAME
; OUTPUT   - NONE
; MODIFIES - D0-D2,A1
; -----------------------------------------------------------------------------
            MOVE.B  #50,D0
            TRAP    #15                     ;CIERRA TODOS LOS FICHEROS

            LEA     \1,A1
            MOVE.B  #51,D0
            TRAP    #15                     ;ABRE UN FICHERO EXISTENTE, D1 = FILE ID

            LEA     .BUFFERR,A1
            MOVE.L  #2,D2                   ;BYTES QUE LEE
            MOVE.B  #53,D0
            TRAP    #15                     ;LEE DEL FICHERO
            
            MOVE.W  (A1),D4
            MOVE.W  D4,D1
            MOVE.B  #3,D0                   ;MUESTRA EL NUMERO EN D1
            
            MOVE.B  #56,D0
            TRAP    #15                     ;CIERRA EL FICHERO

            ENDM



*~Font name~Courier New~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
