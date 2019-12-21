; =============================================================================
; BALL
; =============================================================================
;----------------------------------
BINIT
;INITIALIZE THE BALL
;----------------------------------
            MOVE.W  #BINPOSX,BPOSX1
            MOVE.W  #BINPOSY,BPOSY2
            MOVE.W  #BINPOSX+BDIAMET,BPOSX2
            MOVE.W  #BINPOSY-BDIAMET,BPOSY1
            MOVE.W  #BINSPEED,D0
            NEG.W   D0
            MOVE.W  D0,BSPEEDX
            MOVE.W  #BINSPEED,BSPEEDY
            RTS
;----------------------------------         
BNXTLEV
;INITIALIZE THE BALL TO THE NEXT LEVEL
;----------------------------------
;BALL NEXT LEVEL       (NEXT LEVEL)
            MOVEM.L D0,-(A7)
            MOVE.W  #BINPOSX,BPOSX1
            MOVE.W  #BINPOSY,BPOSY1
            MOVE.W  #BINPOSX+BDIAMET,BPOSX2
            MOVE.W  #BINPOSX+BDIAMET,BPOSY2
            MOVE.W  BSPEEDY,D0
            BMI     .NEGY
            ADD.W   #1,BSPEEDY
            JSR     .X
.NEGY        
            SUB.W   #1,BSPEEDY
.X          
            MOVE.W  BSPEEDX,D0
            BMI     .NEGX 
            ADD.W   #1,BSPEEDX
            JSR     .END
.NEGX       
            SUB.W   #1,BSPEEDX 
.END        
            MOVEM.L (A7)+,D0
            RTS
      
;-----------------------------------------------------------------------------
BUPD
;UPDATES THE BALL
;-----------------------------------
; UPDATES THE BALL MOTION
; INPUT    - NONE 
; OUTPUT   - NONE 
; MODIFIES - NONE
; -----------------------------------------------------------------------------

            MOVEM.L D0-D6/A0,-(A7)
            ;COMPRUEBA COLISIONES CON LAS 4 PAREDES
            ;Y SI PASA LA DE ABAJO LE ELIMINA UNA VIDA, O ENVIA LA PANTALLA GAME OVER
            MOVE.W  BPOSX1,D0
            MOVE.W  BPOSY1,D1
            MOVE.W  BPOSX2,D2
            MOVE.W  BPOSY2,D3
            JSR     UTLCHCOLW               ;COMPRUEBA COLISIÓN CON PAREDES               
            JSR     UTLCHCOLP               ;COMPRUEBA COLISIÓN CON PLATAFORMA
            CLR.L  D4
            JSR     UTLCOLBL
            CMP     #1,D4
            BEQ     .END
            MOVE.W  BPOSX2,D0
            MOVE.W  BPOSY1,D1
            JSR     UTLCOLBL
            CMP     #1,D4
            BEQ     .END
            MOVE.W BPOSX1,D0
            MOVE.W BPOSY2,D1
            JSR     UTLCOLBL
            CMP     #1,D4
            BEQ     .END
            MOVE.W BPOSX2,D0
            MOVE.W BPOSY2,D1
            JSR     UTLCOLBL   

.END            

            MOVE.W  BSPEEDX,D0              ;POSICIÓN = POSICIÓN + VELOCIDAD
            ADD.W   D0,BPOSX1
            ADD.W   D0,BPOSX2
            
            MOVE.W  BSPEEDY,D1
            ADD.W   D1,BPOSY1
            ADD.W   D1,BPOSY2
            MOVEM.L (A7)+,D0-D6/A0
            
            RTS

BPLOT       
            MOVEM.L  D0-D4,-(A7)
            ;CONTOUR COLOR
            MOVE.L  #BINCOLOR,D1  
            MOVE.B  #80,D0
            TRAP    #15
    
             ;FILL COLOR
            MOVE.L   #BINCOLOR,D1  
            MOVE.B  #81,D0
            TRAP    #15
 
            ;CIRCLE

            MOVE.W  BPOSX1,D1
            MOVE.W  BPOSY1,D2
            MOVE.W  BPOSX2,D3
            MOVE.W  BPOSY2,D4
            MOVE.B  #88,D0
            TRAP    #15
    
            MOVEM.L  (A7)+,D0-D4

            RTS


























*~Font name~Courier New~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
