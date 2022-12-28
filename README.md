# DXU - Dual Extrusion Upgrade for Ultimaker Original+ and Ultimaker 2+

## Improved/Updated DXU resources are in the `DXU improvements` folder. 

- DXU functionality is possible in Marlin 2 with the code updates in Marlin [PR#24553](https://github.com/MarlinFirmware/Marlin/pull/24553)
  - *Please support the PR for inclusion into the main Marlin 2 code by commenting on the PR.*
  - Latest Marlin 2 firmware compatible with DXU is at [ansonl/Marlin-DXU](https://github.com/ansonl/Marlin-DXU)
    - You must manually determine second extruder X/Y/Z offset in `Marlin/Configuration.h` before compiling firmware. 
      - Compile the firmware and manually run toolchange Gcode via serial connection (T0->T1 `EVENT_GCODE_TOOLCHANGE_T1` /T1->T0 `EVENT_GCODE_TOOLCHANGE_T0`) to determine if any offsets need adjusting
      - Add the second extruder offsets to the bare T1->T0 toolchange gcode tested while T0 is the active extruder to get the offset Gcode to put into `Configuration_adv.h`.
      - **Note: The toolchange Gcode is run in the "offset context" of the target extruder!**
      - Determine second extruder Z offset by manually adjusting Z position while `T0` is selected in firmware and `T1` is physically active.

### DISCUSSION:
https://community.ultimaker.com/topic/24553-dxu-another-dual-extrusion-upgrade-for-um2/

### CREDITS:

##### Original DXU:  
Original DXU by yyh1002
##### Hardware:  
Lever action is inspired by Ultimaker 3.   
##### Firmware:   
Marlin 2 firmware
