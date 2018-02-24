#Matt Rodrigues 2018
#Script to run all sweeps through blend in analysis and synthesis mode
# Load modules for blend R and ccp4 before running script

echo RESO HIGH 2.30 > /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_1.dat
echo RADFRAC 0     >> /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_1.dat

echo RESO HIGH 2.35 > /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_2.dat
echo RADFRAC 0     >> /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_2.dat

echo RESO HIGH 2.40 > /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_3.dat
echo RADFRAC 0     >> /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_3.dat


#Sweep number is a
a=1

#Total number of sweeps is b
b=4

while [ $a -le $b ]
do 
	
	echo Working on sweep $a
	aa=`printf "%03d" $a`
	mkdir blendsweep_$aa
	cd blendsweep_$aa
	find /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/xds -name "*sweep_$aa" | sort > ori1.dat

	echo All sweep $a folders found

	sed -i.bak '/blend/d' ./ori1.dat
	sed -e 's/$/\/INTEGRATE.HKL/' -i ori1.dat
	
	echo BLEND analysis mode initiated for sweep $a

	blend -a ori1.dat < /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/analysis_keywords.dat > blend_analysis.log
		
	echo BLEND analysis mode complete for sweep $a

	#echo BLEND synthesis mode initiated for sweep $a

	#blend -s 1000 1.0 < /dls/mx-scratch/matt/Pdx1BLEND/xds_170628/synthesis_keywords.dat > blend_synthesis.log	
	echo BLEND combination mode initiated for sweep $a
	
	blend -c 1 2 3 4 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 26 27 < /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_1.dat 	
        blend -c 1 2 3 4 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 26 27 < /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_2.dat
	blend -c 1 2 3 4 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 26 27 < /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_3.dat
	
	blend -c 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 < /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_1.dat
        blend -c 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 < /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_2.dat
	blend -c 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 < /dls/mx-scratch/matt/Pdx1BLEND/xds_171209/blend/combination_keywords_3.dat
	
	echo BLEND synthesis mode complete for sweep $a

	cd ../
	(( a ++ ))
	
done





