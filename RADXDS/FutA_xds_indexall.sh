#Script to process FutA data with XDS  


###### MODIFIED TO JUST RUN FOR SWEEP 1 	
mkdir xds
cd xds
#Find all images, cut out duplicates 
find /dls/mx-scratch/matt/FutA/Moritz/ -name "*cbf" | sort | rev | cut -c 9- | rev | uniq > ori1.dat
sed -i.bak '/test/d' ./ori1.dat #remove test images
a=`wc ori1.dat | awk '{print $1}'`
echo There are $a datasets.
mkdir ../XDS_REDO
b=1

while [ $b -le $a ]
        do

	ba=`printf "%03d" $b`
	mkdir ../XDS_REDO/folder_$ba

	c=$(dirname `awk "FNR == $b" ori1.dat`)

	echo Dataset $b is within folder $c

	ls $c/*cbf > ori2.dat

	d=`wc ori2.dat | awk '{print $1}'`
	echo Folder $c has $d images.
	
	ls $c/*cbf | sort | rev | cut -c 9- | rev | uniq > ori3.dat

	e=`wc ori3.dat | awk '{print $1}'`
	echo Folder $c has $e datasets.

	f=1
	#Number of images per sweep
	i=35
	
	
		while [ $f -le $e ]
   		do
			fa=`printf "%03d" $f`
			g=`awk "FNR == $f" ori3.dat`
			echo Dataset $f is $g
			mkdir ../XDS_REDO/folder_$ba/wedge_$fa	
			#Find how many images are in the first dataset
			ls $g* > tmp1
			h=`wc tmp1 | awk '{print $1}'`
		
			j=$(echo "$h/$i" | bc)
			echo There are $h images in this dataset, with $i images per sweep there will be $j sweeps
		
			k=1
				while [ $k -le 1 ]  #MODIFIED $J TO NUMBER 1 SO THAT ONLY SWEEP 1 WILL BE INTEGRATED
        			do
				l=`printf "%03d" $k`
				m=$(( ($i * ( $k - 1 )+1) ))
      				echo Start image is number $m
				n=$(( $i * $k ))
      				echo Final image number is $n
				o=`awk "FNR == $b" ori1.dat`
				mkdir ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l
				
if [ $k -eq 1 ]
then 
					
########################################WRITE XDS INPUT TO INDEX FILE########################################################
echo JOB= XYCORR COLSPOT INIT IDXREF > ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo DATA_RANGE= 1 900 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo SPOT_RANGE= 1 10 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo SPOT_RANGE= 400 410 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo SPOT_RANGE= 810 820 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo BACKGROUND_RANGE= $m $n >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo                         >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo !masking non sensitive area of Pilatus  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP  
echo   UNTRUSTED_RECTANGLE= 487  495    0 1680 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE= 981  989    0 1680 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 1476  195  213 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 1476  407  425 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 1476  619  637 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 1476  831  849 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 1476 1043 1061 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 1476 1255 1273 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   UNTRUSTED_RECTANGLE=   0 1476 1467 1485 >> ../XDS_REDO /folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   TRUSTED_REGION=0.0 1.41 !Relative radii limiting trusted detector region >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   !correction tables to compensate the misorientations of the modules >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   X-GEO_CORR= /dls/mx-scratch/matt/FutA/Moritz/Revolver1/LowDose/2/test/process/x_geo_corr.cbf  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   Y-GEO_CORR= /dls/mx-scratch/matt/FutA/Moritz/Revolver1/LowDose/2/test/process/y_geo_corr.cbf  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   SECONDS=600   >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   MINIMUM_NUMBER_OF_PIXELS_IN_A_SPOT= 3  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   !STRONG_PIXEL= 3.0  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   OSCILLATION_RANGE= 0.2000  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   X-RAY_WAVELENGTH= 0.96770  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   NAME_TEMPLATE_OF_DATA_FRAMES= $o"????.cbf !CBF"  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   DETECTOR_DISTANCE= 124.45  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   DETECTOR= PILATUS MINIMUM_VALID_PIXEL_VALUE= 0.0 OVERLOAD= 1048500  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   SENSOR_THICKNESS=0.45  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   ORGX= 736.30 ORGY= 813.78  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   NX= 1475 NY= 1679  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   QX= 0.1720  QY= 0.1720  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   VALUE_RANGE_FOR_TRUSTED_DETECTOR_PIXELS= 7000 30000  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   DIRECTION_OF_DETECTOR_X-AXIS= 1.0 0.0 0.0  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   DIRECTION_OF_DETECTOR_Y-AXIS= 0.0 1.0 0.0  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   ROTATION_AXIS= 1.0 0.0 0.0 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   INCIDENT_BEAM_DIRECTION= 0.0 0.0 1.0  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   FRACTION_OF_POLARIZATION= 0.99  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   POLARIZATION_PLANE_NORMAL= 0.0 1.0 0.0  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   SPACE_GROUP_NUMBER= 4  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   UNIT_CELL_CONSTANTS= 39.18 77.08 47.49 90 98.14 90  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   INCLUDE_RESOLUTION_RANGE= 50.0 0.0  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   "REFINE(INTEGRATE)= BEAM ORIENTATION CELL"  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   MAXIMUM_NUMBER_OF_PROCESSORS= 16  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 

########################################END XDS INPUT FILE###################################################### 
			cd ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l				
			xds_par
			cd -
fi

if [ $k -gt 1 ]
then 
cp ../XDS_REDO/folder_$ba/wedge_$fa/sweep_001/*cbf ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/
cp ../XDS_REDO/folder_$ba/wedge_$fa/sweep_001/SPOT.XDS ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/
cp ../XDS_REDO/folder_$ba/wedge_$fa/sweep_001/GXPARM.XDS ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/ 
cp ../XDS_REDO/folder_$ba/wedge_$fa/sweep_001/XPARM.XDS ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/ 
fi


########################################WRITE XDS INTEGRATION FILE########################################################
echo JOB= DEFPIX INTEGRATE > ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo DATA_RANGE= $m $n >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo SPOT_RANGE= $m $n >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo BACKGROUND_RANGE= $m $n >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo                         >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo !masking non sensitive area of Pilatus  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP  
echo   UNTRUSTED_RECTANGLE= 487  495    0 1680 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE= 981  989    0 1680 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 1476  195  213 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 1476  407  425 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 1476  619  637 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 1476  831  849 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 1476 1043 1061 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 1476 1255 1273 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   UNTRUSTED_RECTANGLE=   0 1476 1467 1485 >> ../XDS_REDO /folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   TRUSTED_REGION=0.0 1.41 !Relative radii limiting trusted detector region >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   !correction tables to compensate the misorientations of the modules >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   X-GEO_CORR= /dls/mx-scratch/matt/FutA/Moritz/Revolver1/LowDose/2/test/process/x_geo_corr.cbf  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   Y-GEO_CORR= /dls/mx-scratch/matt/FutA/Moritz/Revolver1/LowDose/2/test/process/y_geo_corr.cbf  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   SECONDS=600   >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   MINIMUM_NUMBER_OF_PIXELS_IN_A_SPOT= 3  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   !STRONG_PIXEL= 3.0  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   OSCILLATION_RANGE= 0.2000  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   X-RAY_WAVELENGTH= 0.96770  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   NAME_TEMPLATE_OF_DATA_FRAMES= $o"????.cbf !CBF"  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   DETECTOR_DISTANCE= 124.45  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   DETECTOR= PILATUS MINIMUM_VALID_PIXEL_VALUE= 0.0 OVERLOAD= 1048500  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   SENSOR_THICKNESS=0.45  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   ORGX= 736.30 ORGY= 813.78  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   NX= 1475 NY= 1679  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   QX= 0.1720  QY= 0.1720  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   VALUE_RANGE_FOR_TRUSTED_DETECTOR_PIXELS= 7000 30000  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   DIRECTION_OF_DETECTOR_X-AXIS= 1.0 0.0 0.0  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   DIRECTION_OF_DETECTOR_Y-AXIS= 0.0 1.0 0.0  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   ROTATION_AXIS= 1.0 0.0 0.0 >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   INCIDENT_BEAM_DIRECTION= 0.0 0.0 1.0  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   FRACTION_OF_POLARIZATION= 0.99  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   POLARIZATION_PLANE_NORMAL= 0.0 1.0 0.0  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   SPACE_GROUP_NUMBER= 4  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   UNIT_CELL_CONSTANTS= 39.18 77.08 47.49 90 98.14 90  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   INCLUDE_RESOLUTION_RANGE= 50.0 0.0  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   "REFINE(INTEGRATE)= BEAM ORIENTATION CELL"  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   MAXIMUM_NUMBER_OF_PROCESSORS= 16  >> ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l/XDS.INP 

########################################END XDS INPUT FILE###################################################### 
			cd ../XDS_REDO/folder_$ba/wedge_$fa/sweep_$l				
			xds_par
			cd -

			echo Folder_$ba wedge_$fa contains the integrated files for $o images $m to $n >> ../XDS_REDO/XDS_LOOP.log
			(( k ++ ))
			done



	(( f ++ ))
(( b ++ ))

	done
done
