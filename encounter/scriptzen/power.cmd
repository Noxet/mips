
###### POWER PLANNING ######

### power ring ###
set sprCreateIeRingNets {}
set sprCreateIeRingLayers {}
set sprCreateIeRingWidth 1.0
set sprCreateIeRingSpacing 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
addRing -stacked_via_top_layer AP -around core -jog_distance 2.5 -threshold 2.5 -nets {GND VDD} -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2

### memory power ring ###
selectInst dmem_inst
addRing -stacked_via_top_layer AP -around selected -jog_distance 2.5 -threshold 2.5 -type block_rings -nets {GND VDD} -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2 -skip_side {left bottom}

selectInst imem_inst
addRing -stacked_via_top_layer AP -around selected -jog_distance 2.5 -threshold 2.5 -type block_rings -nets {GND VDD} -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2 -skip_side {bottom right}

### power stripes ###
addStripe -block_ring_top_layer_limit M5 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M3 -set_to_set_distance 100 -stacked_via_top_layer AP -padcore_ring_top_layer_limit M5 -spacing 2 -merge_stripes_value 2.5 -layer M4 -block_ring_bottom_layer_limit M3 -width 2 -nets {GND VDD} -stacked_via_bottom_layer M1
addStripe -block_ring_top_layer_limit M4 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M2 -set_to_set_distance 100 -stacked_via_top_layer AP -padcore_ring_top_layer_limit M4 -spacing 2 -merge_stripes_value 2.5 -direction horizontal -layer M3 -block_ring_bottom_layer_limit M2 -width 2 -nets {GND VDD} -stacked_via_bottom_layer M1
