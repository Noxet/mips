#######################################################
#                                                     #
#  Encounter Command Logging File                     #
#  Created on Tue May 13 13:25:13 2014                #
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
init_design
fit
setDrawView ameba
setDrawView fplan
uiSetTool move
selectInst dmem_inst
setObjFPlanBox Instance dmem_inst 112.935 366.312 417.735 678.112
deselectAll
selectInst imem_inst
setObjFPlanBox Instance imem_inst 434.346 367.185 739.146 678.985
zoomBox 372.509 631.885 561.347 484.137
uiSetTool ruler
uiSetTool move
uiSetTool ruler
uiSetTool move
setObjFPlanBox Instance imem_inst 442.809 364.067 747.609 675.867
fit
zoomBox 89.251 735.047 310.437 544.460
zoomBox 93.728 688.885 137.400 655.556
deselectAll
selectInst dmem_inst
setObjFPlanBox Instance dmem_inst 112.031 367.014 416.831 678.814
zoomBox 110.271 680.477 113.219 677.161
zoomBox 111.561 679.254 112.688 678.171
zoomBox 111.961 678.908 112.362 678.551
setObjFPlanBox Instance dmem_inst 112.0 367.0 416.8 678.8
fit
zoomBox 424.964 749.035 607.682 500.747
zoomBox 500.852 706.863 564.483 614.286
panPage -1 0
deselectAll
selectInst imem_inst
setObjFPlanBox Instance imem_inst 442.81 367.042 747.61 678.842
setObjFPlanBox Instance imem_inst 442.81 366.854 747.61 678.654
zoomBox 443.895 677.183 444.267 677.555
zoomBox 443.080 678.875 443.686 677.658
setObjFPlanBox Instance imem_inst 442.811 367.001 747.611 678.801
zoomBox 443.262 678.841 443.399 678.600
zoomBox 443.297 678.826 443.361 678.756
fit
clearGlobalNets
globalNetConnect VDD -type pgpin -pin VDD -inst *
globalNetConnect VDD -type tiehi -inst *
globalNetConnect GND -type pgpin -pin GND -inst *
globalNetConnect GND -type tielo -inst *
zoomBox 675.000 666.855 753.682 614.400
uiSetTool ruler
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site CORE -s 635.57 566.8 0.0 0.0 0.0 0.0
uiSetTool select
getIoFlowFlag
fit
zoomBox 686.815 694.831 798.719 603.035
zoomBox 736.401 686.159 763.341 659.958
zoomBox 746.000 680.181 751.898 672.650
zoomBox 746.557 679.288 748.798 676.904
zoomBox 747.181 678.986 747.572 678.528
deselectAll
selectInst imem_inst
uiSetTool move
setObjFPlanBox Instance imem_inst 442.77 367.0 747.57 678.8
fit
uiSetTool select
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site CORE -s 635.57 566.8 20 20 20 20
uiSetTool select
getIoFlowFlag
fit
setIoFlowFlag 0
floorPlan -site CORE -s 635.57 566.8 20.0 20.0 20.0 20.0
uiSetTool select
getIoFlowFlag
fit
uiSetTool move
zoomBox 88.826 722.629 272.520 538.935
zoomBox 97.964 710.814 156.672 651.182
zoomBox 106.282 699.847 139.964 672.757
deselectAll
selectInst dmem_inst
setObjFPlanBox Instance dmem_inst 132.039 386.984 436.839 698.784
zoomBox 131.508 699.548 136.219 694.946
zoomBox 131.801 699.104 132.666 698.119
setObjFPlanBox Instance dmem_inst 132.0 387.0 436.8 698.8
zoomBox 131.860 698.896 132.095 698.661
zoomBox 131.956 698.819 132.019 698.764
fit
zoomBox 694.099 729.977 988.010 424.125
zoomBox 715.332 715.222 800.479 622.698
zoomBox 734.100 702.018 779.200 662.125
zoomBox 745.945 700.494 768.999 676.318
deselectAll
selectInst imem_inst
setObjFPlanBox Instance imem_inst 462.645 386.949 767.445 698.749
zoomBox 765.806 699.522 769.717 696.534
zoomBox 767.236 699.084 768.062 698.234
zoomBox 767.334 698.899 767.635 698.542
setObjFPlanBox Instance imem_inst 462.77 387.0 767.57 698.8
fit
uiSetTool select
deselectAll
selectInst dmem_inst
addHaloToBlock 10 10 0 10 -allBlock
addHaloToBlock 10 10 10 10 -allBlock
zoomBox 418.557 599.554 531.529 428.718
zoomBox 441.734 543.753 473.497 508.041
zoomBox 417.201 492.749 541.286 321.437
uiSetTool ruler
zoomBox 444.636 428.012 454.106 413.377
fit
zoomBox 447.030 429.636 460.807 401.164
zoomBox 445.019 416.645 456.179 410.865
zoomBox 446.498 414.450 452.999 412.222
fit
uiSetTool move
uiSetTool select
deselectAll
selectInst imem_inst
placeInstance imem_inst 456.8 387.0 R0
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site CORE -s 629.6 566.8 20.0 20.0 20.0 20.0
uiSetTool select
getIoFlowFlag
fit
setIoFlowFlag 0
floorPlan -site CORE -s 629.6 566.8 20.0 20.0 20.0 20.0
uiSetTool select
getIoFlowFlag
fit
addHaloToBlock 10 10 10 10 -allBlock
zoomBox 95.025 729.058 271.372 532.505
zoomBox 120.379 707.132 168.382 646.881
zoomBox 121.612 701.319 142.442 671.890
uiSetTool move
deselectAll
selectInst dmem_inst
setObjFPlanBox Instance dmem_inst 132.004 386.994 436.804 698.794
zoomBox 131.850 699.397 135.842 695.552
zoomBox 131.778 698.968 132.717 698.083
zoomBox 131.972 698.851 132.167 698.682
zoomBox 131.983 698.808 132.045 698.763
setObjFPlanBox Instance dmem_inst 132.0 387.0 436.8 698.8
fit
deselectAll
selectInst imem_inst
setObjFPlanBox Instance imem_inst 455.913 387.206 760.713 699.006
zoomBox 742.548 713.444 770.102 677.624
zoomBox 758.197 701.204 768.169 691.628
zoomBox 760.218 699.510 763.250 696.546
zoomBox 760.524 699.224 762.201 698.092
setObjFPlanBox Instance imem_inst 456.799 387.0 761.599 698.8
zoomBox 761.467 698.911 761.723 698.663
zoomBox 761.562 698.818 761.648 698.738
zoomBox 761.590 698.805 761.617 698.782
zoomBox 761.597 698.802 761.605 698.795
fit
setDrawView place
zoomBox 431.048 433.447 598.210 266.285
zoomBox 425.588 409.591 485.564 353.142
zoomBox 435.549 398.642 460.852 374.076
zoomBox 442.447 393.729 453.163 382.026
fit
uiSetTool select
deselectAll
selectInst dmem_inst
deselectAll
selectInst dmem_inst
setDrawView fplan
deselectAll
selectInst imem_inst
deselectAll
selectInst dmem_inst
deselectAll
selectInst imem_inst
deselectAll
selectInst dmem_inst
setDrawView place
deselectAll
selectInst dmem_inst
cutRow -selected
deselectAll
selectInst imem_inst
cutRow -selected
cutRow -selected
uiSetTool move
deselectAll
selectInst dmem_inst
setObjFPlanBox Instance dmem_inst 110.875 227.186 415.675 538.986
redraw
undo
deselectAll
selectInst imem_inst
setObjFPlanBox Instance imem_inst 438.43 212.49 743.23 524.29
undo