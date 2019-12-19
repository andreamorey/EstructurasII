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
UTLSND     MACRO
; WRAPPER FOR PLAYING WAV FILE TRAP 15 TASK
; INPUT    - \1 ADDRESS TO STRING WITH NAME OF THE FILE
; OUTPUT   - D0.W=0 IF SOUND NOT PLAYED, NON ZERO IF PLAYED
; MODIFIES - D0,A1
; -----------------------------------------------------------------------------
            LEA     \1, A1             ;PLAY EXPLOSION SOUND
            MOVE.L  #73,D0
            TRAP    #15
            ENDM

; =============================================================================
; UTILITY SUBROUTINES
; =============================================================================
; -----------------------------------------------------------------------------
UTLCHCOLW
; CHECKS COLLISION WITH WALL
; INPUT    - D0.W BPOSX
;            D1.W BPOSY
;            D2.W BSPEEDX
;            D3.W BSPEEDY
;            D4.W BALL DIAMETRE
;            D5.W LIVES 
; OUTPUT   - D2.W = BSPEEDX, 
;          - D3.W = BSPEEDY, 
;          - D5.W = LIVES
;          - D6.W = IF D6 == 4 {COMPROBAR COLISION PLATAFORMA} ELSE{NO COMPROBAR} 
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  #4,D6
            LEA.L   .COLLISIONS,A0
            CMP.W   (A0)+,D1      ;UP
            BGT     .LEFT
            NEG.W   D3
            SUBI.W  #1,D6
            RTS
.LEFT        
            CMP.W   (A0)+,D0
            BGT     .RIGHT
            NEG.W   D2
            SUBI.W  #1,D6
            RTS
.RIGHT      
            ADD.W   D4,D0
            CMP.W   (A0)+,D0
            BLT     .DOWN
            NEG.W   D2
            SUBI.W  #1,D6
            RTS
.DOWN       
            ADD.W   D4,D1 
            CMP.W   (A0)+,D1                ;BPOSY - HEIGHT
            BGT     .MINLIVE1                ;SI HA CAIDO  
            RTS  
.MINLIVE1       
            SUB.W   #1,D5                  
            BNE     .MINLIVE2               
            UTLSND  .SOUND
            MOVE.W  #STAGOVR,(STANEXT)
            SUBI.W  #1,D6
            RTS
.MINLIVE2     
            MOVE.W  #STASPACE,(STANEXT)
            SUBI.W  #1,D6            
            RTS
.COLLISIONS DC.W    0,0,SCRCTRL,SCRHEIGH
.SOUND      DC.L    'game over.wav',0
; -----------------------------------------------------------------------------
UTLCHCOLP
; CHECKS COLLISION WITH PLATAFORM
; INPUT    - D0.W BPOSX
;            D1.W BPOSY
;            D2.W PPOSX
;            D3.W PPOSY
;            D4.W BALL DIAMETRE
;            D5.W LIVES 
; OUTPUT   - D2.W = BSPEEDX, 
;          - D3.W = BSPEEDY, 
;          - D5.W = LIVES
;          - D6.W = IF D6 == 4 {COMPROBAR COLISION PLATAFORMA} ELSE{NO COMPROBAR} 
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            ADD.W   D4,D1
            CMP.W   D1,D3 ;COMPUREBA LA Y

            
            ;AQUI IRIA LA COLISION DE LOS LADOS
            
            
            LSR.W   #1,D4
           ; ADD.W   D4
             
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
