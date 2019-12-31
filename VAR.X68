; =============================================================================
; GAME VARS
; =============================================================================

; TO DO: DECLARE GAME VARIABLES HERE.

; --- GAME STATE RELATED VARIABLES ------------------------------------------

STACUR      DS.W    1                       ; CURRENT GAME STATE
STANEXT     DS.W    1                       ; NEXT GAME STATE
;----------------------------------------------------------------------------

; PLAYER --------------------------------------------------------------------
PPOSX       DS.W    1                       ;POSICION DE LA PLATAFORMA
PWIDTH      DS.W    1                       ; PLAYER WIDTH (PIXELS)
PLIVES      DS.W    1                       ;LIVES LEFT
PSCORE      DS.W    1                       ;SCORE DEL PLAYER
PSPEED      DS.W    1
LEVEL       DS.B    2
PNAME       DS.B    80                      ;NOMBRE CON CARACTERES MAX = 80
            DS.W    0
;----------------------------------------------------------------------------

; BALL ----------------------------------------------------------------------
;BPOSX       DS.W    1                       ;POSICION DE LA PELOTA X
;BPOSY       DS.W    1                       ;POSICION DE LA PELOTA Y
BSPEEDX     DS.W    1                       ;VELOCIDAD DE LA PELOTA
BSPEEDY     DS.W    1
BMXSPEED    DS.W    1                       ;LIMITACIÓN
BCOLOR      DS.W    1
BPOSX1      DS.W    1
BPOSX2      DS.W    1
BPOSY1      DS.W    1
BPOSY2      DS.W    1
; BLOCKS --------------------------------------------------------------------
BLCOUNTER   DS.W    1
BLMATRIX    DS.B    BLROW  ;12*8
            DS.W    0
;ALL SCORES:
ERRORFILE   DS.L    1
POSRNK      DS.L    1
RNKTABLE    DS.B    10

BUFFER      DS.B    80
            DS.W    0
PLSIZE      DS.W    1





*~Font name~Courier New~
*~Font size~16~
*~Tab type~0~
*~Tab size~4~
