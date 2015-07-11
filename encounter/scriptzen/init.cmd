

#####################################################
## RUN ENCOUNTER IN mips_project/encounter/ FOLDER ##
#####################################################


#freeDesign

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
win


source ./scriptzen/Default_BC_WC_ST65.globals
init_design

#########################################

### set process to 65 nm ###
setDesignMode -process 65

### connect global nets ###
globalNetConnect VDD -type pgpin -pin VDD -inst PVCCc
globalNetConnect GND -type pgpin -pin GND -inst PGNDc

globalNetConnect VDD -type pgpin -pin vdd -inst *
globalNetConnect VDD -type tiehi
globalNetConnect GND -type pgpin -pin gnd -inst *
globalNetConnect GND -type tielo

### floor plan ###
# width height spacings
floorPlan -site CORE -s 629.6 750.0 20.0 20.0 20.0 20.0

### place memories ###
placeInstance dmem_inst 132.0 132.0 R180
placeInstance imem_inst 456.8 132.0 R180

addHaloToBlock 10 10 10 10 -allBlock

### ALIGN THE PADS HERE IF NECESSARY ###
# move clock pad
#selectInst clk_pad_in
#selectInst Pcornerll
#spaceIoInst -fixside bottom -space 420

#deselectAll

# move rst pad
#selectInst rst_n_pad_in
#selectInst Pcornerlr
#spaceIoInst -fixside bottom -space 420

#deselectAll


### cut rows ###
selectInst dmem_inst
selectInst imem_inst
cutRow -selected

### power planning ###
source ./scriptzen/power.cmd

### place standard cells ###
setPrerouteAsObs {1 2 3 4 5 6 7 8}
setPlaceMode -fp false
placeDesign -prePlaceOpt


### synth clock ###
source ./scriptzen/clock.cmd

### place IO fillers ###
#addIoFiller -cell IOFILLER16_ST_SF_LIN IOFILLER1_ST_SF_LIN IOFILLER2_ST_SF_LIN IOFILLER4_ST_SF_LIN IOFILLER8_ST_SF_LIN -prefix IO_FILLER -side n
#addIoFiller -cell IOFILLER16_ST_SF_LIN IOFILLER1_ST_SF_LIN IOFILLER2_ST_SF_LIN IOFILLER4_ST_SF_LIN IOFILLER8_ST_SF_LIN -prefix IO_FILLER -side e
#addIoFiller -cell IOFILLER16_ST_SF_LIN IOFILLER1_ST_SF_LIN IOFILLER2_ST_SF_LIN IOFILLER4_ST_SF_LIN IOFILLER8_ST_SF_LIN -prefix IO_FILLER -side s
#addIoFiller -cell IOFILLER16_ST_SF_LIN IOFILLER1_ST_SF_LIN IOFILLER2_ST_SF_LIN IOFILLER4_ST_SF_LIN IOFILLER8_ST_SF_LIN -prefix IO_FILLER -side w

### routing ###
source ./scriptzen/route.cmd

### report timing ###
source ./scriptzen/timing.cmd

### optimize ###
#source ./scriptzen/opt_setup.cmd
#source ./scriptzen/opt_hold.cmd

### place filler cells ###
getFillerMode -quiet
addFiller -cell HS65_LH_FILLERPFOP64 HS65_LH_FILLERPFOP32 HS65_LH_FILLERPFOP16 HS65_LH_FILLERPFOP12 HS65_LH_FILLERPFOP9 HS65_LH_FILLERPFOP8 -prefix FILLER

### save sdf and netlist ###
write_sdf mini_mips_p.sdf
saveNetlist mini_mips_p.v
