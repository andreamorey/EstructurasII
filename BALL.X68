; =============================================================================
; BALL
; =============================================================================
;----------------------------------
BINIT
;INITIALIZE THE BALL
;----------------------------------
            MOVE.W  #BINPOSX,BPOSX1
            MOVE.W  #BINPOSY,BPOSY1
            MOVE.W  #BINPOSX+BDIAMET,BPOSX2
            MOVE.W  #BINPOSX+BDIAMET,BPOSY2
            MOVE.W  #BINSPEED,BSPEEDX
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
            ADD.W   #2,BSPEEDY
            JSR     .X
.NEGY        
            SUB.W   #2,BSPEEDY
.X          
            MOVE.W  BSPEEDX,D0
            BMI     .NEGX 
            ADD.W   #2,BSPEEDX
            JSR     .END
.NEGX       
            SUB.W   #2,BSPEEDX 
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
            JSR     UTLCHCOLW                  
            JSR     UTLCHCOLP
            JMP     .END

            
.PLATAFORMA
            MOVE.W  BPOSY,D1
            ADD.W   #BDIAMET,D1
            MOVE.W  #PPOSY,D2               ;D2-D1
            CMP.W   D1,D2                   ;SI LA Y SE CORRESPONDE
            BGT     .END                    ;SI LA BPOSY+WIDHT ES MAYOR QUE PPOSY,
            
*            ;LADO IZQUIERDO COLISION DERECHA PLATAFORMA
*            MOVE.W  BPOSX,D0
*            ADD.W   #BWIDTH,D0
*            MOVE.W  PPOSX,D1
*            CMP.W   D0,D1                   ;PPOSX-BPOSX
*            BGT     .COLIZQPLAT
*            NEG.W   BSPEEDX
*            SUB.W   #BWIDTH,D1
*            MOVE.W  D1,BPOSX
*            ;LADO DERECHA COLISION IZQ PLATAFORMA
*            MOVE.W  BPOSX,D0
*            JMP     .END
*.COLIZQPLAT
*            MOVE.W  PPOSX,D1
*            MOVE.W  PWIDTH,D2
*            ADD.W   D2,D1
*            CMP.W   D0,D1                   ;PPOSX-BPOSX
*            BLT     .PLRXLEFT
*            NEG.W   BSPEEDX
*            MOVE.W  D1,BPOSX
*            JMP     .END
         
.PLRXLEFT   
            
            MOVE.W  BPOSX,D1
            ADD.W   #BDIAMET,D1
            MOVE.W  PPOSX,D2
            CMP.W   D1,D2                   ;MIRAMOS EL IZQUIERDO
            BGE     .END
            
.PLRXMIDDLE 
            MOVE.W  PWIDTH,D3
            LSR.W   #1,D3
            ADD.W   D3,D2
            CMP.W   D1,D2                   ;CENTRO - POS PEL
            BLE     .PLRXRIGHT
           
            NEG.W   BSPEEDY
            
            MOVE.W  BSPEEDX,D1
            BMI     .END
            NEG.W   BSPEEDX
            JMP     .END
            
.PLRXRIGHT 
            MOVE.W  BPOSX,D1           
            ADD.W   D3,D2                   ;COMPARAMOS EL LADO IZQ DE LA PLATAFORMA
            CMP.W   D1,D2                   ;EL DERECHO
            BLE     .END                   
            NEG.W   BSPEEDY
            
            MOVE.W  BSPEEDX,D1
            BPL     .END              ;SI ES POSITIVO SOLO NEGAMOS Y
            NEG.W   BSPEEDX
            JMP     .END

.END            

            MOVE.W  BSPEEDX,D0
            ADD.W   D0,BPOSX
            
            MOVE.W  BSPEEDY,D1
            ADD.W   D1,BPOSY

            MOVEM.L (A7)+,D0-D6/A0
            
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

            MOVE.W  #BDIAMET,D5 
    
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
