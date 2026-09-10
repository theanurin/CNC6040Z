( --- Plane milling test, incremental coordinates --- )

#1 = 16      (total width in X to cover)
#2 = 2.00    (step over in X, should be multiple 4 to #1)
#3 = 16      (total height in Y to cover)
#4 = 1.0     (facing depth in Z)

G21         (mm)
G91         (switch to incremental coordinates)
F1800

G0 Z2
M3 S12000   (turn on spindle)
G1 Z-2 F50

G1 Z[0 - #4] F50

; First path we make without X-
G1 Y#3 F600
G1 X#2 F600
G1 Y[0 - #3] F1200
G1 X[0 - #2] F1200
G1 X[#2 * 2] F1200

M98 P1000 L[[[#1 / #2] / 2] - 2] (call sub-program few times)

; Last path we make without X+
G1 Y#3 F1200
G1 X[0 - #2] F1200
G1 X[#2 * 2] F1200
G1 Y[0 - #3] F1200
G1 X[0 - #2] F1200
G1 X#2 F1200

G0 Z#4

G0 Z2
G0 X[0 - [#1 - #2]] Y0 (go to original position)
G1 Z-2 F50  (go to original position)

G90         (switch to absolute coordinates)

M30         (turn off spindle)


; sub-program
O1000
G1 Y#3 F1200
G1 X[0 - #2] F1200
G1 X[#2 * 2] F1200
G1 Y[0 - #3] F1200
G1 X[0 - #2] F1200
G1 X[#2 * 2] F1200
M99
