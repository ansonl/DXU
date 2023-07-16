; Octolapse variables
; Script based on an original created by tjjfvi (https://github.com/tjjfvi)
; An up-to-date version of the tjjfvi's original script can be found
; here:  https://csi.t6.fyi/
; Note - This script will only work in Cura V4.2 and above!
; --- Global Settings
; layer_height = {layer_height}
; smooth_spiralized_contours = {smooth_spiralized_contours}
; magic_mesh_surface_mode = {magic_mesh_surface_mode}
; machine_extruder_count = {machine_extruder_count}
; --- Single Extruder Settings
; speed_z_hop = {speed_z_hop}
; retraction_amount = {retraction_amount}
; retraction_hop = {retraction_hop}
; retraction_hop_enabled = {retraction_hop_enabled}
; retraction_enable = {retraction_enable}
; retraction_speed = {retraction_speed}
; retraction_retract_speed = {retraction_retract_speed}
; retraction_prime_speed = {retraction_prime_speed}
; speed_travel = {speed_travel}
; --- Multi-Extruder Settings
; speed_z_hop_0 = {speed_z_hop, 0}
; speed_z_hop_1 = {speed_z_hop, 1}
; retraction_amount_0 = {retraction_amount, 0}
; retraction_amount_1 = {retraction_amount, 1}
; retraction_hop_0 = {retraction_hop, 0}
; retraction_hop_1 = {retraction_hop, 1}
; retraction_hop_enabled_0 = {retraction_hop_enabled, 0}
; retraction_hop_enabled_1 = {retraction_hop_enabled, 1}
; retraction_prime_speed_0 = {retraction_prime_speed, 0}
; retraction_prime_speed_1 = {retraction_prime_speed, 1}
; retraction_retract_speed_0 = {retraction_retract_speed, 0}
; retraction_retract_speed_1 = {retraction_retract_speed, 1}
; retraction_speed_0 = {retraction_speed, 0}
; retraction_speed_1 = {retraction_speed, 1}
; retraction_enable_0 = {retraction_enable, 0}
; retraction_enable_1 = {retraction_enable, 1}
; speed_travel_0 = {speed_travel, 0}
; speed_travel_1 = {speed_travel, 1}
; material_bed_temperature={material_bed_temperature}
; material_print_temperature={material_print_temperature}
; material_print_temperature_layer_0={material_print_temperature_layer_0}

; DXUv2 improved start priming Gcode for dual nozzles for multi-material print
M355 S1 P25 ; Turn on case light dim
M190 S{material_bed_temperature_layer_0}
G28 ; Home all
G29 ; Run automatic bed leveling. Comment this line out if auto bed leveling is not desired.
M104 T0 S{material_standby_temperature, 0} ; Preheat T0 to standby temp
G21 ; Metric values
G90 ; Absolute positioning
M82 ; Set extruder to absolute mode
M107 ; Start with the fan off
M200 D0 T0 ; Reset filament diameter
M200 D0 T1 ; Reset filament diameter
G0 X200 F7200 ; Move to safe X and Y location from right side after ending ABL homing. Move X before Y to avoid hitting switching lever.
G1 Y150 F7200
; Prime routine for T1 in normally 
T1 ; move to the nozzle 2
G0 Z10 F2400 ; move the platform down to 10mm
M109 T1 S{material_print_temperature, 1} ; Heat up and wait for T1
G0 Y150 F7200 ; Move printhead to safe Y location to move right.
G0 Y1 F7200 ; Add HOTEND_OFFSET_Y[1] to Y0 (or forward-most safe Y location when T1 is active) to get Gcode Y parameter
G1 X235 Y10 Z0.3 F2400 ; Add HOTEND_OFFSET_X[1] to X217 (or right-most safe X location when T1 is active) to get actual Gcode X parameter.
G92 E0 ; reset E location
M104 T1 S{material_final_print_temperature, 1} ; Start cooling down nozzle to reduce oozing
G1 Y70 E9 F1000 ; intro line
M104 T1 S{material_standby_temperature, 1}
G92 E0 
G1 E-{retraction_amount, 1} F1500 ; retract
G0 Y100 F18000 ; break line
G0 Y150 Z10 F2400 ; raise nozzle
; Prime routine for T0
T0 ; move to the nozzle 1
G0 Z10 F2400
M109 T0 S{material_print_temperature, 0}
G0 Y150 F7200 ; Move printhead to safe Y location to move right.
G0 Y0 F7200 ;change Y20 to Y0 ansonl
G1 X217 Y15 Z0.3 F2400
G92 E0 ; reset E location
M104 T0 S{material_final_print_temperature, 0} ; Start cooling down nozzle to reduce oozing
G1 Y75 E9 F1000 ; intro line
M104 T0 S{material_standby_temperature, 0}
G92 E0
G1 E-{retraction_amount, 0} F1500 ; retract
G0 Y105 F18000 ; break line
G0 Y150 Z10 F2400 ; raise nozzle
; Final prime and wipe sequence for initial extruder (usually T0)
M104 T{initial_extruder_nr} S{material_print_temperature_layer_0, initial_extruder_nr} ; Start heating initial nozzle. Do not wait.
T{initial_extruder_nr} ; move to the initial nozzle used for print
M400 ;finish all moves
G0 Z20 F2400
G0 X212 F18000
G0 Y2 F18000
M109 T{initial_extruder_nr} S{material_print_temperature_layer_0, initial_extruder_nr} ; Wait for heating to complete
G0 X205 Z0.3 F2400
G92 E0
G1 Y45 E6.5 F1000
G92 E0
G1 E-0.5 F1500 ; retract slightly
G1 Y100 F18000 ; break line
G92 E0
M355 S1 P128; Turn on case light brighter
;end of startup sequence
