; =============================================================================
; BALL
; =============================================================================

BINIT
            MOVE.W  #BINPOSX,BPOSX
            MOVE.W  #BINPOSY,BPOSY  
            MOVE.W  #BINSPEED,BSPEEDX
            MOVE.W  #BINSPEED,D0
            NEG.W   D0
            MOVE.W  D0,BSPEEDY
            RTS
            
BUPD        
            MOVEM.L D0-D3,-(A7)
            
            
.UP         MOVE.W  BPOSY,D1
            CMP.W   #0,D1
            BGT     .LEFT
            NEG.W   BSPEEDY
            
.LEFT       MOVE.W  BPOSX,D1                ;CHOQUE IZQUIERDA
            CMP.W    #0,D1                 
            BGT     .RIGHT     
            NEG.W   BSPEEDX

.RIGHT     
            MOVE.W  BPOSX,D1
            MOVE.W  #SCRCTRL,D2
            ADD.W   #BWIDTH,D1
            CMP.W    D2,D1
            BLT     .PLRY
            NEG.W   BSPEEDX

.PLRY
            MOVE.W  BPOSY,D1
            ADD.W   #BWIDTH+2,D1
            MOVE.W  #PPOSY,D2
            CMP.W   D1,D2                   ;SI LA Y SE CORRESPONDE
            BGT     .END
            MOVE.W  #BINPOSY,BPOSY
.PLRXLEFT   
            
            MOVE.W  BPOSX,D1
            ADD.W   #BWIDTH/2,D1
            MOVE.W  PPOSX,D2
            CMP.W   D1,D2                   ;MIRAMOS EL IZQUIERDO
            BGE     .DOWN
            
.PLRXMIDDLE 
            MOVE.W  PWIDTH,D3
            LSR.W   #1,D3
            ADD.W   D3,D2
            CMP.W   D1,D2                   ;CENTRO - POS PEL
            BLE     .PLRXRIGHT
           
            NEG.W   BSPEEDY
            MOVE.W  BSPEEDX,D1
            BMI     .PLRXRIGHT
            NEG.W   BSPEEDX
            JMP     .END
            
.PLRXRIGHT 
            MOVE.W  BPOSX,D1           
            ADD.W   D3,D2                   ;COMPARAMOS EL LADO IZQ DE LA PLATAFORMA
            CMP.W   D1,D2                   ;EL DERECHO
            BLE     .DOWN                   
            NEG.W   BSPEEDY
            
            MOVE.W  BSPEEDX,D1
            BPL     .DOWN              ;SI ES POSITIVO SOLO NEGAMOS Y
            NEG.W   BSPEEDX
            JMP     .END

*.PLRYRIGHT     
*            MOVE.W  BPOSY,D1
*            ADD.W   #BWIDTH,D1
*            MOVE.W  #PPOSY,D2
*            CMP.W   D1,D2                   ;SI LA Y SE CORRESPONDE
*            BGT     .PLRXLEFT
.DOWN       
            MOVE.W  BPOSY,D1
            CMP.W   #PPOSY,D1
            BLT     .END
            MOVE.W   #STAGOVR,(STANEXT)
.END            

            MOVE.W  BSPEEDX,D0
            ADD.W   D0,BPOSX
            
            MOVE.W  BSPEEDY,D1
            ADD.W   D1,BPOSY

            MOVEM.L (A7)+,D0-D3
            
            RTS
            
BPLOT       
            MOVEM.L  D0-D5,-(A7)
            ;CONTOUR COLOR
            MOVE.L  #BINCOLOR,D1  
            MOVE.B  #80,D0
            TRAP    #15
    
             ;FILL COLOR
            MOVE.L   #BINCOLOR,D1  
            MOVE.B  #81,D0
            TRAP    #15
 
            ;CIRCLE

            MOVE.W  #BWIDTH,D5 
    
            MOVE.W  BPOSX,D3
            MOVE.W  BPOSY,D4
            MOVE.W  D3,D1
            MOVE.W  D4,D2
            
            ADD.W   D5,D4
            ADD.W   D5,D3
    

            MOVE.B  #88,D0
            TRAP    #15
    
            MOVEM.L  (A7)+,D0-D5

            RTS









*~Font name~Courier New~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
