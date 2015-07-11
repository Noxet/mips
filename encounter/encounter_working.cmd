#######################################################
#                                                     #
#  Encounter Command Logging File                     #
#  Created on Fri May  9 16:12:06 2014                #
#                                                     #
#######################################################

#@(#)CDS: Encounter v11.12-s119_1 (64bit) 08/10/2012 15:23 (Linux 2.6)
#@(#)CDS: NanoRoute v11.12-s002 NR120727-2211/11_10_USR2-UB (database version 2.30, 165.4.1) {superthreading v1.16}
#@(#)CDS: CeltIC v11.12-s013_1 (64bit) 08/09/2012 02:49:15 (Linux 2.6.18-194.el5)
#@(#)CDS: AAE 11.12-s002 (64bit) 08/10/2012 (Linux 2.6.18-194.el5)
#@(#)CDS: CTE 11.12-s087_1 (64bit) Aug 10 2012 11:04:44 (Linux 2.6.18-194.el5)
#@(#)CDS: CPE v11.12-s007
#@(#)CDS: IQRC/TQRC 11.1.1-s334 (64bit) Sun May  6 19:52:51 PDT 2012 (Linux 2.6.18-194.el5)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
win
set defHierChar ./
set init_io_file /h/dk/w/ael10jso/mips_project/netlists/mips.io
set init_oa_search_lib {}
set lsgOCPGainMult 1.000000
set init_verilog /h/dk/w/ael10jso/mips_project/netlists/mips.v
set init_pwr_net VDD
set init_mmmc_file /h/dk/w/ael10jso/mips_project/netlists/Default_BC_WC_ST65.view
set init_lef_file {/usr/local-eit/cad2/cmpstm/stm065v536/EncounterTechnoKit_cmos065_7m4x0y2z_AP@5.3.1/TECH/cmos065_7m4x0y2z_AP_Worst.lef /usr/local-eit/cad2/cmpstm/stm065v536/CLOCK65LPHVT_3.1/CADENCE/LEF/CLOCK65LPHVT_soc.lef /usr/local-eit/cad2/cmpstm/stm065v536/CORE65LPHVT_5.1/CADENCE/LEF/CORE65LPHVT_soc.lef /usr/local-eit/cad2/cmpstm/stm065v536/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_7.0/CADENCE/LEF/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_soc.lef /usr/local-eit/cad2/cmpstm/stm065v536/PRHS65_7.0.a/CADENCE/LEF/PRHS65_soc.lef /usr/local-eit/cad2/cmpstm/stm065v536/IO65LP_SF_BASIC_50A_ST_7M4X0Y2Z_7.2/CADENCE/LEF/IO65LP_SF_BASIC_50A_ST_7M4X0Y2Z_soc.lef ~/mips_project/vhdl/mem/SPHDL100823.lef ~/mips_project/vhdl/mem/SPHDL100823_soc.lef}
set init_gnd_net GND
create_rc_corner -name WC -cap_table {/usr/local-eit/cad2/cmpstm/stm065v536/EncounterTechnoKit_cmos065_7m4x0y2z_AP@5.3.1/TECH/cmos065_7m4x0y2z_AP_Worst.captable} -T {-40} -preRoute_res {1.0} -preRoute_cap {1.0} -preRoute_clkres {0.0} -preRoute_clkcap {0.0} -postRoute_res {1.0} -postRoute_cap {1.0} -postRoute_xcap {1.0} -postRoute_clkres {0.0} -postRoute_clkcap {0.0} -qx_tech_file {/usr/local-eit/cad2/cmpstm/stm065v536/SignOffTechnoKit_cmos065lp_7m4x0y2z@5.3.4/etc/QrcTechLibs/RCMAX/RCMAX.tech}
create_rc_corner -name BC -cap_table {/usr/local-eit/cad2/cmpstm/stm065v536/EncounterTechnoKit_cmos065_7m4x0y2z_AP@5.3.1/TECH/cmos065_7m4x0y2z_AP_Best.captable} -T {125} -preRoute_res {1.0} -preRoute_cap {1.0} -preRoute_clkres {0.0} -preRoute_clkcap {0.0} -postRoute_res {1.0} -postRoute_cap {1.0} -postRoute_xcap {1.0} -postRoute_clkres {0.0} -postRoute_clkcap {0.0} -qx_tech_file {/usr/local-eit/cad2/cmpstm/stm065v536/SignOffTechnoKit_cmos065lp_7m4x0y2z@5.3.4/etc/QrcTechLibs/RCMIN/RCMIN.tech}
create_library_set -name WC -timing {/usr/local-eit/cad2/cmpstm/stm065v536/CORE65LPHVT_5.1/libs/CORE65LPHVT_wc_1.10V_m40C.lib /usr/local-eit/cad2/cmpstm/stm065v536/CLOCK65LPHVT_3.1/libs/CLOCK65LPHVT_wc_1.10V_m40C.lib /usr/local-eit/cad2/cmpstm/stm065v536/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_7.0/libs/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_wc_1.05V_1.65V_m40C.lib /h/dk/w/ael10jso/mips_project/vhdl/mem/SPHDL100823_wc_1.10V_m40C.lib}
create_library_set -name BC -timing {/usr/local-eit/cad2/cmpstm/stm065v536/CLOCK65LPHVT_3.1/libs/CLOCK65LPHVT_bc_1.30V_125C.lib /usr/local-eit/cad2/cmpstm/stm065v536/CORE65LPHVT_5.1/libs/CORE65LPHVT_bc_1.30V_125C.lib /usr/local-eit/cad2/cmpstm/stm065v536/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_7.0/libs/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_bc_1.30V_1.95V_125C.lib /h/dk/w/ael10jso/mips_project/vhdl/mem/SPHDL100823_bc_1.30V_125C.lib}
create_constraint_mode -name mySDC -sdc_files {/h/dk/w/ael10jso/mips_project/netlists/mips.sdc}
create_delay_corner -name BC -library_set {BC} -rc_corner {BC}
create_delay_corner -name WC -library_set {WC} -rc_corner {WC}
create_analysis_view -name BC -constraint_mode {mySDC} -delay_corner {BC}
create_analysis_view -name WC -constraint_mode {mySDC} -delay_corner {BC}
init_design
set_analysis_view -setup {WC} -hold {BC}
selectInst Pcornerll
setDrawView fplan
windowSelect 973.135 138.197 672.613 253.031
selectInst dmem_inst
windowSelect 970.691 157.743 760.570 231.041
selectInst dmem_inst
uiSetTool move
setObjFPlanBox Instance dmem_inst 116.96 366.49 421.76 678.29
deselectAll
selectInst imem_inst
setObjFPlanBox Instance imem_inst 426.646 364.046 731.446 675.846
zoomBox -331.963 864.022 1068.056 -147.103
uiSetTool ruler
setResizeLine -clearAll
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site CORE -d 793.745 793.4 0.0 0.0 0.0 0.0
uiSetTool select
getIoFlowFlag
fit
setIoFlowFlag 0
floorPlan -site CORE -d 900 793.4 0.0 0.0 0.0 0.0
uiSetTool select
getIoFlowFlag
fit
setIoFlowFlag 0
floorPlan -site CORE -d 840.0 793.4 0.0 0.0 0.0 0.0
uiSetTool select
getIoFlowFlag
fit
uiSetTool moveWire
uiSetTool move
deselectAll
selectInst dmem_inst
setObjFPlanBox Instance dmem_inst 114.131 367.599 418.931 679.399
zoomBox 74.414 716.001 239.704 562.914
zoomBox 97.527 689.885 154.491 638.524
zoomBox 107.182 685.445 131.400 664.607
zoomBox 108.790 683.133 119.975 672.290
zoomBox 110.844 681.977 118.206 675.737
setObjFPlanBox Instance dmem_inst 112.051 369.524 416.851 681.324
zoomBox 111.114 682.257 113.256 680.479
zoomBox 111.559 682.006 112.521 680.751
zoomBox 111.840 681.522 112.356 680.979
zoomBox 111.935 681.453 112.173 681.172
zoomBox 111.954 681.421 112.092 681.286
setObjFPlanBox Instance dmem_inst 112.0 369.6 416.8 681.4
fit
zoomBox 649.695 708.615 789.339 579.412
zoomBox 704.724 688.589 764.290 640.068
fit
zoomBox 358.661 730.802 575.305 494.581
zoomBox 401.069 695.670 484.047 616.707
zoomBox 409.859 686.309 441.738 659.470
zoomBox 413.236 684.912 431.787 668.612
deselectAll
selectInst imem_inst
setObjFPlanBox Instance imem_inst 417.037 369.233 721.837 681.033
zoomBox 414.467 684.020 420.704 677.260
zoomBox 415.718 681.933 419.137 679.098
zoomBox 416.452 681.660 418.205 679.945
zoomBox 416.645 681.483 417.408 680.527
setObjFPlanBox Instance imem_inst 416.806 369.598 721.606 681.398
zoomBox 416.774 681.438 417.011 681.196
zoomBox 416.784 681.418 416.884 681.335
zoomBox 416.802 681.406 416.829 681.374
zoomBox 416.799 681.402 416.811 681.390
setObjFPlanBox Instance imem_inst 416.8 369.6 721.6 681.4
fit
zoomBox 678.407 681.209 1017.729 361.463
zoomBox 712.435 684.766 783.846 626.774
zoomBox 718.487 685.625 750.965 660.006
zoomBox 719.359 684.421 733.442 671.485
zoomBox 720.970 682.507 729.384 677.555
setObjFPlanBox Instance imem_inst 423.123 369.54 727.923 681.34
zoomBox 727.376 681.552 729.170 680.019
zoomBox 727.837 681.447 728.321 681.014
zoomBox 727.880 681.423 728.080 681.220
setObjFPlanBox Instance imem_inst 423.2 369.6 728.0 681.4
zoomBox 727.976 681.409 728.028 681.361
zoomBox 727.993 681.404 728.008 681.391
zoomBox 727.997 681.402 728.001 681.397
zoomBox 727.998 681.400 728.001 681.398
zoomBox 728.000 681.400 728.001 681.398
zoomBox 728.000 681.400 728.001 681.399
zoomBox 728.000 681.401 728.001 681.399
fit
zoomBox 356.051 773.870 628.814 391.480
zoomBox 386.273 688.834 504.890 543.678
setIoFlowFlag 0
floorPlan -site CORE -d 900.0 793.4 0.0 0.0 0.0 0.0
uiSetTool select
getIoFlowFlag
fit
setIoFlowFlag 0
floorPlan -site CORE -d 880.0 793.4 0.0 0.0 0.0 0.0
uiSetTool select
getIoFlowFlag
fit
zoomBox 666.960 726.203 947.243 489.672
zoomBox 749.303 707.699 891.820 571.121
zoomBox 760.777 689.331 812.308 641.020
zoomBox 764.416 684.900 779.482 668.814
fit
zoomBox 57.175 727.570 349.763 404.904
zoomBox 90.125 686.894 160.051 588.632
zoomBox 107.134 684.528 150.419 643.609
fit
setIoFlowFlag 0
floorPlan -site CORE -d 880.0 793.4 0.0 0.0 0.0 0.0
uiSetTool select
getIoFlowFlag
fit
deselectAll
selectInst clk_pad_in
deselectAll
selectObject Module mini_mips_inst
deselectAll
selectInst clk_pad_in
fit
clearGlobalNets
globalNetConnect VDD -type pgpin -pin VDD -inst *
globalNetConnect VDD -type tiehi -inst *
globalNetConnect GND -type pgpin -pin GND -inst *
globalNetConnect GND -type tielo -inst *
clearGlobalNets
globalNetConnect VDD -type pgpin -pin VDD -inst *
globalNetConnect VDD -type tiehi -inst *
globalNetConnect GND -type pgpin -pin GND -inst *
globalNetConnect GND -type tielo -inst *
deselectAll
selectInst imem_inst
deselectAll
selectInst dmem_inst
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site CORE -d 880.0 793.4 20 20 20 20
uiSetTool select
getIoFlowFlag
fit
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site CORE -d 920 793.4 20.0 20.0 20.0 20.0
uiSetTool select
getIoFlowFlag
fit
setIoFlowFlag 0
floorPlan -site CORE -d 920.0 793.4 20.0 20.0 20.0 20.0
uiSetTool select
getIoFlowFlag
fit
addHaloToBlock 10 10 10 10 -allBlock
uiSetTool cut
setObjFPlanBox Instance dmem_inst -63.069 421.91 241.731 733.71
undo
getIoFlowFlag
cutRow -selected
uiSetTool move
setObjFPlanBox Instance dmem_inst -52.979 381.551 251.821 693.351
undo
saveDesign netlists/mini_mips_p.enc
encMessage warning 0
encMessage debug 0
encMessage info 0
restoreDesign netlists/mini_mips_p.enc.dat mini_mips_p
setDrawView fplan
encMessage warning 1
encMessage debug 0
encMessage info 1
set sprCreateIeRingNets {}
set sprCreateIeRingLayers {}
set sprCreateIeRingWidth 1.0
set sprCreateIeRingSpacing 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
addRing -stacked_via_top_layer AP -around core -jog_distance 2.5 -threshold 2.5 -nets {GND VDD} -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2
zoomBox 730.153 734.033 961.712 508.191
zoomBox 774.960 686.851 860.977 603.450
fit
selectInst dmem_inst
uiSetTool select
deselectAll
selectInst dmem_inst
deselectAll
selectInst dmem_inst
deselectAll
selectInst dmem_inst
addRing -stacked_via_top_layer AP -around selected -jog_distance 0.4 -threshold 0.4 -type block_rings -nets {GND VDD} -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2 -skip_side {left top}
deselectAll
selectInst imem_inst
addRing -stacked_via_top_layer AP -around selected -jog_distance 0.4 -threshold 0.4 -type block_rings -nets {GND VDD} -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2 -skip_side {top right}
deselectAll
selectInst rst_n_pad_in
deselectAll
selectObject Module mini_mips_inst
deselectAll
set sprCreateIeStripeNets {}
set sprCreateIeStripeLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeSpacing 2.0
set sprCreateIeStripeThreshold 1.0
addStripe -block_ring_top_layer_limit M5 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M3 -set_to_set_distance 100 -stacked_via_top_layer AP -padcore_ring_top_layer_limit M5 -spacing 2 -merge_stripes_value 2.5 -layer M4 -block_ring_bottom_layer_limit M3 -width 2 -nets {GND VDD} -stacked_via_bottom_layer M1
addStripe -block_ring_top_layer_limit M4 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M2 -set_to_set_distance 100 -stacked_via_top_layer AP -padcore_ring_top_layer_limit M4 -spacing 2 -merge_stripes_value 2.5 -direction horizontal -layer M3 -block_ring_bottom_layer_limit M2 -width 2 -nets {GND VDD} -stacked_via_bottom_layer M1
zoomBox 94.079 403.846 1136.096 -76.425
zoomBox 124.986 356.513 809.362 116.613
zoomBox 292.213 426.989 664.367 205.630
zoomBox 415.213 369.925 635.457 261.643
zoomBox 475.251 377.067 573.241 291.209
zoomBox 508.606 358.220 549.851 314.346
zoomBox 524.816 342.684 546.753 325.283
zoomBox 530.207 342.039 542.477 330.885
zoomBox 533.552 340.101 540.172 333.671
zoomBox 535.254 338.447 539.087 335.380
zoomBox 535.730 338.050 538.497 335.494
fit
setPrerouteAsObs {1 2 3 4 5 6 7 8}
setPlaceMode -fp false
placeDesign -prePlaceOpt
setDrawView ameba
setDrawView place
createClockTreeSpec -bufferList {HS65_LH_BFX106 HS65_LH_BFX13 HS65_LH_BFX142 HS65_LH_BFX18 HS65_LH_BFX2 HS65_LH_BFX213 HS65_LH_BFX22 HS65_LH_BFX27 HS65_LH_BFX284 HS65_LH_BFX31 HS65_LH_BFX35 HS65_LH_BFX4 HS65_LH_BFX40 HS65_LH_BFX44 HS65_LH_BFX49 HS65_LH_BFX53 HS65_LH_BFX62 HS65_LH_BFX7 HS65_LH_BFX71 HS65_LH_BFX9 HS65_LH_CNBFX10 HS65_LH_CNBFX103 HS65_LH_CNBFX124 HS65_LH_CNBFX14 HS65_LH_CNBFX17 HS65_LH_CNBFX21 HS65_LH_CNBFX24 HS65_LH_CNBFX27 HS65_LH_CNBFX31 HS65_LH_CNBFX34 HS65_LH_CNBFX38 HS65_LH_CNBFX38_0 HS65_LH_CNBFX38_1 HS65_LH_CNBFX38_10 HS65_LH_CNBFX38_11 HS65_LH_CNBFX38_12 HS65_LH_CNBFX38_13 HS65_LH_CNBFX38_14 HS65_LH_CNBFX38_15 HS65_LH_CNBFX38_16 HS65_LH_CNBFX38_17 HS65_LH_CNBFX38_18 HS65_LH_CNBFX38_19 HS65_LH_CNBFX38_2 HS65_LH_CNBFX38_20 HS65_LH_CNBFX38_21 HS65_LH_CNBFX38_22 HS65_LH_CNBFX38_23 HS65_LH_CNBFX38_3 HS65_LH_CNBFX38_4 HS65_LH_CNBFX38_5 HS65_LH_CNBFX38_6 HS65_LH_CNBFX38_7 HS65_LH_CNBFX38_8 HS65_LH_CNBFX38_9 HS65_LH_CNBFX41 HS65_LH_CNBFX45 HS65_LH_CNBFX48 HS65_LH_CNBFX52 HS65_LH_CNBFX55 HS65_LH_CNBFX58 HS65_LH_CNBFX62 HS65_LH_CNBFX82 HS65_LH_CNIVX10 HS65_LH_CNIVX103 HS65_LH_CNIVX124 HS65_LH_CNIVX14 HS65_LH_CNIVX17 HS65_LH_CNIVX21 HS65_LH_CNIVX24 HS65_LH_CNIVX27 HS65_LH_CNIVX3 HS65_LH_CNIVX31 HS65_LH_CNIVX34 HS65_LH_CNIVX38 HS65_LH_CNIVX41 HS65_LH_CNIVX45 HS65_LH_CNIVX48 HS65_LH_CNIVX52 HS65_LH_CNIVX55 HS65_LH_CNIVX58 HS65_LH_CNIVX62 HS65_LH_CNIVX7 HS65_LH_CNIVX82 HS65_LH_DLYIC2X4 HS65_LH_DLYIC2X7 HS65_LH_DLYIC2X9 HS65_LH_DLYIC4X4 HS65_LH_DLYIC4X7 HS65_LH_DLYIC4X9 HS65_LH_DLYIC6X4 HS65_LH_DLYIC6X7 HS65_LH_DLYIC6X9 HS65_LH_IVX106 HS65_LH_IVX13 HS65_LH_IVX142 HS65_LH_IVX18 HS65_LH_IVX2 HS65_LH_IVX213 HS65_LH_IVX22 HS65_LH_IVX27 HS65_LH_IVX284 HS65_LH_IVX31 HS65_LH_IVX35 HS65_LH_IVX4 HS65_LH_IVX40 HS65_LH_IVX44 HS65_LH_IVX49 HS65_LH_IVX53 HS65_LH_IVX62 HS65_LH_IVX7 HS65_LH_IVX71 HS65_LH_IVX9} -file netlists/Clock.ctstch
clockDesign -specFile netlists/Clock.ctstch -outDir clock_report -fixedInstBeforeCTS
zoomBox 380.850 249.096 383.180 246.293
zoomBox 380.957 249.086 383.158 246.317
zoomBox 381.846 247.349 382.422 246.792
selectWire 381.9500 247.0550 382.1450 247.1550 1 mini_mips_inst/id_top_inst/regfile_inst/n1214
deselectAll
selectInst mini_mips_inst/id_top_inst/regfile_inst/U1934
fit
deleteTrialRoute
fit
deselectAll
displayClockTree -skew -allLevel -preRoute
zoomBox 494.564 377.366 579.919 306.835
panPage -1 0
panPage -1 0
zoomBox 278.991 357.022 317.695 338.095
zoomBox 291.518 350.938 299.730 345.412
zoomBox 292.364 350.194 294.519 348.144
zoomBox 293.134 350.095 293.699 349.442
zoomBox 293.237 349.977 293.468 349.733
zoomBox 293.260 349.936 293.402 349.827
zoomBox 293.281 349.913 293.343 349.864
zoomBox 283.453 351.952 293.870 345.549
clearClockDisplay
getFillerMode -quiet
setDrawView fplan
setDrawView place
sroute -connect { blockPin padPin padRing corePin } -layerChangeRange { M1 AP } -blockPinTarget { nearestRingStripe nearestTarget } -padPinPortConnect { allPort oneGeom } -checkAlignedSecondaryPin 1 -blockPin useLef -allowJogging 1 -crossoverViaBottomLayer M1 -allowLayerChange 1 -targetViaTopLayer AP -crossoverViaTopLayer AP -targetViaBottomLayer M1 -nets { GND VDD }
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven false
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix mini_mips_p_postRoute -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix mini_mips_p_postRoute -outDir timingReports
panCenter 496.622 520.244
zoomBox 101.730 681.475 481.739 504.866
zoomBox 168.307 684.282 248.719 645.373
zoomBox 4.842 721.007 327.147 425.135
zoomBox 74.111 657.670 178.483 550.918
zoomBox 95.505 635.890 141.424 597.267
fit
zoomBox 41.611 277.849 453.860 8.572
fit
addIoFiller -cell IOFILLER16_ST_SF_LIN IOFILLER1_ST_SF_LIN IOFILLER2_ST_SF_LIN IOFILLER4_ST_SF_LIN IOFILLER8_ST_SF_LIN -prefix IO_FILLER -side e -fillAnyGap
zoomBox 65.293 189.260 362.638 -30.022
zoomBox 126.693 137.249 203.828 70.693
zoomBox 178.706 130.226 203.188 107.951
zoomBox 183.716 127.226 194.641 119.010
windowSelect 729.003 360.178 707.736 333.593
deselectAll
selectInst imem_inst
deselectAll
panPage 1 0
panPage -1 0
fit
zoomBox 726.646 471.694 1030.131 252.413
zoomBox 775.029 390.593 879.270 318.748
saveDesign netlists/mini_mips_p.enc
saveDesign netlists/mini_mips_p.enc
selectInst IO_FILLER_E_25
deleteSelectedFromFPlan
windowSelect 874.693 135.713 870.656 277.039
selectInst IO_FILLER_E_37
zoomBox 981.024 372.603 738.751 6.501
deselectAll
selectInst IO_FILLER_E_0
selectInst IO_FILLER_E_32
selectInst IO_FILLER_E_29
selectInst IO_FILLER_E_1
selectInst IO_FILLER_E_2
selectInst IO_FILLER_E_3
selectInst IO_FILLER_E_4
selectInst IO_FILLER_E_6
selectInst IO_FILLER_E_7
windowAddSelect 846.641 140.432 847.009 143.743
windowAddSelect 846.641 147.055 846.641 149.998
selectInst IO_FILLER_E_13
selectInst IO_FILLER_E_15
selectInst IO_FILLER_E_17
windowSelect 849.216 195.623 864.670 133.073
windowToggleSelect 862.094 125.714 854.736 268.475
zoomBox 849.514 342.864 892.299 194.413
selectInst IO_FILLER_E_57
selectInst IO_FILLER_E_54
selectInst IO_FILLER_E_56
selectInst IO_FILLER_E_55
deleteSelectedFromFPlan
windowSelect 851.361 286.020 855.688 274.084
selectInst IO_FILLER_E_52
deselectAll
selectInst IO_FILLER_E_53
undo
undo
deselectAll
uiSetTool select
addIoFiller -cell IOFILLER16_ST_SF_LIN IOFILLER1_ST_SF_LIN IOFILLER2_ST_SF_LIN IOFILLER4_ST_SF_LIN IOFILLER8_ST_SF_LIN -prefix IO_FILLER -side n
addIoFiller -cell IOFILLER16_ST_SF_LIN IOFILLER1_ST_SF_LIN IOFILLER2_ST_SF_LIN IOFILLER4_ST_SF_LIN IOFILLER8_ST_SF_LIN -prefix IO_FILLER -side s
addIoFiller -cell IOFILLER16_ST_SF_LIN IOFILLER1_ST_SF_LIN IOFILLER2_ST_SF_LIN IOFILLER4_ST_SF_LIN IOFILLER8_ST_SF_LIN -prefix IO_FILLER -side w
addIoFiller -cell IOFILLER16_ST_SF_LIN IOFILLER1_ST_SF_LIN IOFILLER2_ST_SF_LIN IOFILLER4_ST_SF_LIN IOFILLER8_ST_SF_LIN -prefix IO_FILLER -side e
setDrawView ameba
setDrawView place
zoomBox 0.386 792.722 921.368 -1.954
zoomBox 774.753 425.334 1026.334 245.633
zoomBox 768.883 394.270 948.222 318.597
zoomBox 787.449 392.699 919.454 351.486
deselectAll
selectMarker 808.0000 373.5000 920.0000 376.7000 -1 12 97
deleteSelectedFromFPlan
selectInst IO_FILLER_E_164
deleteSelectedFromFPlan
windowSelect 828.372 377.011 833.253 371.079
zoomBox 804.043 383.393 837.157 359.140
zoomBox 809.558 378.469 818.698 370.352
selectInst IO_FILLER_E_166
undo
undo
deselectAll
fit
zoomBox 4.771 374.333 307.380 78.742
zoomBox 89.530 252.829 204.499 169.647
windowSelect 121.162 227.698 121.524 221.175
panPage 0 1
panPage 0 -1
panPage 0 1
panPage 0 1
panPage -1 0
panPage 1 0
zoomBox 100.220 406.391 141.331 378.852
zoomBox 107.186 403.374 124.955 392.248
zoomBox 110.591 401.272 117.009 394.384
panPage 0 1
panPage 0 1
panPage 0 1
panPage 0 1
panPage 0 1
zoomBox 100.895 682.987 120.708 668.957
zoomBox 106.783 682.268 113.086 676.980
panPage 1 0
panPage 1 0
panPage 1 0
panPage 1 0
panPage 1 0
panPage 1 0
panPage -1 0
panPage 0 1
panPage 0 1
panPage 0 1
panPage 0 1
panPage 0 1
panPage 0 -1
panPage 1 0
panPage -1 0
panPage 0 -1
panPage 1 0
panPage 0 -1
panPage -1 0
panPage 0 -1
panPage 1 0
panPage 0 -1
panPage -1 0
panPage 1 0
panPage 1 0
panPage 1 0
panPage 1 0
panPage 1 0
panPage 0 -1
panPage 0 -1
panPage -1 0
panPage 0 -1
panPage 0 -1
panPage 0 -1
panPage 0 -1
zoomBox 358.294 231.082 423.161 178.009
zoomBox 358.510 218.601 384.540 200.358
zoomBox 360.543 215.282 372.332 206.610
zoomBox 362.959 213.443 369.243 211.107
zoomBox 364.435 212.995 368.217 211.186
zoomBox 364.936 212.716 366.089 212.316
panPage 0 -1
panPage 0 -1
panPage 0 -1
panPage 0 -1
panPage 0 -1
panPage 0 -1
panPage 0 -1
panPage 0 -1
panPage 0 1
panPage 1 0
panPage 1 0
panPage 1 0
panPage 0 1
panPage 0 1
panPage 0 1
panPage -1 0
panPage -1 0
panPage 0 -1
zoomBox 466.141 299.481 515.537 266.178
zoomBox 469.551 286.595 494.018 274.110
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix mini_mips_p_postRoute -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix mini_mips_p_postRoute -outDir timingReports
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postRoute -hold
selectWire 460.6000 274.2000 504.2000 274.6000 7 mini_mips_inst/id_top_inst/regfile_inst/FE_PHN1113_n231
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postRoute -hold
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postRoute
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -preCTS -idealClock -pathReports -drvReports -slackReports -numPaths 50 -prefix mini_mips_p_preCTS -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix mini_mips_p_postRoute -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix mini_mips_p_postRoute -outDir timingReports
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postRoute
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postRoute -hold
getFillerMode -quiet
zoomBox 143.278 483.844 703.336 212.776
zoomBox 264.337 446.272 505.818 309.284
zoomBox 377.368 415.846 470.850 331.312
zoomBox 261.934 484.310 545.228 256.354
zoomBox 292.467 432.075 484.912 323.710
zoomBox 361.870 408.708 415.509 364.921
zoomBox 374.519 397.134 391.374 381.556
zoomBox 379.517 393.549 384.558 387.756
zoomBox 361.061 389.770 396.361 373.622
setDrawView ameba
setDrawView fplan
setDrawView ameba
setDrawView place
setDrawView ameba
setDrawView fplan
uiSetTool move
selectInst dmem_inst
setObjFPlanBox Instance dmem_inst 316.067 333.307 620.867 645.107
undo
uiSetTool select
setDrawView place
addFiller -cell HS65_50_DECAP64 HS65_50_DECAP32 HS65_50_DECAP16 HS65_50_DECAP12 HS65_50_DECAP9 -prefix FILLER -markFixed
fit
setLayerPreference allM1 -isVisible 0
setLayerPreference allM1 -isSelectable 0
setLayerPreference allM1 -isVisible 1
setLayerPreference allM1 -isSelectable 1
setDrawView fplan
setDrawView ameba
setDrawView place
saveDesign netlists/mini_mips_p.enc
saveDesign netlists/mini_mips_p.enc
