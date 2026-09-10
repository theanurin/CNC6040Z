#99801 = 376     (total in X to cover)
#99802 = 0.50    (depth Z per cycle, should be multiply to #2)
#99803 = 1.0     (total depth Z)
#99807 = 12000   (spindle speed)
#99808 = 60      (inset feed)
#99809 = 900     (trimming feed)

; preamble
G21                                 (mm)
G91                                 (switch to incremental coordinates)

; launch spindle
G1 Z2 F[0 + #99808]                 (up to 2 by Z to launch spindle)
M3 S[0 + #99807]                    (turn on spindle)
G1 Z-2 F[0 + #99808]                (restore Z-zero position)

; execute sub-program few times
M98 P9980 L[[#99803 / #99802] / 2]              (call sub-program few times)
G0 Z[[#99803 / #99802] * #99802] F[0 + #99808]  (restore Z-zero position)

; finishing
G90                                 (switch to absolute coordinates)
M30                                 (turn off spindle)


O9980 (sub-program)
;
; Trimming by X
;
; Parameters
;
; #99801 (total in X to cover)
; #99802 (depth Z per cycle, should be multiply to #2)
; #99808 (inset feed)
; #99809 (trimming feed)
;
G1 Z[0 - #99802] F[0 + #99808]
G1 X[0 + #99801] F[0 + #99809]
G1 Z[0 - #99802] F[0 + #99808]
G1 X[0 - #99801] F[0 + #99809]
M99
