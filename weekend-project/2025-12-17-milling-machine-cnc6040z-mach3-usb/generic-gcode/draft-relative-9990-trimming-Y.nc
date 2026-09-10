#99901 = 42     (total in Y to cover)
#99902 = 0.25    (depth Z per cycle, should be multiply to #2)
#99903 = 1.0     (total depth Z)
#99907 = 12000   (spindle speed)
#444 = 60      (inset feed)
#99909 = 900     (trimming feed)

; preamble
G21                                 (mm)
G91                                 (switch to incremental coordinates)

; launch spindle
G1 Z2 F[0 + #444]                 (up to 2 by Z to launch spindle)
M3 S[0 + #99907]                    (turn on spindle)
G1 Z-2 F[0 + #444]                (restore Z-zero position)

; execute sub-program few times
M98 P9990 L[[#99903 / #99902] / 2]  (call sub-program few times)
G0 Z[[#99903 / #99902] * #99902]    (restore Z-zero position)

; finishing
G90                                 (switch to absolute coordinates)
M30                                 (turn off spindle)


O9990 (sub-program)
;
; Trimming by Y
;
; Parameters
;
; #99901 (total in Y to cover)
; #99902 (total depth Z)
; #444 (inset feed)
; #99909 (trimming feed)
;
G1 Z[0 - #99902] F[0 + #444]
G1 Y[0 + #99901] F[0 + #99909]
G1 Z[0 - #99902] F[0 + #444]
G1 Y[0 - #99901] F[0 + #99909]
M99
