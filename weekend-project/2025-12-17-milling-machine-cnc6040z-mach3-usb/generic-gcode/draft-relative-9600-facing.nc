;
; This program makes one Z-push cycle to make facing area
;

( --- Plane milling test, incremental coordinates --- )

#1 = 216     (total width in X to cover)
; Depends on End-mill diameter. 
#2 = 3.00    (step over in X, should be multiple 4 to #1)
#3 = 300     (total height in Y to cover)
#4 = 1.0     (facing depth in Z)

G21         (mm)
G91         (switch to incremental coordinates)
F1800

G0 Z2
M3 S12000   (turn on spindle)
G1 Z-2 F250

G1 Z[0 - #4] F250

; First path we make without X-
G1 Y#3 F900
G1 X#2 F900
G1 Y[0 - #3] F1800
G1 X[0 - #2] F1800
G1 X[#2 * 2] F1800

M98 P9600 L[[[#1 / #2] / 2] - 2] (call sub-program few times)

; Last path we make without X+
G1 Y#3 F1800
G1 X[0 - #2] F1800
G1 X[#2 * 2] F1800
G1 Y[0 - #3] F1800
G1 X[0 - #2] F1800
G1 X#2 F1800

G0 Z#4

G0 Z2
G0 X[0 - [#1 - #2]] Y0 (go to original position)
G1 Z-2 F250  (go to original position)

G90         (switch to absolute coordinates)

M30         (turn off spindle)


; sub-program
O9600
G1 Y#3 F1800
G1 X[0 - #2] F1800
G1 X[#2 * 2] F1800
G1 Y[0 - #3] F1800
G1 X[0 - #2] F1800
G1 X[#2 * 2] F1800
M99
