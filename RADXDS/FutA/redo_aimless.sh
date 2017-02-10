find /Volumes/TewsBackupDisk4/Moritz/process_160831/aimless/ -name "*aimless*log" > ori1.dat
find /Volumes/TewsBackupDisk4/Moritz/process_160831/blend/ -name "unscaled_200.mtz" | sort > ori4.dat
file_no=`wc ori1.dat | awk '{print $1}'`
echo There are $file_no composite datasets to process



a=1
	while [ $a -le $file_no ]
	do

	aa=`printf "%03d" $a`	
	
	#Read in log file for sweep $a aimless 
	AIM_IN="`awk "FNR == $a" ori1.dat`"
	REF_MTZ=/Volumes/TewsBackupDisk4/Moritz/process_160831/blend/blendsweep_001/merged_files/BS_001_200aimless1.mtz
	FREE_MTZ=/Volumes/TewsBackupDisk4/Moritz/process_160831/RIDL/FutA_MED4_Raddam_NEW_refine_12.mtz
	#Cut out scale factor plot and write as ori2.dat
	cat $AIM_IN | awk -v N=3 '{print}/Bdecay/&&--N<=0{exit}' | awk '/Bdecay/{f=1;}f' | sed '1,/Bdecay/d' | sed -n -e :a -e '1,2!{P;N;D;};N;ba' > ori2.dat

	#Cut columns 2 (image number) and 6 (scale factor) from the table and shorten multiple spaces to single space
	cat ori2.dat | tr -s ' ' | cut -d ' ' -f2,6 > ori3.dat
	
	#Calculate the average scale factor for all images in the dataset
	Mn=`awk '{ total += $2 } END { print total/NR }' ori3.dat`

	echo The average scale factor for sweep $aa is $Mn

	#The scale multiplier will be the number of times greater than the mean that the scale factor is allowed to be before that 
	#image is listed to be excluded. 
	SM=50
	
	Mna=$(echo "scale=12; $Mn*$SM" | bc)
		
		if [ $a -eq 28 ]; then
		Mna=5000
		fi
		
		if [ $a -eq 24 ]; then
		Mna=5000
		fi

		if (( $(bc <<<"$Mna >= 5001") )); then
			Mna=5000
		fi

		if (( $(bc <<<"$Mna <= 100") )); then
			Mna=150
		fi

	echo Any images with a scale factor greater than $Mna should be eliminated

	#Search ori3 for images to be excluded
	awk -v Mna="$Mna" '$2 > Mna' ori3.dat

	awk -v Mna="$Mna" '$2 > Mna' ori3.dat > excludesweep_$aa.dat

	ab=`wc excludesweep_$aa.dat | awk '{print $1}'`
	
	if [ $ab -eq 0 ]; then
			echo Sweep $aa has no images to be excluded and aimless does not have to be re-run but will be anyway >> aimless_redo.log
 			mkdir ./aimless_$aa

 			MTZ_IN="`awk "FNR == $a" ori4.dat`"

 			AIM_OUT=./aimless_$aa/aimless_sweep_$aa.mtz
			TRU_OUT=./aimless_$aa/ctruncate_sweep_$aa.mtz
			echo Running AIMLESS sweep $aa

			aimless hklin $MTZ_IN hklout $AIM_OUT <<EOF > ./aimless_$aa/aimless_sweep_$aa.log
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


	fi
	
	if [ $ab -gt 0 ]; then
			echo Sweep $aa has $ab images to be excluded and aimless does have to be re-run >> aimless_redo.log
			awk 'NR!=0{print $1}' excludesweep_$aa.dat > tmp1
			c=1
			
			while [ $c -le $ab ]
			do

				echo -n `awk "FNR == $c" tmp1` >> tmp2
				echo -n " " >> tmp2
				(( c ++ ))
			done
			exclude_list=`cat tmp2`
			rm tmp2
			echo The excluded files for sweep $aa are $exclude_list >> aimless_redo.log 

			mkdir ./aimless_$aa

			MTZ_IN="`awk "FNR == $a" ori4.dat`"

			AIM_OUT=./aimless_$aa/aimless_sweep_$aa.mtz
			TRU_OUT=./aimless_$aa/ctruncate_sweep_$aa.mtz
			echo Running AIMLESS sweep $aa

			aimless hklin $MTZ_IN hklout $AIM_OUT <<EOF > ./aimless_$aa/aimless_sweep_$aa.log
RESO HIGH 1.3
HKLREF $REF_MTZ
EXCLUDE $exclude_list
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

		
		cad hklin1 unique_sweep_$aa.mtz hklin2 truncate_sweep_$aa.mtz hklin3 $FREE_MTZ hklout cad_sweep_$aa.mtz <<EOF >> ./FreeR_$aa.log
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
			
	fi

	xclude_no=`wc excludesweep_$aa.dat | awk '{print $1}'`
		if [ $xclude_no -ge 1 ]; then
			echo Sweep_$aa >> excludelist.dat
		fi
	cat excludesweep_$aa.dat >> excludelist.dat
	(( a ++ ))
done


#Clean up 
rm ori3.dat ori2.dat tmp1 excludesweep* tmp2 ori4.dat ori1.dat  
