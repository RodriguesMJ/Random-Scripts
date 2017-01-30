#Script to use FFT to produce Fon-Fo1 maps with the mtzs that came out of cad as an input.

find /Volumes/TewsBackupDisk4/Moritz/process_160831/cad/ -name *mtz > ori1.dat

file_no=`wc ori1.dat | awk '{print $1}'`
echo There are $file_no composite datasets to process

a=1
b=2
while [ $a -le $file_no ]
	do
	aa=`printf "%03d" $a`
	CAD_001="`awk "FNR == $a" ori1.dat`"


	bb=`printf "%03d" $b`
	echo n is equal to $b

	fft HKLIN $CAD_001 MAPOUT cad_fon_fo1_$bb.map.ccp4<<EOF >> ./FFT_$bb.log
	xyzlim asu
	scale F1 1.0
	scale F2 1.0
	labin -
   	F1=F_001 SIG1=SIGF_001 F2=F_$bb SIG2=SIGF_$bb PHI=PHIC W=FOM
EOF

	(( b ++ ))
	(( a ++ ))
done
#Clean up
rm ori1.dat
