;-----------------------------------------------------------
;           BLOCKS
;-----------------------------------------------------------
  
BLINIT
            MOVEM.L D0/A0,-(A7)
            LEA.L   BLMATRIX,A0
            MOVE.W  #BLROW-1,D0
.LOOP       
            MOVE.B  #%11111111,(A0)+
            DBRA    D0,.LOOP
            MOVEM.L (A7)+,D0/A0
            RTS
            
BLUPD       
            MOVEM.L D0-D3/A0,-(A7)
            MOVE.W BPOSX,D0
            ADD.W #BWIDTH/2,D0              ;POSICIÓN CENTRAL X DE LA BOLA
            ;MOVE.W #BLROW*BLHEIGHT,D1       ;PARTE INFERIOR DEL BLOQUE ÚLTIMA FILA
            CLR.L   D2
            MOVE.W  BPOSY,D2
            DIVU.W  #BLHEIGHT,D2            ;BPOSY/BLHEIGHT. FILA EN LA QUE ESTA LA BOLA
            
            MOVE.W  #BLROW-1,D3
            CMP.W   D2,D3                   ;SI ESTÁ POR DEBAJO DE LA ÚLTIMA FILA SALTA DIRECTO A END
            BLT     .END                    
            LEA.L   BLMATRIX,A0
            ADDA.L  #BLROW-1,A0
            MULU.W  #BLHEIGHT,D2
            ;MOVE.W  D2,BPOSY                ;OBTENEMOS EN QUE COLUMNA ESTA
            DIVU.W  #BLWIDTH,D0  ;D0 = DE 0 A 7 DEPENDIENDO DE LA COLUMNA
            
            MOVE.W  #BLCOL-1,D1     ;EMPIEZA DESDE LA DERECHA              
            SUB.W   D0,D1
            BTST.B    D1,(A0)                 ;MIRAMOS EL BIT DONDE ESTA 
            BEQ     .END                    ;SALTA SI EN ESA POSICION YA HABIA UN 0
            
*            CMP.W   D1,D2                     ;MIRAMOS SI SON IGUALES LA Y DE LA BOLA CON EL BLOQUE
*            BGT     .END    
            NEG.W   BSPEEDY
                                            ;COLUMNA DEL BLOQUE QUE HA COLISIONADO
            
*            LEA.L   BLMATRIX,A0
*            ADDA.L  #BLROW-1,A0             ;LE PASAMOS LA DIRECCIÓN DE LA ÚLTIMA FILA 
*            MOVE.W  #BLCOL-1,D1                   
*            SUB.W   D0,D1
            BCLR    D1,(A0)
;;;ANDREA: EL RECTANGULO 7 ES EL 0, EL 6 EL 1, EL 5 EL 2...
            

.END        MOVEM.L (A7)+,D0-D3/A0
            RTS     
            
            
BLPLOT
            MOVEM.L D0-D7/A0-A1,-(A7)
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
                                      ;BUCLE FILAS
            
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
            ADDI.W  #1,D7
            DBRA    D5,.LOOP1 
            MOVE.W  (A7)+,D5              

            ADDA.W  #1,A1
            MOVE.W  D4,D2
            ADD.W   #BLHEIGHT,D4
            DBRA    D5,.LOOP2
            MOVEM.L (A7)+,D0-D7/A0-A1
            RTS







*~Font name~Courier New~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
