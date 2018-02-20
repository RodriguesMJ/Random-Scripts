#!/bin/bash 

find ./ -name "INTEGRATE.HKL" | sort > ori3.dat
REF_MTZ=/Users/matt/Dropbox/Pdx1Structures/Yang04092014/ma4-1_refine_026.mtz
FREE_LABEL=R-free-flags

HOME=`pwd`

SWEEP_NO=`wc ori3.dat | awk '{print $1}'` 

echo The image directory contains $SWEEP_NO sweeps

a=1

while [ $a -le $SWEEP_NO ]
	do
	SWEEP_PATH=`awk "FNR == $a" ori3.dat | rev | cut -d/ -f2- | rev`
	SWEEP_PATTERN=`awk "FNR == $a" ori3.dat | rev | cut -d/ -f 1 | rev`

	echo $SWEEP_PATH
	echo $SWEEP_PATTERN

	cd $SWEEP_PATH

	mkdir aimless
	cd aimless
	touch pointless.inp
	echo hklin ../INTEGRATE.HKL > pointless.inp
	#echo SPACEGROUP 146         >> pointless.inp
	echo hklout pointless.mtz   >> pointless.inp
	echo HKLREF $REF_MTZ        >> pointless.inp
	
	pointless < pointless.inp > pointless.log 
	AIM_IN=pointless.mtz
	AIM_OUT=aimless_1.mtz
	
	echo hklin $AIM_IN   >  aimless_001.inp
	echo hklout $AIM_OUT >> aimless_001.inp  
	
        aimless < aimless_001.inp > aimless_001.log

	AIM_OUT=./aimless_002.mtz

        echo hklin $AIM_IN   >  aimless_002.inp
        echo hklout $AIM_OUT >> aimless_002.inp 

        AIM_RES=`cat *001.log | grep "half-dataset correlation CC(1/2)" | head -1 | rev | cut -c 3- | rev | cut -c 60-`
	echo RESO HIGH $AIM_RES >> aimless_002.inp        
	aimless < aimless_002.inp  > aimless_002.log

	TRU_IN=./aimless_002.mtz

ctruncate -hklin $TRU_IN -hklout truncate.mtz \
-colin '/*/*/[IMEAN,SIGIMEAN]'<< EOF-trunc > ./truncate.log
title Truncate sweep $a Crystal $a 
labout  F=F SIGF=SIGF
EOF-trunc

echo Adding Free R flag

AIM_SYM=`grep "Space"  ./aimless_002.log | tail -1 | cut -c 14-`  
SYM_NWS="$(echo "${AIM_SYM}" | tr -d '[:space:]')"

#echo Space group $AIM_SYM or $SYM_NWS with no white space 

cella=`grep cell ./aimless_002.log | tail -1 | cut -c 22- | rev | cut -c 42- | rev`
cellb=`grep cell ./aimless_002.log | tail -1 | cut -c 30- | rev | cut -c 34- | rev`
cellc=`grep cell ./aimless_002.log | tail -1 | cut -c 38- | rev | cut -c 26- | rev`
cellalpha=`grep cell ./aimless_002.log | tail -1 | cut -c 46- | rev | cut -c 18- | rev`
cellbeta=`grep cell ./aimless_002.log | tail -1 | cut -c 54- | rev | cut -c 10- | rev`
cellgamma=`grep cell ./aimless_002.log | tail -1 | cut -c 61- | rev | cut -c 2- | rev`

echo $cella $cellb $cellc $cellalpha $cellbeta $cellgamma 


unique hklout ./unique_"$a".mtz <<EOF > ./FreeR_"$a".log
SYMMETRY $SYM_NWS
LABOUT F=FUNI SIGF=SIGFUNI
CELL $cella $cellb $cellc $cellalpha $cellbeta $cellgamma
RESOLUTION $AIM_RES
EOF

####Assemble the final MTZ

echo Assembling the final MTZ with CAD

cad hklin1 unique_"$a".mtz hklin2 ./truncate.mtz hklin3 $REF_MTZ hklout cad.mtz<<EOF >> ./FreeR_"$a".log
LABIN FILE 1 ALLIN
LABIN FILE 2 E1 = F E2 = SIGF
LABIN FILE 3 E1 = $FREE_LABEL 
EOF

#Remove FUNI and SIGFUNI from unique
mtzutils hklin cad.mtz hklout assembled.mtz <<EOF >> ./FreeR_"$a".log
EXCLUDE FUNI SIGFUNI
EOF

uniqueify -f $FREE_LABEL assembled.mtz FINISHED.mtz


        cd $HOME

	(( a ++ ))
	done
