; =============================================================================
; CONSTANTS
; =============================================================================

; --- PLAYER RELATED CONSTANTS ------------------------------------------------





;PLRINIEN    EQU     500                     ; PLAYER INITIAL ENERGY (<SCRWIDTH)
;PLRSPEED    EQU     7                       ; PLAYER SPEED (PIXELS PER INT)

;PLRDMGCL    EQU     $00FFFFFF               ; PLAYER DAMAGED COLOR
;PLRTXTCL    EQU     $00FFFFFF               ; FONT COLOR
;PLRTXTX     EQU     65                       ; SCORE X COORDINATE
;PLRTXTY     EQU     10                       ; SCORE Y COORDINATE
;PLRLIFEH    EQU     20                      ; HEIGHT OF LIFE BAR
;PLRLIFEY    EQU     SCRHEIGH-PLRLIFEH*2     ; LIFE BAR Y POS
;PLRLIFEC    EQU     $000000FF               ; LIFE BAR COLOR
;PLRUMDMG    EQU     %00000001               ; UPDATE DAMAGE MASK
;PLRPMDMG    EQU     %00000010               ; PLOT DAMAGE MASK
;PLRUBDMG    EQU     0                       ; UPDATE DAMAGE BIT
;PLRPBDMG    EQU     1                       ; PLOT DAMAGE BIT


; --- INTRO STATE RELATED CONSTANTS -------------------------------------------

INTTITX     EQU     8                      ; TITLE X COORDINATE
INTTITY     EQU     7                       ; TITLE Y COORDINATE
INTTITC     EQU     $00DCAA7C               ; TITLE COLOR
INTPRSX     EQU     23                      ; PRESS FIRE X COORDINATE
INTPRSY     EQU     50                      ; PRESS FIRE Y COORDINATE
INTPRSC     EQU     $00FFFFFF               ; PRESS FIRE COLOR

; STATES GAME ---------------------------------------------------------------
STANONE     EQU     -1                      ; PLACEHOLDER TO FORCE CHANGE
STAINTR     EQU     0                       ; INTRO/PRESS FIRE STATE
STAPLAY     EQU     1                       ; NORMAL GAME STATE
STAGOVR     EQU     2                       ; GAME OVER STATE
;----------------------------------------------------------------------------

; --- GAME OVER STATE RELATED CONSTANTS ---------------------------------------

GOVSTRX     EQU     35                      ; TITLE X COORDINATE
GOVSTRY     EQU     15                      ; TITLE Y COORDINATE
GOVSTRC     EQU     $00FFFFFF               ; TITLE COLOR




; SCREENCTRL---------------------------------------------------------------------
SCRCTRL     EQU     SCRWIDTH/2+SCRWIDTH/6   ;
;----------------------------------------------------------------------------


; PLAYER --------------------------------------------------------------------

PINWIDTH    EQU     100                      ; PLAYER INITIAL WIDTH (PIXELS)
PHEIGHT     EQU     20                      ; PLAYER HEIGHT (PIXELS)
PCOLOR      EQU     $00ECD59D               ; PLAYER NORMAL COLOR
PINLIVE     EQU     3                       ;PLAYER INTIAL LIVES 
PMOVE       EQU     15                       ;SPEED OF THE PLAYER (ALWAYS THE SAME)
PPOSY       EQU     SCRHEIGH-PHEIGHT-10      ;POSICION DE LA PLATAFORMA Y
PINPOSX     EQU     SCRCTRL/2-PINWIDTH/2
; ---------------------------------------------------------------------------

; BALL ----------------------------------------------------------------------
BHEIGHT     EQU     5                       ;ALTURA DE LA BOLA
BWIDTH      EQU     5                       ;ANCHURA DE LA BOLA
BINPOSX     EQU     PINPOSX+PINWIDTH/2-BWIDTH                      ;POSICION DE LA PELOTA X INICIAL
BINPOSY     EQU     PPOSY-PHEIGHT              ;POSICION DE LA PELOTA Y INICIAL
BINSPEED    EQU     5                       ;INITIAL SPEED (HASTA LLEGAR A 500 PUNTOS)
BINCOLOR    EQU     $00FFFFFFF
; ---------------------------------------------------------------------------






*~Font name~Courier New~
*~Font size~16~
*~Tab type~0~
*~Tab size~4~
