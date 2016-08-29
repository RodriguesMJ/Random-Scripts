#Matt Rodrigues 2016

#Make executable with command: chmod 755 blend_script.sh 

#Script to run all sweeps through blend in analysis and synthesis mode
# Load modules for blend R and ccp4 before running script
#Sweep number is a
a=1

#Total number of sweeps is b
b=15

while [ $a -le $b ]
do 
	
	echo Working on sweep $a
	aa=`printf "%03d" $a`
	mkdir blendsweep_$aa
	cd blendsweep_$aa
	find /dls/mx-scratch/matt/Pdx1BLEND/xds_160718/integratedfiles -name "*sweep_$aa" | sort > ori1.dat

	echo All sweep $a folders found

	sed -i.bak '/blend/d' ./ori1.dat
	sed -e 's/$/\/INTEGRATE.HKL/' -i ori1.dat
	
	echo BLEND analysis mode initiated for sweep $a

	blend -a ori1.dat < /dls/mx-scratch/matt/Pdx1BLEND/xds_160718/blend/analysis_keywords.dat > blend_analysis.log
		
	echo BLEND analysis mode complete for sweep $a

	echo BLEND synthesis mode initiated for sweep $a

	blend -s 1000 1.0 < /dls/mx-scratch/matt/Pdx1BLEND/xds_160718/blend/synthesis_keywords.dat > blend_synthesis.log	
		

	echo BLEND synthesis mode complete for sweep $a

	cd ../
	(( a ++ ))
	
done





