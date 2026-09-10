#1 = 10      (drilling diameter)
#2 = 4       (end-mill diameter, should be lower of equal to #1)
#3 = 0.25    (depth per cycle, should be multiple to #4)
#4 = 2       (depth Z)
#7 = 12000   (spindle speed)
#8 = 50      (inset feed)
#9 = 300     (drilling feed)

; preamble
G21                                             (mm)
G91                                             (switch to incremental coordinates)

; launch spindle
G1 Z2 F[0 + #8]                             (up to 2 by Z to launch spindle)
M3 S[0 + #7]                                (turn on spindle)
G1 Z-2 F[0 + #8]                            (restore Z-zero position)

; execute sub-program few times
M98 P9700

; finishing
G90                                             (switch to absolute coordinates)
M30                                             (turn off spindle)

O9700 (sub-program)
;
; Drilling by End Mill
;
; Parameters
;
; #1 (drilling diameter)
; #2 (end-mill diameter, should be lower of equal to #1)
; #3 (depth per cycle, should be multiple to #97004))
; #4 (depth Z)
; #8 (inset feed)
; #9 (drilling feed)
;

G0 Z2
G0 X[[#1 - #2] / 2] Y0
G0 Z-2
M98 P9701 L[#4 / #3]                                    (call sub-program few times)
G3 X0 Y0 I[0 - [[#1 - #2] / 2]] J0 F[0 + #9]            (360 by circle without Z inset)
G0 Z[[#4 / #3] * #3] F[0 + #8]                          (go to original Z position)
G0 Z2
G0 X[0 - [[#1 - #2] / 2]] Y0
G0 Z-2
M99                                                     ; return from sub-program

O9701 (sub-program)
G3 X0 Y0 Z[0 - #3] I[0 - [[#1 - #2] / 2]] J0 F[0 + #9]  (helical interpolation)
M99                                                     ; return from sub-program
