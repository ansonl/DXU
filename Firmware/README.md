## Marlin 2 Configurations
Configurations for UMO+, UM2, UM2+ merged upstream to MarlinFirmware/Configurations are available at: [MarlinFirmware/Configurations](https://github.com/MarlinFirmware/Configurations/tree/bugfix-2.1.x/config/examples/Ultimaker)

These configurations are automatically merged with Configuration file version updates so accuracy is not guaranteed. All configurations can be used on single extruder printers by changing the extruder count from 2 to 1 and commenting out the multi extruder, thermistor, and extruder defines.

### PID Values Calibration

Determine your own PID by running [M303](https://marlinfw.org/docs/gcode/M303.html) or use the below values as reference.

#### Hotend PID values using 35 W heater cartridge

| Printhead | PID values in Gcode. Save to EEPROM with `M500` |
| --- | --- |
| Stock UM2+ | `M301 P8.86 I0.68 D28.86` |
| DXU PTFE with PI spacer | `M301 P13.95 I1.77 D27.42` |
| DXU all-metal | `M301 P10.85 I1.08 D27.33` |
| DXUv2 non-lifting nozzle (left) | `M301 E0 P15.15 I1.78 D32.26` |
| DXUv2 lifting nozzle (left) | `M301 E1 P15.53 I1.79 D33.71` |

#### Heated bed PID values using Ultimaker 120 W heated bed

| Printhead | PID values in Gcode. Save to EEPROM with `M500` |
| --- | --- |
| Stock UM glass bed | `M304 P124.55 I23.46 D165.29` |
| Textured PEI on magnetic metal sheet | `M304 D372.47 I14.05 P88.61` |

### EStep (steps/mm) Calibration

Determine your extruder steps/mm to avoid over/under extrusion. Even stock and clone extruders have variances that deviate from default steps/mm values!

| Extruder | steps/mm with 1.8°/step (UMO+/UM2+ extruder motor) | steps/mm with 0.9°/step (UM2 extruder motor) |
| --- | --- | --- |
| UM2+ Extruder | `M92 E369` | `M92 E738` |
| UM2+ Extruder (aliexpress) | `M92 E357` - `M92 E360` | `M92 E715` - `M92 E720` |

1. Disconnect bowden tube and printhead from extruder. 
2. Disable Cold Extrude protection. `M302 P1`
3. Set current extruder position in software to 0. `G92 E0`
4. Feed filament into extruder. Mark the location on the filament that sticks out from the extruder filament output hole using a sharpie. 
5. Move 100 mm of filament forward. `G0 E100 F100`
6. Mark location of filament that sticks out from the extruder filament output hole.
7. Measure distance between markings to determine actual distance of filament moved forward.
8. Calculate correct steps/mm manually or `corrected esteps = current esteps * (actual distance in mm)/100mm` or use [TH3D EStep Calculator](https://www.th3dstudio.com/estep-calculator/)
9. Set new steps/mm `M92 E<esteps>` e.g. `M92 E369`.
10. Return to step 3 and verify 100m of filament is actually moved.

### Hotend Offset Calibration

Stock hotend offset values for the second extruder are `M218 T1 X18 Y0 Z-2`

#### Hotend Offset X/Y Calibration

1. Print dual X/Y calibration print [here](https://www.thingiverse.com/thing:1741265) or in the `AL-Hotend Calibration folder`.
2. Compare print results and set hotend offsets with [`M218`](https://marlinfw.org/docs/gcode/M218.html). `M218 T1 XNNN YNNN`

#### Hotend Offset Z Calibration

1. Switch to first extruder. `T0`
2. Home Z axis. Optionally home X/Y axis and move printhead to center of X/Y. `G28` `G0 X100 Y100`
3. Move Z axis to `0` position where nozzle touches or is ~0.1 mm above the bed for the paper calibration method. Using a piece of paper/gauge sliding between nozzle and bed, note the physical distance (not the value on the screen) between the nozzle and bed at Z0. `G0 Z0`
4. Move Z axis down at least `5 mm` to make space for the second extruder. `G0 Z5`
5. Manually activate second extruder with your hand or a tool. Do not activate with toolchange gcode `T1` unless the `HOTEND_OFFSET_Z` for the second extruder is set to `0`.
6. Move Z axis up until the physical distance between the second nozzle and bed are the same as the physical distance between the first nozzle and bed that you remembered earlier. Use a paper/gauge to get the right distance. Use the negative values of the Z position reported by the printer software as the `HOTEND_OFFSET_Z` for the second extruder. E.g. If the reported Z position is 2.5 mm, use -2.5 mm. 
7. Set new hotend Z offset with `M218`. `M218 T1 ZNNNN`

### Save Printer Settings

Save settings to persistent storage on board the printer EEPROM with `M500`

## Marlin 2 Firmware 
Firmware source code customized for 3D printers

| Machine style | Motherboard (controller board) | Firmware source code branch |
| --- | --- | --- |
| UMO+/UM2/UM2+ w/ DXU | `ULTIMAINBOARD` | [ansonl/Marlin:dxu-ultimaker-ultimainboard-2](https://github.com/ansonl/Marlin/tree/dxu-ultimaker-ultimainboard-2) |
| UMO+/UM2/UM2+ w/ DXU | `BTT_OCTOPUS_PRO_V1_0` | [ansonl/Marlin:dxu-ultimaker-btt-octopus-pro-1](https://github.com/ansonl/Marlin/tree/dxu-ultimaker-btt-octopus-pro-1) |

*If you have a modified Marlin 2 firmware that you would like to add to this list, please add it in a PR.*

### Firmware notes for each branch versus *MarlinFirmware/Marlin* upstream 

#### ansonl/Marlin:dxu-ultimaker-ultimainboard-2
- https://github.com/MarlinFirmware/Marlin/issues/25117 - Marlin 2.1.2 Input Shaping may skip steps on AVR at high speeds > 250mm/s.

#### ansonl/Marlin:dxu-ultimaker-btt-octopus-pro-1
- Pins changes
  - `pins_BTT_OCTOPUS_PRO_V1_0.h`
  - `pins_BTT_OCTOPUS_V1_common.h`
- https://github.com/MarlinFirmware/Marlin/pull/25683 - OTA Firmware update via SDIO card update

### Merged to upstream
- https://github.com/MarlinFirmware/Marlin/pull/23466
- https://github.com/MarlinFirmware/Marlin/pull/24553
- https://github.com/MarlinFirmware/Marlin/pull/24797
- https://github.com/MarlinFirmware/Marlin/pull/25399
- https://github.com/MarlinFirmware/Marlin/pull/25707

## Cura printer settings

```json
"overrides":
    {
        "line_width": { "value": "machine_nozzle_size" },
        "machine_depth": { "default_value": 216 },
        "machine_disallowed_areas":
        {
            "default_value": [
                [
                    [100, -102.5],
                    [110, -102.5],
                    [110, -62.5],
                    [100, -62.5]
                ]
            ]
        },
        "machine_end_gcode": { "value": "\"\"  if machine_gcode_flavor == \"UltiGCode\" else \"G91 ;Relative movement\\nG0 X-8.0 Y-8.0 Z3.5 E-4.5 F18000 ;Wiping+material retraction ;increase bed lower 0.5>5.0 and add Y movement\\nG0 F10000 Z1.5 E4.5 ;Compensation for the retraction\\nG90 ;Disable relative movement\\nM400 ;wait for all moves in planner to complete\\nG90 ;absolute positioning\\nM104 S0 T0 ;extruder heater off\\nM104 S0 T1\\nM140 S0 ;turn off bed\\nT0 ; move to the first head\\nG27; park toolhead\\nM107 ;fan off\\nM355 S0;turn off case light\"" },
        "machine_extruder_count": { "default_value": 1 },
        "machine_gcode_flavor": { "default_value": "RepRap (Marlin/Sprinter)" },
        "machine_head_with_fans_polygon":
        {
            "default_value": [
                [-46, 30],
                [-46, -34],
                [66, 30],
                [66, -34]
            ]
        },
        "machine_heat_zone_length": { "default_value": 20 },
        "machine_heated_bed": { "default_value": true },
        "machine_height": { "default_value": 208 },
        "machine_max_feedrate_x": { "default_value": 300 },
        "machine_max_feedrate_y": { "default_value": 300 },
        "machine_max_feedrate_z": { "default_value": 40 },
        "machine_min_cool_heat_time_window": { "default_value": 15.0 },
        "machine_name": { "default_value": "dxu2" },
        "machine_nozzle_cool_down_speed": { "default_value": 0.8 },
        "machine_nozzle_expansion_angle": { "default_value": 45 },
        "machine_nozzle_head_distance": { "default_value": 3 },
        "machine_nozzle_heat_up_speed": { "default_value": 1.4 },
        "machine_nozzle_size": { "default_value": 0.4 },
        "machine_start_gcode": { "value": "\"\"  if machine_gcode_flavor == \"UltiGCode\" else \"; DXUv2 improved start priming Gcode for dual nozzles for single material print by ansonl\\nM355 S1 P25 ; Turn on case light dim\\nM190 S{material_bed_temperature_layer_0}\\nG28 ; Home all\\nG29 ; Run automatic bed leveling. Comment this line out if auto bed leveling is not desired.\\nM104 T0 S{material_standby_temperature, 0} ; Preheat T0 to standby temp\\nG21 ; Metric values\\nG90 ; Absolute positioning\\nM82 ; Set extruder to absolute mode\\nM107 ; Start with the fan off\\nM200 D0 T{initial_extruder_nr} ; Reset filament diameter\\nG0 X200 F7200 ; move to safe X and Y location from right side after ending ABL homing\\nG1 Y150 F7200\\nM104 T{initial_extruder_nr} S{material_print_temperature_layer_0, initial_extruder_nr}\\nT{initial_extruder_nr} ;switch to the first nozzle used for print\\nM400 ;finish all moves\\nG0 Z20 F2400\\nG0 X214 F18000\\nG0 Y2 F18000\\nM109 T{initial_extruder_nr} S{material_print_temperature_layer_0, initial_extruder_nr}\\n;Final wipe sequence for initial extruder\\nG0 X212 Z0.3 F600\\nG92 E05\\nG1 Y45 E6.5 F1000\\nG92 E0\\nG1 E-0.5 F1500 ; retract\\nG92 E0\\nG1 Y100 F18000\\n;end of startup sequence\\n\\nM355 S1 P50;turn on case light\"" },
        "machine_use_extruder_offset_to_offset_coords": { "default_value": false },
        "machine_width": { "default_value": 221 },
        "material_adhesion_tendency": { "enabled": true },
        "material_diameter": { "default_value": 1.75 },
        "prime_tower_position_x": { "value": "180" },
        "prime_tower_position_y": { "value": "160" },
        "retraction_amount": { "default_value": 3 },
        "retraction_min_travel": { "value": "line_width * 2" },
        "retraction_speed": { "default_value": 25 },
        "switch_extruder_prime_speed": { "value": "retraction_prime_speed" },
        "switch_extruder_retraction_amount": { "value": "retraction_amount" },
        "switch_extruder_retraction_speed": { "value": "retraction_retract_speed" },
        "switch_extruder_retraction_speeds": { "value": "retraction_speed" },
        "travel_avoid_distance": { "value": "3 if extruders_enabled_count > 1 else machine_nozzle_tip_outer_diameter / 2 * 1.5" }
    }
  ```


