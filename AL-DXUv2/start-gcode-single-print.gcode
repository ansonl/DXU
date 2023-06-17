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

; DXUv2 improved start priming Gcode for dual nozzles for single material print by ansonl
M355 S1 P25 ; Turn on case light dim
M190 S{material_bed_temperature_layer_0}
G28 ; Home all
G29 ; Run automatic bed leveling. Comment this line out if auto bed leveling is not desired.
M104 T0 S{material_standby_temperature, 0} ; Preheat T0 to standby temp
G21 ; Metric values
G90 ; Absolute positioning
M82 ; Set extruder to absolute mode
M107 ; Start with the fan off
M200 D0 T{initial_extruder_nr} ; Reset filament diameter
G0 X200 F7200 ; move to safe X and Y location from right side after ending ABL homing
G1 Y150 F7200
M104 T{initial_extruder_nr} S{material_print_temperature_layer_0, initial_extruder_nr}
T{initial_extruder_nr} ;switch to the first nozzle used for print
M400 ;finish all moves
G0 Z20 F2400
G0 X214 F18000
G0 Y2 F18000
M109 T{initial_extruder_nr} S{material_print_temperature_layer_0, initial_extruder_nr}
;Final wipe sequence for initial extruder
G0 X212 Z0.3 F600
G92 E05
G1 Y45 E6.5 F1000
G92 E0
G1 E-0.5 F1500 ; retract
G92 E0
G1 Y100 F18000
;end of startup sequence

M355 S1 P50;turn on case light