;
; Working Z: Z -> Z - #9604
; Use End Mill
;

#9600=1    ; number of facing cycles
#9601=376  ; total facing length in X
#9602=540  ; total facing length in Y
#9603=0.25 ; step over
#9604=0.25 ; depth Z
#9605=540  ; facing feed (steel: 4F/6mm endmill for S6000)

;
G17 G54 G40 G49 G80 G90 G94
G21
;
;
G91                                                                             ; switch to incremental coordinates
G0 Z2
;
M3 S6000
M0 (!!! override spindle speed override to 100Hz/6000RPM)
;
G1 Z-2
G90                                                                             ; switch to absolute coordinates
;
M98 P9600 L[ROUND[#9600]]
G91                                                                             ; switch to incremental coordinates
G01 Z[#9604 * [ROUND[#9600]]]                                                   ; Retract Z
G90                                                                             ; switch to absolute coordinates
;
(stopping spindle)
M05
G17 G54 G90 G80 G40
(bye-bye)
M02


O9600
;
; Round Facing/Pocket by End Mill
;
; Parameters
; #9601 - total facing length in X
; #9602 - total facing length in Y
; #9603 - step over
; #9604 - depth Z
; #9605 - facing feed
; #9606 - internal variable
; #9607 - internal variable
; #9608 - internal variable
; #9609 - internal variable
;
G91                                                                             ; switch to incremental coordinates
G01 Z[0 - #9604] F[#9605/6]                                                     ; Go down to depth Z

#9607 = [FIX[[[#9601 + #9602 - ABS[#9601 - #9602]] / 2] / [#9603 * 2]]]                                              ; Calculate number of turns L
#9608 = #9601                                                                   ; Init dynamic span variables
#9609 = #9602                                                                   ; Init dynamic span variables
#9606 = #9607                                                                   ; Init step-down counter
;
; Here you may reduce some steps according to EndMill diameter
#9607 = [#9607 - 10]   ; reduce cycles for endmill 6mm
;#9607 = [#9607 - 8]    ; reduce cycles for endmill 5mm
;#9607 = [#9607 - 6]    ; reduce cycles for endmill 4mm
;#9607 = [#9607 - 4]    ; reduce cycles for endmill 3mm
;
M98 P9601 L[#9607]                                                              ; Call subprogram calculated times
G01 X#9608 F[#9605]                                                             ; Finish remaining rectangle in center
G01 Y#9609
G01 X[0 - #9608]
G01 Y[0 - #9609]
G00 X[0 - [#9607 * #9603]] Y[0 - [#9607 * #9603]]                               ; Return to origin X0 Y0 from center in G91
G90                                                                             ; switch to absolute coordinates
M99                                                                             ; return from sub-program
;
O9601
#9606 = [#9606 - 1]
G01 X#9608 F[#9605]
G01 Y#9609
G01 X[0 - #9608]
G01 Y[0 - #9609]
G01 X#9603 Y#9603                                                               ; Step in towards center for the next loop
#9608 = [#9608 - [#9603 * 2]]                                                   ; Reduce spans for the next loop
#9609 = [#9609 - [#9603 * 2]]                                                   ; Reduce spans for the next loop
M99
