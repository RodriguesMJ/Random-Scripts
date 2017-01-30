#Script to cad together the F, SIGFs and R-free flags from dataset 001 with the phases from the refined dataset
#and the Fs and sig Fs of subsequent wedges. The mtzs output by this script will be read in by FFT to produce
#Fon-Fo1 maps which can be displayed in PyMol or COOT.
 
find /Volumes/TewsBackupDisk4/Moritz/process_160831/aimless -name "*FINISHED*" > ori1.dat

file_no=`wc ori1.dat | awk '{print $1}'`
echo There are $file_no composite datasets to process

REF_MTZ=/Users/matt/Dropbox/FutA_Damage/Matt_FutA_I2/CCP4_PROJECT_FILES/Job3_FutAI2_ref.mtz

a=1


	aa=`printf "%03d" $a`
	AIM_001="`awk "FNR == $a" ori1.dat`"
	echo Dataset $a is $AIM_001

a=2

while [ $a -le $file_no ]
	do
	aa=`printf "%03d" $a`
	AIM_N="`awk "FNR == $a" ori1.dat`"
	CAD_OUT=./cad_fo_$aa_fo001.mtz
	
	cad hklin1 $AIM_001 hklin2 $AIM_N hklin3 $REF_MTZ hklout cad_Fon_Fo1_$aa.mtz<<EOF >> ./CAD_$aa.log
	LABIN FILE 1 ALLIN
	LABIN FILE 2 E1 = F_$aa E2 = SIGF_$aa
	LABIN FILE 3 E1 = PHIC E2 = FOM
EOF

	(( a ++ ))
	done
#Clean up
rm ori1.dat
