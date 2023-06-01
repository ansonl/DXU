## Marlin 2 Configurations
Configurations for UMO+, UM2, UM2+ merged upstream to MarlinFirmware/Configurations are available at: [MarlinFirmware/Configurations](https://github.com/MarlinFirmware/Configurations/tree/bugfix-2.1.x/config/examples/Ultimaker)

These configurations are automatically merged with Configuration file version updates so accuracy is not guaranteed. All configurations can be used on single extruder printers by changing the extruder count from 2 to 1 and commenting out the multi extruder, thermistor, and extruder defines.

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


