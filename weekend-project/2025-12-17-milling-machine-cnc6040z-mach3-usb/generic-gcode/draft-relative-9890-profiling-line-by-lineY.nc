#98011 = 376.00   (total width in X)
#98012 = 540.00   (total height in Y)
#98013 = 1.00     (depth Z per cycle, should be multiply to #98013)
#98014 = 5.00     (total depth in Z)
#98017 = 12000    (spindle speed)
#98018 = 60       (inset feed)
#98019 = 900      (trimming feed)

; preamble
G21                                             (mm)
G91                                             (switch to incremental coordinates)

; launch spindle
G1 Z2 F[0 + #98018]                             (up to 2 by Z to launch spindle)
M3 S[0 + #98017]                                (turn on spindle)
G1 Z-2 F[0 + #98018]                            (restore Z-zero position)

; execute sub-program few times
M98 P9801 L[#98014 / #98013]                    (call sub-program few times)
G0 Z[[#98014 / #98013] * #98013] F[0 + #98018]  (go to original position)

; finishing
G90                                             (switch to absolute coordinates)
M30                                             (turn off spindle)


O9801 (sub-program)
;
; Profiling rectangle line by line Y
;
; Parameters
;
; #98011 (width  in X to cover)
; #98012 (height in Y to cover)
; #98013 (depth Z)
; #98018 (inset feed)
; #98019 (profiling feed)
;
G1 Z[0 - #98013] F[0 + #98018]
G1 Y[0 + #98012] F[0 + #98019]
G1 X[0 + #98011] F[0 + #98019]
G1 Y[0 - #98012] F[0 + #98019]
G1 X[0 - #98011] F[0 + #98019]
M99 (end of 9801 sub-program) 
