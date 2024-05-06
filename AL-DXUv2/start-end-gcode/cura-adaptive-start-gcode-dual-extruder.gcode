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
; switch_extruder_retraction_amount_0={switch_extruder_retraction_amount, 0}
; switch_extruder_retraction_amount_1={switch_extruder_retraction_amount, 1}

; DXUv2 improved start priming Gcode for dual nozzles for multi-material print
M355 S1 P25 ; Turn on case light dim
M190 S{material_bed_temperature_layer_0}
G28 ; Home all
G29 ; Run automatic bed leveling. Comment this line out if auto bed leveling is not desired.
M104 T0 S{material_standby_temperature, 0} ; Preheat T0 to standby temp
M104 T1 S{material_standby_temperature, 1} ; Preheat T1 to standby temp
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
T{0 if initial_extruder_nr>0 else 1} ; switch to NOT initial_extruder_nr nozzle
M104 T{0 if initial_extruder_nr>0 else 1} S{material_final_print_temperature, 0 if initial_extruder_nr>0 else 1} ; Start heating up the NOT initial extruder
G0 Z10 F2400 ; move the platform down to 10mm
M109 T{0 if initial_extruder_nr>0 else 1} S{material_print_temperature, 0 if initial_extruder_nr>0 else 1} ; Heat up and wait for not initial extruder
G0 Y150 F7200 ; Move printhead to safe Y location to move right.
G0 X{machine_width-5 if initial_extruder_nr>0 else 5+18} Y1 F7200 ;{machine_nozzle_offset_x,1} cannot be nested so 18 is hardcoded
G0 X{140 if initial_extruder_nr>0 else 100} Z0.31 F2400 ; lower nozzle
G92 E0 ; reset E location
G1 X{140-125 if initial_extruder_nr>0 else 100+125} E{switch_extruder_retraction_amount, initial_extruder_nr} F1500
G0 Y1 F7200
G92 E0
G{2 if initial_extruder_nr>0 else 3} X{140-125-2.5 if initial_extruder_nr>0 else 100+125+2.5} Y3.5 I0 J2.5 E0.04 F7200
G92 E0
G1 E1.65 Y17.5
G92 E0
G{3 if initial_extruder_nr>0 else 2} X{140-125-5 if initial_extruder_nr>0 else 100+125+5} Y20 I{-2.5 if initial_extruder_nr>0 else 2.5} J0 E0.04 F7200
G92 E0
G1 X{140-125-7.5 if initial_extruder_nr>0 else 100+125+7.5} Y20 E.3
G92 E0
G{2 if initial_extruder_nr>0 else 3} X{140-125-10 if initial_extruder_nr>0 else 100+125+10} Y22.5 I0 J2.5 E0.04 F7200
G92 E0
G1 Y70 E3.2 F1000 ; intro line
M104 T{0 if initial_extruder_nr>0 else 1} S{material_standby_temperature if extruders_enabled_count > 1 else 0, 0 if initial_extruder_nr>0 else 1}
G92 E0
G1 E-{switch_extruder_retraction_amount, 0 if initial_extruder_nr>0 else 1} F1200 ; retract
G0 Y105 F18000 ; break line
G0 Y150 Z10 F2400 ; raise nozzle

; ----
; Prime routine for initial nozzle
; ----
T{initial_extruder_nr} ; switch to initial_extruder_nr nozzle
M104 T{initial_extruder_nr} S{material_final_print_temperature, initial_extruder_nr} ; Start heating up the initial extruder
G0 Z10 F2400 ; move the platform down to 10mm
M109 T{initial_extruder_nr} S{material_print_temperature, initial_extruder_nr} ; Heat up and wait for not initial extruder
G0 Y150 F7200 ; Move printhead to safe Y location to move right.
G0 X{machine_width-5 if initial_extruder_nr<1 else 5+18} Y1.5 F7200 ; {machine_nozzle_offset_x,1} cannot be nested so 18 is hardcoded
G0 X{140 if initial_extruder_nr<1 else 100} Z0.31 F2400 ; lower nozzle
G92 E0 ; reset E location
G1 X{140-124 if initial_extruder_nr<1 else 100+124} E{switch_extruder_retraction_amount, initial_extruder_nr} F1500
G1 X{140-125 if initial_extruder_nr<1 else 100+125} F7200
G0 Y1 F7200
G92 E0
G{2 if initial_extruder_nr<1 else 3} X{140-125-2.5 if initial_extruder_nr<1 else 100+125+2.5} Y3.5 I0 J2.5 E0.04 F7200
G92 E0
G1 E1.65 Y17.5
G92 E0
G{3 if initial_extruder_nr<1 else 2} X{140-125-5 if initial_extruder_nr<1 else 100+125+5} Y20 I{-2.5 if initial_extruder_nr<1 else 2.5} J0 E0.04 F7200
G92 E0
G1 X{140-125-7.5 if initial_extruder_nr<1 else 100+125+7.5} Y20 E.3
G92 E0
G{2 if initial_extruder_nr<1 else 3} X{140-125-10 if initial_extruder_nr<1 else 100+125+10} Y22.5 I0 J2.5 E0.04 F7200
G92 E0
G1 Y70 E3.2 F1000 ; intro line
G92 E0
G0 Y105 F18000 ; break line

; ----
; Final prime and wipe sequence for initial extruder
; ----
G{3 if initial_extruder_nr<1 else 2} X{140-125-10-2.5 if initial_extruder_nr<1 else 100+125+10+2.5} Y107.5 Z0.48 I0 J2.5 F18000
M400 ;finish all moves
M104 T{initial_extruder_nr} S{material_print_temperature, initial_extruder_nr} ; Wait for initial nozzle to reach temp if needed.
G0 Y75 F18000
G0 Y65 F7200
G0 X{140-125-10 if initial_extruder_nr<1 else 100+125+10} Y50 F7200
G92 E0
G1 Y40 Z0.4 E0.25 F7200
G92 E0
G1 Y30 E0.5 F7200
G{3 if initial_extruder_nr<1 else 2} X{140-125-5 if initial_extruder_nr<1 else 100+125+5} Y20 Z0.4 I{10 if initial_extruder_nr<1 else -10} J0 F18000
G0 X15 Y20 Z0.36 F18000 ;move to start position
G0 F18000 ;set starting acceleration
M104 T{initial_extruder_nr} S{material_print_temperature_layer_0, initial_extruder_nr} ; Start heating to first layer temp

M355 S1 P150; Turn on case light brighter
;end of DXUv2 prime routine