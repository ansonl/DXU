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
2. Disable Cold Extrude protection. `M302 P`
3. Set current extruder position in software to 0. `G92 E0`
4. Feed filament into extruder. Mark the location on the filament that sticks out from the extruder filament output hole using a sharpie. 
5. Move 100m of filament forward. `G0 E100 F10`
6. Mark location of filament that sticks out from the extruder filament output hole.
7. Measure distance between markings to determine actual distance of filament moved forward.
8. Calculate correct steps/mm manually or `corrected esteps = current esteps * (actual distance in mm)/100mm` or use [TH3D EStep Calculator](https://www.th3dstudio.com/estep-calculator/)
9. Set new steps/mm `M92 E<esteps>` e.g. `M92 E369`.
10. Return to step 3 and verify 100m of filament is actually moved.

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
"overrides": {
        "machine_disallowed_areas": {
            "default_value": [
                [[100,  -102.5], [ 110,  -102.5], [ 110,  -62.5], [100,  -62.5]]
            ]
        },
        "machine_width": { "default_value": 220 },
        "machine_depth": { "default_value": 205 },
        "machine_height": { "default_value": 200 },
        "machine_head_with_fans_polygon": {
            "default_value": [
                [-46, 30],
                [-46, -34],
                [66, 30],
                [66, -34]
            ]
        },
        "machine_nozzle_heat_up_speed": {
            "default_value": 1.4
        },
        "machine_nozzle_cool_down_speed": { 
            "default_value": 0.8
        },
        "machine_nozzle_size": {
            "default_value": 0.4
        },
        "material_diameter": {
            "default_value": 1.75
        }
    }
  ```


