; DXUv2 improved start priming Gcode for dual nozzles for multi-material print
M355 S1 P25 ; Turn on case light dim
M190 S60
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
T0 ; switch to NOT initial_extruder_nr nozzle
M104 T1 S195 ; Start heating up the NOT initial extruder
G0 Z10 F2400 ; move the platform down to 10mm
M109 T0 S210 ; Heat up and wait for not initial extruder
G0 Y150 F7200 ; Move printhead to safe Y location to move right.
G0 X216 Y1 F7200 ; Add HOTEND_OFFSET_Y[1] to Y0 (or forward-most safe Y location when T1 is active) to get Gcode Y parameter T18.0 cannot be nested so 18 is hardcoded
G0 X145 Z0.31 F2400 ; lower nozzle
G92 E0 ; reset E location
G1 X15 Z0.31 E16 F1500 ; Add HOTEND_OFFSET_X[1] to X217 (or right-most safe X location when T1 is active) to get actual Gcode X parameter.
G3 X5 Y11 I0 J10 F7200
G0 X5 Y11 Z0.31 F7200 ; move in case there is no arc support
M104 T1 S195 ; Start cooling down nozzle to reduce oozing
G92 E0
G1 Y70 E3 F1000 ; intro line
M104 T1 S170
G92 E0
G1 E-16 F1200 ; retract
G0 Y105 F18000 ; break line
G0 Y150 Z10 F2400 ; raise nozzle

; ----
; Prime routine for initial nozzle
; ----
T1 ; switch to initial_extruder_nr nozzle
M104 T1 S195 ; Start heating up the NOT initial extruder
G0 Z10 F2400 ; move the platform down to 10mm
M109 T1 S210 ; Heat up and wait for not initial extruder
G0 Y150 F7200 ; Move printhead to safe Y location to move right.
G0 X23 Y1.5 F7200 ; Add HOTEND_OFFSET_Y[1] to Y0 (or forward-most safe Y location when T1 is active) to get Gcode Y parameter T18.0 cannot be nested so 18 is hardcoded
G0 X95 Z0.31 F2400 ; lower nozzle
G92 E0 ; reset E location
G1 X225 Z0.31 E16 F1500 ; Add HOTEND_OFFSET_X[1] to X217 (or right-most safe X location when T1 is active) to get actual Gcode X parameter.
G1 Y1 Z0.31 E16 F7200 ; Y correction to match other prime side
G3 X235 Y11 I0 J10 F7200
G0 X235 Y11 Z0.31 F7200 ; move in case there is no arc support
M104 T1 S195 ; Start cooling down nozzle to reduce oozing
G92 E0
G1 Y70 E3 F1000 ; intro line
M104 T1 S170
G92 E0
G1 E-16 F1200 ; retract
G0 Y105 F18000 ; break line
G0 Y150 Z10 F2400 ; raise nozzle

; ----
; Final prime and wipe sequence for initial extruder
; ----
T1 ; switch to the initial nozzle
M400 ;finish all moves
G0 Z20 F2400
G0 X230 F7200
G0 Y70 F7200
M109 T1 S210 ; Wait for initial nozzle to reach temp
G92 E0
G1 E16 F1200 ; prime by switching length
G0 X235 F7200 Y50 Z0.5 F7200
G92 E0
G0 Y9.4 Z0.5 E3 F7200
G2 X230 Y3.4 Z0.4 I-6 J0 F7200
M104 T1 S225.0 ; Start heating to first layer temp
G0 X225 Y3.4 Z0.4 F7200
G2 X223 Y5.4 Z0.31 I0 J2 F7200
G0 X223 Y5.4 Z0.31 F7200 ; move if no arc support
G1 Y10 F18000 ; break line
G92 E0
G1 Y50 E2 F1000 ; extrude line
G92 E0
G1 E-3 F1500 ; retract slightly
G1 Y100 F18000 ; break line
; move to expected start corner
G1 X216 Z0.4 Y112
G1 Y5
G0 X5 Y5 ; move to start
M355 S1 P150; Turn on case light brighter
;end of DXUv2 prime routine