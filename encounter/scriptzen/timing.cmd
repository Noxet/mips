
###### TIMING REPORT ######

### setup time ###
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix mini_mips_p_postRoute -outDir timingReports

### hold time ###
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix mini_mips_p_postRoute -outDir timingReports
