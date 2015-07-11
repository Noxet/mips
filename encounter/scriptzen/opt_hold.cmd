
###### OPTIMIZATION ######

### optimize hold ###
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postRoute -hold
