#9701 = 10      (drilling diameter)
#9702 = 6       (end-mill diameter, should be lower of equal to #1)
#9703 = 1.25    (depth per cycle, should be multiple to #4)
#9704 = 10      (depth Z)
#9707 = 12000   (spindle speed)
#9709 = 900     (drilling feed)

; preamble
G21                                             (mm)
G91                                             (switch to incremental coordinates)

; launch spindle
G1 Z2 F80                             (up to 2 by Z to launch spindle)
M3 S[0 + #9707]                                (turn on spindle)
G1 Z-2 F80                            (restore Z-zero position)

; execute sub-program few times
M98 P9700

; finishing
G90                                             (switch to absolute coordinates)
M30                                             (turn off spindle)

O9700 (sub-program)
;
; Helix Drilling by End Mill
;
; Parameters
;
; #9701 (drilling diameter)
; #9702 (end-mill diameter, should be lower of equal to #9701)
; #9703 (depth per cycle, should be multiple to #9704))
; #9704 (depth Z)
; #9709 (helix-drilling feed)
;

G0 Z2
G0 X[[#9701 - #9702] / 2] Y0
G0 Z-2
M98 P9701 L[#9704 / #9703]                                                    (call sub-program few times)
G3 X0 Y0 I[0 - [[#9701 - #9702] / 2]] J0 F[0 + #9709]                       (360 by circle without Z inset)
G0 Z[[#9704 / #9703] * #9703] F80                                           (go to original Z position)
G0 Z2
G0 X[0 - [[#9701 - #9702] / 2]] Y0
G0 Z-2
; return from sub-program
M99

O9701 (sub-program)
; Make one round of circle using helical interpolation
G3 X0 Y0 Z[0 - #9703] I[0 - [[#9701 - #9702] / 2]] J0 F[0 + #9709]        (helical interpolation)
; return from sub-program
M99
