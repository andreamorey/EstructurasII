; =============================================================================
; TITLE    : EXAMPLE GAME
; AUTHOR   :
; CREATION :
; =============================================================================

            ORG     $1000

; --- CODE INCLUDES -----------------------------------------------------------

            INCLUDE "SYSCONST.X68"          ; SYSTEM CONSTANTS
            INCLUDE "SYSTEM.X68"            ; SYSTEM CODE
            INCLUDE "CONSTANTS.X68"         ;CONSTANTES DEL JUEGO
            INCLUDE "PLAYER.X68"            ;EL JUGADOR
            INCLUDE "PLOT.X68"              ;REPINTAR
            INCLUDE "STATES.X68"            ;
            INCLUDE "BALL.X68"              ;LA PELOTA
            ; TO DO: PUT YOUR GAME-RELATED INCLUDES HERE

; --- INITIALIZE --------------------------------------------------------------
            
START       JSR     SYSINIT
            ; TO DO: CALL GAME INITIALIZATION CODE HERE
            JSR     STAINIT                 ;INICIA LAS PANTALLAS
            ;JSR     PLRINIT
            
            
; --- UPDATE ------------------------------------------------------------------

.LOOP       TRAP    #KBDTRAP                ; READ KEYBOARD
            ;JSR     PLRUPD                      
            JSR     STAUPD                  ; UPDATE DEPENDING ON THE STATE
            ;JSR     BUPD
            ; TO DO: CALL GAME UPDATE CODE HERE

; --- WAIT SYNCH --------------------------------------------------------------

.WINT       TST.B   (SCRINTCT)              ; WAIT FOR INTERRUPT
            BEQ     .WINT
            
            CLR.B   (SCRINTCT)

; --- PLOT --------------------------------------------------------------------
            
            ; TO DO: CALL GAME PLOT CODE HERE
            JSR     STAPLOT
            ;JSR     PLOTSCR
            ;JSR     PLOTP
            ;JSR     PLOTB

            TRAP    #SCRTRAP                ; SHOW GRAPHICS
            BRA     .LOOP
            SIMHALT

; --- VARIABLES ---------------------------------------------------------------

            INCLUDE "SYSVAR.X68"
            INCLUDE "VAR.X68"
            END    START









*~Font name~Courier New~
*~Font size~16~
*~Tab type~0~
*~Tab size~4~
