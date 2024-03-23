G91 ;Relative movement
G0 X-8.0 Y-8.0 Z3.5 E-6.5 F18000 ;Wiping+material retraction ;increase bed lower 0.5>5.0 and add Y movement
G0 F10000 Z1.5 E1 ;Compensation for the retraction
G90 ;Disable relative movement
M400 ;wait for all moves in planner to complete
G90 ;absolute positioning
M104 S0 T0 ;extruder heater off
M104 S0 T1
G0 Z208 F7200
M140 S0 ;turn off bed
T0 ; move to the first head
G27; park toolhead
M107 ;fan off
M355 S0;turn off case light
M150 B0 R0 U0