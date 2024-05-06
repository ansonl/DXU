; ----
; DXUv2 end G-code
; ----
M104 S0 T0 ;extruder heaters off
M104 S0 T1
G91 ;Relative movement
G2 I0.86 J0.86 P1 Z0.4 E-0.4 F18000 ; spiral lift wipe and retract
;G0 X-8.0 Y-8.0 Z0.4 E-0.6 F18000 ;Wiping+material retraction
G0 Z0.12 E-{retraction_amount-0.4} F1500 ; finish normal retraction
G0 F18000
G27; park toolhead
G0 E-{switch_extruder_retraction_amount-retraction_amount-0.4} F1200 ; finish full retraction by switch extruder amount
M400 ;wait for all moves in planner to complete
G90 ;absolute positioning
G0 Z{machine_height} F7200
T0 ; move to the first head
G27; park toolhead
M140 S0 ;turn off bed
M107 ;fan off
M355 S0 ;turn off case light
M150 B0 R0 U50 ; set LED to green