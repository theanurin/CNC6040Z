#9501 = 376.00   (total width in X)
#9502 = 540.00   (total height in Y)
#9503 = 1.00     (depth Z per cycle, should be multiply to #9503)
#9504 = 5.00     (total depth in Z)
#9505 = 12000    (spindle speed)
#9506 = 60       (inset feed)
#9507 = 900      (trimming feed)

; preamble
G21                                             (mm)
G91                                             (switch to incremental coordinates)

; launch spindle
G1 Z2 F[0 + #9506]                             (up to 2 by Z to launch spindle)
M3 S[0 + #98017]                                (turn on spindle)
G1 Z-2 F[0 + #9506]                            (restore Z-zero position)

; execute sub-program few times
M98 P9801 L[#9504 / #9503]                    (call sub-program few times)
G0 Z[[#9504 / #9503] * #9503]            (go to original position)

; finishing
G90                                             (switch to absolute coordinates)
M30                                             (turn off spindle)

O9500
;
; Profiling rectangle with rounding corner
;
; Parameters
;
; #9501 - final width  in X to cover
; #9502 - final height in Y to cover
; #9503 - profiling depth Z
;
G1 Z[0 - #9503]
G1 Y[0 + #9502]
G1 X[0 + #9501]
G1 Y[0 - #9502]
G1 X[0 - #9501]
M99 ; ; return from sub-program 9500
;
O9501
;
; clean phase
;
G91                                 ; switch to incremental coordinates
G2 X2.0 Y2.0 I2.0 J0.0 Z-0.01875    ; 1/4 arc
G1 X6.0 Y0 Z-0.025                  ; line up
G2 X0.0 Y-4 I0.0 J-2.0 Z-0.0375     ; 1/3 arc
G1 X-6.0 Y0 Z-0.025                 ; line down
G2 X-2.0 Y2.0 I0.0 J2.0 Z-0.01875   ; 1/4 arc
G90                                 ; switch to absolute coordinates
M99                                 ; return from sub-program 9501
