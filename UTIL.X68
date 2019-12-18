;-------------------------
; UTIL
;---------------------------


; -----------------------------------------------------------------------------
UTLSND     MACRO
; WRAPPER FOR PLAYING WAV FILE TRAP 15 TASK
; INPUT    - \1 ADDRESS TO STRING WITH NAME OF THE FILE
; OUTPUT   - D0.W=0 IF SOUND NOT PLAYED, NON ZERO IF PLAYED
; MODIFIES - D0,A1
; -----------------------------------------------------------------------------
            LEA     \1, A1             ;PLAY EXPLOSION SOUND
            MOVE.L  #73,D0
            TRAP    #15
            ENDM
*~Font name~Courier New~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
