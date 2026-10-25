#9701 = 8       (drilling diameter)
#9702 = 6       (end-mill tool diameter, should be lower of equal to #1)
#9703 = 1.25    (depth per cycle, should be multiple to #4)
#9704 = 20      (depth Z)
#9707 = 12000   (spindle speed)
#9709 = 900     (drilling feed)

; preamble
G21                         (mm)

; launch spindle
G91                         (switch to incremental coordinates)
G0 Z2                       (up to 2 by Z to launch spindle)
M3 S[0 + #9707]             (turn on spindle)
G1 Z-2 F[0 + #9708]         (restore Z-zero position)
G90                         (switch to absolute coordinates)

M98 P9700                   ; do work

; finishing
M30                         (turn off spindle)

O9700
;
; Helix Drilling by End Mill
;
; Parameters
;
; #9701 - drilling diameter
; #9702 - end-mill diameter, should be lower of equal to #9701
; #9703 - depth per cycle, should be multiple to #9704
; #9704 - drilling depth Z
; #9709 - drilling(inset) feed
;
G91                                                                             ; switch to incremental coordinates
G0 Z2
G0 X[[#9701 - #9702] / 2] Y0                                                    ; go left to start position
G0 Z-2
M98 P9701 L[#9704 / #9703]                                                      ; call helical interpolation few times to cover Z depth
G3 X0 Y0 I[0 - [[#9701 - #9702] / 2]] J0 F[0 + #9709]                           ; 360 by circle without Z inset
G0 Z[[#9704 / #9703] * #9703]                                                   ; go to original Z position
G0 Z2
G0 X[0 - [[#9701 - #9702] / 2]] Y0                                              ; restore X original position
G0 Z-2
G90                                                                             ; switch to absolute coordinates
M99                                                                             ; return from sub-program
;
O9701                                                                           ; Make one round of circle using helical interpolation
G3 X0 Y0 Z[0 - #9703] I[0 - [[#9701 - #9702] / 2]] J0 F[0 + #9709]              ; helical interpolation
M99                                                                             ; return from sub-program
