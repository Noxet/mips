#######################################################
#                                                     #
#  Encounter Command Logging File                     #
#  Created on Mon May 12 13:01:29 2014                #
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
set init_design_settop 0
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
selectInst imem_inst
uiSetTool move
setObjFPlanBox Instance imem_inst 442.705 400.0 747.505 711.8
deselectAll
selectInst dmem_inst
setObjFPlanBox Instance dmem_inst 122.001 400.0 436.801 711.8
uiSetTool ruler
setIoFlowFlag 0
floorPlan -site CORE -s 615.505 579.8 20.0 20.0 20.0 20.0
uiSetTool select
getIoFlowFlag 
# changed the working design from here
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
set sprCreateIeRingNets {}
set sprCreateIeRingLayers {}
set sprCreateIeRingWidth 1.0
set sprCreateIeRingSpacing 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
addRing -stacked_via_top_layer AP -around core -jog_distance 2.5 -threshold 2.5 -nets {GND VDD} -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2
deselectAll
addRing -stacked_via_top_layer AP -around selected -jog_distance 0.4 -threshold 0.4 -type block_rings -nets {GND VDD} -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2 -skip_side {left top}
deselectAll
selectInst imem_inst
addRing -stacked_via_top_layer AP -around selected -jog_distance 0.4 -threshold 0.4 -type block_rings -nets {GND VDD} -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 2 -skip_side {top right}
deselectAll
set sprCreateIeStripeNets {}
set sprCreateIeStripeLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeSpacing 2.0
set sprCreateIeStripeThreshold 1.0
addStripe -block_ring_top_layer_limit M5 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M3 -set_to_set_distance 100 -stacked_via_top_layer AP -padcore_ring_top_layer_limit M5 -spacing 2 -merge_stripes_value 2.5 -layer M4 -block_ring_bottom_layer_limit M3 -width 2 -nets {GND VDD} -stacked_via_bottom_layer M1
addStripe -block_ring_top_layer_limit M4 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M2 -set_to_set_distance 100 -stacked_via_top_layer AP -padcore_ring_top_layer_limit M4 -spacing 2 -merge_stripes_value 2.5 -direction horizontal -layer M3 -block_ring_bottom_layer_limit M2 -width 2 -nets {GND VDD} -stacked_via_bottom_layer M1
setPrerouteAsObs {1 2 3 4 5 6 7 8}
setPlaceMode -fp false
placeDesign -prePlaceOpt
createClockTreeSpec -bufferList {HS65_LH_BFX106 HS65_LH_BFX13 HS65_LH_BFX142 HS65_LH_BFX18 HS65_LH_BFX2 HS65_LH_BFX213 HS65_LH_BFX22 HS65_LH_BFX27 HS65_LH_BFX284 HS65_LH_BFX31 HS65_LH_BFX35 HS65_LH_BFX4 HS65_LH_BFX40 HS65_LH_BFX44 HS65_LH_BFX49 HS65_LH_BFX53 HS65_LH_BFX62 HS65_LH_BFX7 HS65_LH_BFX71 HS65_LH_BFX9 HS65_LH_CNBFX10 HS65_LH_CNBFX103 HS65_LH_CNBFX124 HS65_LH_CNBFX14 HS65_LH_CNBFX17 HS65_LH_CNBFX21 HS65_LH_CNBFX24 HS65_LH_CNBFX27 HS65_LH_CNBFX31 HS65_LH_CNBFX34 HS65_LH_CNBFX38 HS65_LH_CNBFX38_0 HS65_LH_CNBFX38_1 HS65_LH_CNBFX38_10 HS65_LH_CNBFX38_11 HS65_LH_CNBFX38_12 HS65_LH_CNBFX38_13 HS65_LH_CNBFX38_14 HS65_LH_CNBFX38_15 HS65_LH_CNBFX38_16 HS65_LH_CNBFX38_17 HS65_LH_CNBFX38_18 HS65_LH_CNBFX38_19 HS65_LH_CNBFX38_2 HS65_LH_CNBFX38_20 HS65_LH_CNBFX38_21 HS65_LH_CNBFX38_22 HS65_LH_CNBFX38_23 HS65_LH_CNBFX38_3 HS65_LH_CNBFX38_4 HS65_LH_CNBFX38_5 HS65_LH_CNBFX38_6 HS65_LH_CNBFX38_7 HS65_LH_CNBFX38_8 HS65_LH_CNBFX38_9 HS65_LH_CNBFX41 HS65_LH_CNBFX45 HS65_LH_CNBFX48 HS65_LH_CNBFX52 HS65_LH_CNBFX55 HS65_LH_CNBFX58 HS65_LH_CNBFX62 HS65_LH_CNBFX82 HS65_LH_CNIVX10 HS65_LH_CNIVX103 HS65_LH_CNIVX124 HS65_LH_CNIVX14 HS65_LH_CNIVX17 HS65_LH_CNIVX21 HS65_LH_CNIVX24 HS65_LH_CNIVX27 HS65_LH_CNIVX3 HS65_LH_CNIVX31 HS65_LH_CNIVX34 HS65_LH_CNIVX38 HS65_LH_CNIVX41 HS65_LH_CNIVX45 HS65_LH_CNIVX48 HS65_LH_CNIVX52 HS65_LH_CNIVX55 HS65_LH_CNIVX58 HS65_LH_CNIVX62 HS65_LH_CNIVX7 HS65_LH_CNIVX82 HS65_LH_DLYIC2X4 HS65_LH_DLYIC2X7 HS65_LH_DLYIC2X9 HS65_LH_DLYIC4X4 HS65_LH_DLYIC4X7 HS65_LH_DLYIC4X9 HS65_LH_DLYIC6X4 HS65_LH_DLYIC6X7 HS65_LH_DLYIC6X9 HS65_LH_IVX106 HS65_LH_IVX13 HS65_LH_IVX142 HS65_LH_IVX18 HS65_LH_IVX2 HS65_LH_IVX213 HS65_LH_IVX22 HS65_LH_IVX27 HS65_LH_IVX284 HS65_LH_IVX31 HS65_LH_IVX35 HS65_LH_IVX4 HS65_LH_IVX40 HS65_LH_IVX44 HS65_LH_IVX49 HS65_LH_IVX53 HS65_LH_IVX62 HS65_LH_IVX7 HS65_LH_IVX71 HS65_LH_IVX9} -file netlists/Clock.ctstch
clockDesign -specFile netlists/Clock.ctstch -outDir clock_report -fixedInstBeforeCTS
zoomBox 380.850 249.096 383.180 246.293
zoomBox 380.957 249.086 383.158 246.317
zoomBox 381.846 247.349 382.422 246.792
selectWire 381.9500 247.0550 382.1450 247.1550 1 mini_mips_inst/id_top_inst/regfile_inst/n1214
deselectAll
selectInst mini_mips_inst/id_top_inst/regfile_inst/U1934
deleteTrialRoute
deselectAll
displayClockTree -skew -allLevel -preRoute
clearClockDisplay
getFillerMode -quiet
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
addIoFiller -cell IOFILLER16_ST_SF_LIN IOFILLER1_ST_SF_LIN IOFILLER2_ST_SF_LIN IOFILLER4_ST_SF_LIN IOFILLER8_ST_SF_LIN -prefix IO_FILLER -side e
uiSetTool select
addIoFiller -cell IOFILLER16_ST_SF_LIN IOFILLER1_ST_SF_LIN IOFILLER2_ST_SF_LIN IOFILLER4_ST_SF_LIN IOFILLER8_ST_SF_LIN -prefix IO_FILLER -side n
addIoFiller -cell IOFILLER16_ST_SF_LIN IOFILLER1_ST_SF_LIN IOFILLER2_ST_SF_LIN IOFILLER4_ST_SF_LIN IOFILLER8_ST_SF_LIN -prefix IO_FILLER -side s
addIoFiller -cell IOFILLER16_ST_SF_LIN IOFILLER1_ST_SF_LIN IOFILLER2_ST_SF_LIN IOFILLER4_ST_SF_LIN IOFILLER8_ST_SF_LIN -prefix IO_FILLER -side w
deselectAll
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix mini_mips_p_postRoute -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix mini_mips_p_postRoute -outDir timingReports
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
# optDesign -postRoute -hold ######################
selectWire 460.6000 274.2000 504.2000 274.6000 7 mini_mips_inst/id_top_inst/regfile_inst/FE_PHN1113_n231
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
# optDesign -postRoute -hold #################
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
# optDesign -postRoute ###############
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -preCTS -idealClock -pathReports -drvReports -slackReports -numPaths 50 -prefix mini_mips_p_preCTS -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix mini_mips_p_postRoute -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix mini_mips_p_postRoute -outDir timingReports
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
# optDesign -postRoute #####################
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
# optDesign -postRoute -hold #################
getFillerMode -quiet
uiSetTool move
selectInst dmem_inst
setObjFPlanBox Instance dmem_inst 316.067 333.307 620.867 645.107
undo
uiSetTool select
setDrawView place
addFiller -cell HS65_50_DECAP64 HS65_50_DECAP32 HS65_50_DECAP16 HS65_50_DECAP12 HS65_50_DECAP9 -prefix FILLER -markFixed
setLayerPreference allM1 -isVisible 0
setLayerPreference allM1 -isSelectable 0
setLayerPreference allM1 -isVisible 1
setLayerPreference allM1 -isSelectable 1
saveDesign netlists/mini_mips_p.enc
saveDesign netlists/mini_mips_p.enc
setDrawView ameba
