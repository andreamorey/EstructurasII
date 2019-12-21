; =============================================================================
; CONSTANTS
; =============================================================================

; --- INTRO STATE RELATED CONSTANTS -------------------------------------------

INTTITX     EQU     14                      ; TITLE X COORDINATE
INTTITY     EQU     7                       ; TITLE Y COORDINATE
INTTITC     EQU     $00DCAA7C               ; TITLE COLOR
INTPRSX     EQU     32                      ; PRESS FIRE X COORDINATE
INTPRSY     EQU     82                      ; PRESS FIRE Y COORDINATE
INTPRSC     EQU     $00FFFFFF               ; PRESS FIRE COLOR
TXBSIZE     EQU     18                      ;BIG SIZE LETTERS
TXMSIZE     EQU     16                      ;MEDIUM SIZE LETTERS
TXSSIZE     EQU     10                      ;SMALL SIZE LETTERS

; STATES GAME ---------------------------------------------------------------
STANONE     EQU     -1                      ; PLACEHOLDER TO FORCE CHANGE
STAINTR     EQU     0                       ; INTRO/PRESS FIRE STATE
STASPACE    EQU     1                       ; ESPERA EL ESPACIO PARA DISPARAR LA BOLA 
STAPLAY    EQU     2                       ; NORMAL GAME STATE
;STAPLAY2    EQU     3
;STAPLAY3    EQU     4
STAGOVR     EQU     3                       ; GAME OVER STATE
;----------------------------------------------------------------------------

; --- GAME OVER STATE RELATED CONSTANTS ---------------------------------------

GOVERX      EQU     18                      ; GAME OVER X COORDINATE
GOVERY      EQU     7                       ; GAME OVER Y COORDINATE
GOVERC      EQU     $0000FFFF               ; GAME OVER COLOR

; SCREENCTRL---------------------------------------------------------------------
SCRCTRL     EQU     513   
SCRLWIDTH   EQU     5
LIVEWIDTH   EQU     64
LIVEHEIGHT  EQU     16
LIVECOLOR   EQU     $000000FF               ;ROJO
LIVEPOSX    EQU     SCRCTRL+20
LIVEPOSY    EQU     30

;----------------------------------------------------------------------------


; PLAYER --------------------------------------------------------------------

PINWIDTH1    EQU     64                      ; PLAYER INITIAL WIDTH (PIXELS)
PINWIDTH2    EQU     56
PINWIDTH3    EQU     48
PHEIGHT     EQU     12                      ; PLAYER HEIGHT (PIXELS)
PCOLOR      EQU     $00ECD59D               ; PLAYER NORMAL COLOR
PINLIVE     EQU     3                       ;PLAYER INTIAL LIVES 
PMOVE       EQU     8                       ;SPEED OF THE PLAYER (ALWAYS THE SAME)
PPOSY       EQU     SCRHEIGH-PHEIGHT-4      ;POSICION DE LA PLATAFORMA Y
PINPOSX1     EQU     SCRCTRL/2-PINWIDTH1/2
PINPOSX2     EQU     SCRCTRL/2-PINWIDTH2/2
PINPOSX3     EQU     SCRCTRL/2-PINWIDTH3/2
PSCORETX     EQU    50                       ; SCORE X COORDINATE
PSCORETY     EQU    4                       ; SCORE Y COORDINATE
PSCORECOL   EQU     $00FFFFFF
; ---------------------------------------------------------------------------

; BALL ----------------------------------------------------------------------
BDIAMET     EQU     10                       ;ANCHURA DE LA BOLA
BINPOSX     EQU     SCRCTRL/2-BDIAMET/2     ;POSICION DE LA PELOTA X INICIAL
BINPOSY     EQU     PPOSY-2                 ;POSICION DE LA PELOTA Y INICIAL
BINSPEED    EQU     -5                       ;INITIAL SPEED (HASTA LLEGAR A 500 PUNTOS)

BINCOLOR    EQU     $00FFFFFF

; ---------------------------------------------------------------------------


;BLOCKS-------------------------------------------------------------------------
BLWIDTH     EQU     64
BLHEIGHT     EQU     16
COLORS      DC.L    BLUE,ORANGE,PURPLE,YELLOW,GREEN,BLUE,ORANGE,PURPLE,YELLOW,GREEN,BLUE,ORANGE
BLROW       EQU     12
BLCOL       EQU     8


;-------------------------------------------------------------------------------

;COLORS-------------------------------------------------------------
ORANGE      EQU     $004E8CF3
BLUE        EQU     $00F7E78E
PURPLE      EQU     $00FFACAC
YELLOW      EQU     $0038EEF8
GREEN       EQU     $0095FF8C
;-------------------------------------------------------------------

























*~Font name~Courier New~
*~Font size~16~
*~Tab type~0~
*~Tab size~4~
