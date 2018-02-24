#Matt Rodrigues 2018
#Script to run all sweeps through blend in analysis and synthesis mode
# Load modules for blend R and ccp4 before running script

HOME=`pwd`
echo RESO HIGH 2.0 >  "$HOME"/combination_keywords_1.dat
echo RADFRAC 0     >> "$HOME"/combination_keywords_1.dat

cp "$HOME"/combination_keywords_1.dat "$HOME"/analysis_keywords.dat

#echo RESO HIGH 2.35 > /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_2.dat
#echo RADFRAC 0     >> /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_2.dat

#echo RESO HIGH 2.40 > /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_3.dat
#echo RADFRAC 0     >> /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_3.dat


#Sweep number is a
a=1

#Total number of sweeps is b
b=2

while [ $a -le $b ]
do 
	
	echo Working on sweep $a
	aa=`printf "%03d" $a`
	mkdir blendsweep_$aa
	cd blendsweep_$aa
	find /Volumes/SOTONTEWS/processing/I320_BLEND/180218/tailored_xds_180224/two_sweep/xds -name "*sweep_$aa" | sort > ori1.dat

	echo All sweep $a folders found

	sed -i.bak '/blend/d' ./ori1.dat
	sed -e 's/$/\/INTEGRATE.HKL/' -i ori1.dat
	
	FILE_NO=`wc ori1.dat | awk '{print $1}'`
	echo There are $FILE_NO integrated files

	c=1 
	while [ $c -le $FILE_NO ] 
	do
		FOLDER=`awk "FNR == $c" ori1.dat`
		
		if [ $c -eq 1 ]
		then
			find $FOLDER -name "INTEGRATE.HKL" > ori2.dat
		fi

		if [ $c -gt 1 ]
		then
			find $FOLDER -name "INTEGRATE.HKL" >> ori2.dat
                fi
	
	(( c ++ ))
	done



	echo BLEND analysis mode initiated for sweep $a

	blend -a ori2.dat < "$HOME"/analysis_keywords.dat > blend_analysis.log
		
	echo BLEND analysis mode complete for sweep $a

	#echo BLEND synthesis mode initiated for sweep $a

	#blend -s 1000 1.0 < /dls/mx-scratch/matt/Pdx1BLEND/xds_170628/synthesis_keywords.dat > blend_synthesis.log	
	echo BLEND combination mode initiated for sweep $a
	
	blend -c 1 2 3 4 5 6 < "$HOME"/combination_keywords_1.dat 	
        #blend -c 1 2 3 4 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 26 27 < /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_2.dat
	#blend -c 1 2 3 4 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 26 27 < /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_3.dat
	
	#blend -c 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 < /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_1.dat
        #blend -c 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 < /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_2.dat
	#blend -c 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 < /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_3.dat
	
	echo BLEND synthesis mode complete for sweep $a

	cd ../
	(( a ++ ))
	
done
