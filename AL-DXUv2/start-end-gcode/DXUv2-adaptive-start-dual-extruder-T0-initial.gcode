; DXUv2 improved start priming Gcode for dual nozzles for multi-material print
M355 S1 P25 ; Turn on case light dim
M190 S75
G28 ; Home all
G29 ; Run automatic bed leveling. Comment this line out if auto bed leveling is not desired.
M104 T0 S170 ; Preheat T0 to standby temp
M104 T1 S170 ; Preheat T1 to standby temp
G21 ; Metric values
G90 ; Absolute positioning
M82 ; Set extruder to absolute mode
M107 ; Start with the fan off
M200 D0 T0 ; Reset filament diameter
M200 D0 T1 ; Reset filament diameter
G0 X200 F7200 ; Move to safe X and Y location from right side after ending ABL homing. Move X before Y to avoid hitting switching lever.
G1 Y150 F7200
; ----
; Prime routine for nozzle that is NOT the initial extruder first
; ----
T1 ; switch to NOT initial_extruder_nr nozzle
M104 T1 S195 ; Start heating up the NOT initial extruder
G0 Z10 F2400 ; move the platform down to 10mm
M109 T1 S210 ; Heat up and wait for not initial extruder
G0 Y150 F7200 ; Move printhead to safe Y location to move right.
G0 X23 Y1 F7200 ;18.0 cannot be nested so 18 is hardcoded
G0 X100 Z0.31 F2400 ; lower nozzle
G92 E0 ; reset E location
G1 X225 E16 F1500
G0 Y1 F7200
G92 E0
G3 X227.5 Y3.5 I0 J2.5 E0.04 F7200
G92 E0
G1 E1.65 Y17.5
G92 E0
G2 X230 Y20 I2.5 J0 E0.04 F7200
G92 E0
G1 X232.5 Y20 E.3
G92 E0
G3 X235 Y22.5 I0 J2.5 E0.04 F7200
G92 E0
G1 Y70 E3.2 F1000 ; intro line
M104 T1 S110
G92 E0
G1 E-3 F1200 ; retract
G0 Y105 F18000 ; break line
G0 Y150 Z10 F2400 ; raise nozzle

; ----
; Prime routine for initial nozzle
; ----
T0 ; switch to initial_extruder_nr nozzle
M104 T0 S195.0 ; Start heating up the initial extruder
G0 Z10 F2400 ; move the platform down to 10mm
M109 T0 S210.0 ; Heat up and wait for not initial extruder
G0 Y150 F7200 ; Move printhead to safe Y location to move right.
G0 X216 Y1.5 F7200 ; 18.0 cannot be nested so 18 is hardcoded
G0 X140 Z0.31 F2400 ; lower nozzle
G92 E0 ; reset E location
G1 X16 E16 F1500
G1 X15 F7200
G0 Y1 F7200
G92 E0
G2 X12.5 Y3.5 I0 J2.5 E0.04 F7200
G92 E0
G1 E1.65 Y17.5
G92 E0
G3 X10 Y20 I-2.5 J0 E0.04 F7200
G92 E0
G1 X7.5 Y20 E.3
G92 E0
G2 X5 Y22.5 I0 J2.5 E0.04 F7200
G92 E0
G1 Y70 E3.2 F1000 ; intro line
G92 E0
G0 Y105 F18000 ; break line

; ----
; Final prime and wipe sequence for initial extruder
; ----
G3 X2.5 Y107.5 Z0.48 I0 J2.5 F18000
M400 ;finish all moves
M104 T0 S210.0 ; Wait for initial nozzle to reach temp if needed.
G0 Y75 F18000
G0 Y65 F7200
G0 X5 Y50 F7200
G92 E0
G1 Y40 Z0.4 E0.25 F7200
G92 E0
G1 Y30 E0.5 F7200
G3 X10 Y20 Z0.4 I10 J0 F18000
G0 X15 Y20 Z0.36 F18000 ;move to start position
G0 F18000 ;set starting acceleration
M104 T0 S210.0 ; Start heating to first layer temp

M355 S1 P150; Turn on case light brighter
;end of DXUv2 prime routine