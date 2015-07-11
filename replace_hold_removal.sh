#!/bin/sh

sed 's/HOLD (posedge RN)/REMOVAL (posedge RN)/' $1 > ${1}.tmp
sed 's/HOLD (posedge SN)/REMOVAL (posedge SN)/' ${1}.tmp > $2
rm ${1}.tmp
