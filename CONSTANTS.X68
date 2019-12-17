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

INTTITX     EQU     14                      ; TITLE X COORDINATE
INTTITY     EQU     7                       ; TITLE Y COORDINATE
INTTITC     EQU     $00DCAA7C               ; TITLE COLOR
INTPRSX     EQU     32                      ; PRESS FIRE X COORDINATE
INTPRSY     EQU     82                      ; PRESS FIRE Y COORDINATE
INTPRSC     EQU     $00FFFFFF               ; PRESS FIRE COLOR


; STATES GAME ---------------------------------------------------------------
STANONE     EQU     -1                      ; PLACEHOLDER TO FORCE CHANGE
STAINTR     EQU     0                       ; INTRO/PRESS FIRE STATE
STASPACE    EQU     1                       ; ESPERA EL ESPACIO PARA DISPARAR LA BOLA 
STAPLAY     EQU     2                       ; NORMAL GAME STATE
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

;----------------------------------------------------------------------------


; PLAYER --------------------------------------------------------------------

PINWIDTH    EQU     64                      ; PLAYER INITIAL WIDTH (PIXELS)
PHEIGHT     EQU     12                      ; PLAYER HEIGHT (PIXELS)
PCOLOR      EQU     $00ECD59D               ; PLAYER NORMAL COLOR
PINLIVE     EQU     3                       ;PLAYER INTIAL LIVES 
PMOVE       EQU     8                       ;SPEED OF THE PLAYER (ALWAYS THE SAME)
PPOSY       EQU     SCRHEIGH-PHEIGHT-4      ;POSICION DE LA PLATAFORMA Y
PINPOSX     EQU     SCRCTRL/2-PINWIDTH/2
; ---------------------------------------------------------------------------

; BALL ----------------------------------------------------------------------
BHEIGHT     EQU     8                       ;ALTURA DE LA BOLA
BWIDTH      EQU     8                       ;ANCHURA DE LA BOLA
BINPOSX     EQU     PINPOSX+PINWIDTH/2-BWIDTH                      ;POSICION DE LA PELOTA X INICIAL
BINPOSY     EQU     PPOSY-BHEIGHT              ;POSICION DE LA PELOTA Y INICIAL
BINSPEED    EQU     4                       ;INITIAL SPEED (HASTA LLEGAR A 500 PUNTOS)
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
