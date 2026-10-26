;
; Working Z: Z -> Z - #9604
; Use End Mill
;

#9601=160  ; total facing length in X
#9602=16   ; total facing length in Y
#9603=0.25 ; step over
#9604=0.2  ; depth Z
#9609=360  ; facing feed (steel: 4F/6mm endmill for S6000)

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
M98 P9600
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
; #9609 - facing feed
;
G91                                                                             ; switch to incremental coordinates
G01 Z[0 - #9604] F[#9609/6]                                                     ; Go down to depth Z
#9605 = [[#9601 + #9602 - ABS[#9601 - #9602]] / 2]                              ; Find short side
#9606 = [FIX[#9605 / [#9603 * 2]]]                                              ; Calculate number of turns L
#9610 = #9601                                                                   ; Init dynamic span variables
#9611 = #9602                                                                   ; Init dynamic span variables
M98 P9601 L[#9606]                                                              ; Call subprogram calculated times
G01 X#9610 F[#9609]                                                             ; Finish remaining rectangle in center
G01 Y#9611
G01 X[0 - #9610]
G01 Y[0 - #9611]
G01 Z#9604                                                                      ; Retract Z
#9607 = [#9606 * #9603]                                                         ; Return to origin X0 Y0 from center in G91
G00 X[0 - #9607] Y[0 - #9607]
G90                                                                             ; switch to absolute coordinates
M99                                                                             ; return from sub-program
;
O9601
G01 X#9610 F[#9609]
G01 Y#9611
G01 X[0 - #9610]
G01 Y[0 - #9611]
G01 X#9603 Y#9603                                                               ; Step in towards center for the next loop
#9610 = [#9610 - [#9603 * 2]]                                                   ; Reduce spans for the next loop
#9611 = [#9611 - [#9603 * 2]]                                                   ; Reduce spans for the next loop
M99
