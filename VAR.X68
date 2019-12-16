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
;----------------------------------------------------------------------------

; BALL ----------------------------------------------------------------------
BPOSX       DS.W    1                       ;POSICION DE LA PELOTA X
BPOSY       DS.W    1                       ;POSICION DE LA PELOTA Y
BSPEEDX     DS.W    1                       ;VELOCIDAD DE LA PELOTA
BSPEEDY     DS.W    1
BCOLOR      DS.W    1

; BLOCKS --------------------------------------------------------------------
BLMATRIX    DS.B    12  ;12*8



*~Font name~Courier New~
*~Font size~16~
*~Tab type~0~
*~Tab size~4~
