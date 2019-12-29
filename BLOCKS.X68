;-----------------------------------------------------------
;           BLOCKS
;-----------------------------------------------------------
  
BLINIT

            LEA.L   BLMATRIX,A0
            MOVE.W  #BLROW-1,D0             ;7
.LOOP       
            MOVE.B  #%11111111,(A0)+
            DBRA    D0,.LOOP
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%10000000,(A0)+
            
            MOVE.W  #PINPOSX1,PPOSX
            MOVE.W  #PINWIDTH1,PWIDTH
            
            CLR.W   BLCOUNTER
            MOVE.W  #1,LEVEL
            MOVE.W  #BINSPEED,BSPEEDX
            MOVE.W  #BINSPEED,BSPEEDY
            NEG.W   BSPEEDX
            JMP     BLCONBL
            RTS
BLLEV2           
            
            LEA.L   BLMATRIX,A0
*            MOVE.W  #BLROW-1,D0             
*.LOOP       
*            MOVE.B  #%01011010,(A0)+
*            DBRA    D0,.LOOP

            MOVE.B  #%11111111,(A0)+
            MOVE.B  #%01110111,(A0)+
            MOVE.B  #%01110111,(A0)+
            MOVE.B  #%01110111,(A0)+
            MOVE.B  #%01110111,(A0)+
            MOVE.B  #%01110111,(A0)+
            MOVE.B  #%10111011,(A0)+
            MOVE.B  #%10111011,(A0)+
            MOVE.B  #%10111011,(A0)+
            MOVE.B  #%10111011,(A0)+
            MOVE.B  #%10111011,(A0)+
            MOVE.B  #%11111111,(A0)+ 

*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%10000000,(A0)+

            CLR.W   BLCOUNTER
            
            MOVE.W  #PINPOSX2,PPOSX
            MOVE.W  #PINWIDTH2,PWIDTH

            MOVE.W  #BINSPEED,D0
            SUBQ.W  #1,D0
            
            MOVE.W  D0,BSPEEDX
            MOVE.W  D0,BSPEEDY
            NEG.W   BSPEEDX
            JMP     BLCONBL
            RTS
            
BLLEV3              
            LEA.L   BLMATRIX,A0         
            MOVE.B  #%11110101,(A0)+
            MOVE.B  #%10100101,(A0)+
            MOVE.B  #%10100101,(A0)+
            MOVE.B  #%10100101,(A0)+
            MOVE.B  #%10100101,(A0)+
            MOVE.B  #%11100101,(A0)+
            MOVE.B  #%10100101,(A0)+
            MOVE.B  #%10100101,(A0)+
            MOVE.B  #%10100101,(A0)+
            MOVE.B  #%10100101,(A0)+
            MOVE.B  #%10100101,(A0)+
            MOVE.B  #%11110101,(A0)+

*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%00000000,(A0)+
*            MOVE.B  #%10000000,(A0)+

            CLR.W   BLCOUNTER
            MOVE.W  #PINPOSX3,PPOSX
            MOVE.W  #PINWIDTH3,PWIDTH
            
            MOVE.W  #BINSPEED,D0
            SUBQ.W  #2,D0
            
            MOVE.W  D0,BSPEEDX
            MOVE.W  D0,BSPEEDY
            NEG.W   BSPEEDX
            JMP     BLCONBL
            RTS
            
BLUPD       
            MOVE.W  BLCOUNTER,D0
            CMP     #0,D0                   ;SI NO HAY BLOQUES SALTA
            BEQ     .NEXTLEVEL
            RTS
.NEXTLEVEL  
            
            ADD.W   #1,LEVEL
            MOVE.W  LEVEL,D1
            CMP     #4,D1
            BEQ     .WON
            CMP     #3,D1              
            BEQ     .NIVEL3
            MOVE.W  #STASPACE,(STANEXT)
            JMP     BLLEV2
            RTS
.NIVEL3
            CMP.W   #3,D1
            BNE     .WON
            MOVE.W  #STASPACE,STANEXT
            JMP     BLLEV3 
            RTS
.WON        
            MOVE.W  #STAGOVR,STANEXT  
            RTS          

BLPLOT
            MOVE.B  #80,D0                  ;SET PEN COLOR
            MOVE.L  #0,D1
            TRAP    #15
            
            CLR.W   D2                      ;UPPER Y
            MOVE.W  #BLHEIGHT,D4            ;DOWN Y
            LEA     COLORS,A0
            
            MOVE.W  #BLROW-1,D5    ;DBRA
            MOVE.L  #0,A1                      ;PARA SABER CUAL PONER D6= FILA
            
.LOOP2                                      ;BUCLE DE FILAS
 
            MOVE.B  #81,D0                  ;SET COLOR
            MOVE.L  (A0)+,D1
            TRAP    #15
            
            MOVE.W  #BLWIDTH,D3             ;RIGHT X
            CLR.W   D1                      ;LEFT X
            
            MOVE.W  D5,-(A7)                ;GUARDO EL VALOR DEL DECREMENTO DE LOOP2
            MOVE.W  #BLCOL-1,D5
            MOVE.B  BLMATRIX(A1),D6
.LOOP1                                      ; BUCLE COLUMNAS
            ROL.B   #1,D6
            BCC     .SALTO                  ; SALTA SI CARRY = 0
            
            MOVE.B  #87,D0                  ; DIBUJAMOS EL CUADRADO
            TRAP    #15
.SALTO
            MOVE.W  D3,D1
            ADD.W   #BLWIDTH, D3
;;;
            DBRA    D5,.LOOP1 
            MOVE.W  (A7)+,D5              

            ADDA.W  #1,A1
            MOVE.W  D4,D2
            ADD.W   #BLHEIGHT,D4
            DBRA    D5,.LOOP2
            RTS

BLCONBL
            
            MOVE.W  #BLROW-1,D5    ;DBRA FILAS
            MOVE.L  #0,A1          ;PARA SABER CUAL PONER D6= FILA
            
.LOOP2                                      ;BUCLE DE FILAS            
            MOVE.W  #BLCOL-1,D7                ;DBRA COLUMNAS
            MOVE.B  BLMATRIX(A1),D6
.LOOP1                                      ; BUCLE COLUMNAS
            ROL.B   #1,D6
            BCC     .SALTO                  ; SALTA SI CARRY = 0
            ADD.W   #1,BLCOUNTER
.SALTO
            DBRA    D7,.LOOP1   
            ADDA.L  #1,A1
            DBRA    D5,.LOOP2
            RTS






*~Font name~Courier New~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
