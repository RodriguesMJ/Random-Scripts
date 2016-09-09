#Script to run aimless and truncate on the unscaled mtzs that blend has constructed 
#for each of the composite datasets.  

find /dls/mx-scratch/matt/FutA/process_160831/blend -name "unscaled_200.mtz" | sort > ori1.dat

file_no=`wc ori1.dat | awk '{print $1}'`
echo There are $file_no datasets to process

a=1

while [ $a -le $file_no ]
	do
	aa=`printf "%03d" $a`
	mkdir ./aimless_$aa

	AIM_IN="`awk "FNR == $a" ori1.dat`"

	AIM_OUT=./aimless_$aa/aimless_sweep_$aa.mtz
	TRU_OUT=./aimless_$aa/ctruncate_sweep_$aa.mtz
	
	#A reference MTZ is used to ensure consistent indexing between sweeps 
	REF_MTZ=/dls/mx-scratch/matt/FutA/process_160831/blend/blendsweep_001/merged_files/BS_001_200aimless1.mtz

	echo Running AIMLESS sweep $aa

aimless hklin $AIM_IN hklout $AIM_OUT <<EOF > ./aimless_$aa/aimless_sweep_$aa.log
RESO HIGH 1.3
HKLREF $REF_MTZ
EOF

	echo Running CTRUNCATE sweep $aa

	cd ./aimless_$aa

ctruncate -hklin aimless_sweep_$aa.mtz -hklout truncate_sweep_$aa.mtz \
-colin '/*/*/[IMEAN,SIGIMEAN]'<<EOF-trunc > ./truncate_sweep_$aa.log
title Truncate Fut A $aa
labout  F=F_$aa SIGF=SIGF_$aa
EOF-trunc


	echo Adding Free R flag

cella=`grep cell aimless_sweep_$aa.log | tail -1 | cut -c 22- | rev | cut -c 42- | rev`
cellb=`grep cell aimless_sweep_$aa.log | tail -1 | cut -c 30- | rev | cut -c 34- | rev`
cellc=`grep cell aimless_sweep_$aa.log | tail -1 | cut -c 38- | rev | cut -c 26- | rev`
cellalpha=`grep cell aimless_sweep_$aa.log | tail -1 | cut -c 46- | rev | cut -c 18- | rev`
cellbeta=`grep cell aimless_sweep_$aa.log | tail -1 | cut -c 54- | rev | cut -c 10- | rev`
cellgamma=`grep cell aimless_sweep_$aa.log | tail -1 | cut -c 62- | rev | cut -c 2- | rev`

unique hklout ./unique_sweep_$aa.mtz <<EOF > ./FreeR_$aa.log
SYMMETRY 'P 1 21 1'
LABOUT F=FUNI SIGF=SIGFUNI
CELL $cella $cellb $cellc $cellalpha $cellbeta $cellgamma
RESOLUTION 1.30
EOF

	FREE_MTZ=/dls/mx-scratch/matt/FutA/process_160831/RIDL/FutA_MED4_Raddam_NEW_refine_12.mtz

cad hklin1 unique_sweep_$aa.mtz hklin2 truncate_sweep_$aa.mtz hklin3 $FREE_MTZ hklout cad_sweep_$aa.mtz<<EOF >> ./FreeR_$aa.log
LABIN FILE 1 ALLIN
LABIN FILE 2 E1 = F E2 = SIGF
LABIN FILE 3 E1 = R-free-flags
LABOUT FILE 2 E1 = F_$aa E2 = SIGF_$aa
EOF

mtzutils hklin cad_sweep_$aa.mtz hklout FINISHED_sweep_$aa.mtz <<EOF >> ./FreeR_$aa.log
EXCLUDE FUNI SIGFUNI
EOF

	cat aimless_sweep_$aa.log > sweep_$aa_processing.log
	cat ./truncate_sweep_$aa.log >> sweep_$aa_processing.log
	cat ./FreeR_$aa.log >> sweep_$aa_processing.log

	echo Sweep $aa complete
	cd ../



(( a ++ ))

done

