#Script to process Moritz' FutA data

mkdir xds

cd xds

#Find all images, cut out duplicates
find /dls/mx-scratch/matt/FutA/ESRF_2016/FutAPm/ -name "*cbf" > ori1.dat
sed -i.bak '/._F/d' ./ori1.dat
IMG_NO=`wc ori1.dat | awk '{print $1}'`
echo There are $IMG_NO images.

cat ori1.dat | sort | rev | cut -c 9- | rev | uniq > ori2.dat
sed -i.bak '/test/d' ./ori2.dat #remove test images
sed -i.bak '/Test/d' ./ori2.dat #remove test images
sed -i.bak '/ref/d' ./ori2.dat #remove test images
sed -i.bak '/MM98/d' ./ori2.dat #remove bad datasets
sed -i.bak '/MM99/d' ./ori2.dat
sed -i.bak '/H1/d' ./ori2.dat

find /dls/mx-scratch/matt/FutA/Moritz/ -name "*cbf" | sort | rev | cut -c 9- | rev | uniq  > ori1.dat

sed -i.bak '/test/d' ./ori1.dat #remove test images

cat ori1.dat >> ori2.dat

a=`wc ori2.dat | awk '{print $1}'`
echo There are $a datasets.
mv ori2.dat ori1.dat

b=1

while [ $b -le $a ]
        do
	cd /dls/mx-scratch/matt/FutA/process_160914/xds
        ba=`printf "%03d" $b`
        mkdir ./folder_$ba

	c=$(dirname `awk "FNR == $b" ori1.dat`)

        echo Dataset $b is within folder $c
        ls $c/*cbf > ori2.dat

	d=`wc ori2.dat | awk '{print $1}'`
        echo Folder $c has $d images.

        ls $c/*cbf | sort | rev | cut -c 9- | rev | uniq > ori3.dat

        e=`wc ori3.dat | awk '{print $1}'`

	f=1
	#Number of images per sweep
        i=10

	while [ $f -le $e ]
                do
                  	fa=`printf "%03d" $f`
                        g=`awk "FNR == $f" ori3.dat`
                        mkdir ./folder_$ba/wedge_$fa
			 #Find how many images are in the first dataset
                        ls $g* > tmp1
                        h=`wc tmp1 | awk '{print $1}'`
                        j=$(echo "$h/$i" | bc)
                        j=$(( $j - 1 ))
                        echo There are $h images in this dataset, with $i images per sweep there will be $j sweeps
			#Modified to only run for first two sweeps
			k=1
			while [ $k -le 2 ]  
        			do
				l=`printf "%03d" $k`
				#cd /dls/mx-scratch/matt/FutA/process_160831/xds
				mkdir ./folder_$ba/wedge_$fa/sweep_$l
				m=$(( ($i * ( $k - 1 )+1) ))
      				echo Start image is number $m
				n=$(( $i * $k ))
      				echo Final image number is $n
				o=`awk "FNR == $b" ori1.dat`
				
				if [ $k -eq 1 ]
then 
OSCI=`head -35 $o"0001.cbf" | grep "Angle_increment" | cut -c 19- | rev | cut -c 7- | rev`
WAVELENGTH=`head -45 $o"0001.cbf" | grep "Wavelength" | cut -c 14- | rev | cut -c 4- | rev`
DISTANCE=`head -45 $o"0001.cbf" | grep "Detector_distance" | cut -c 21- | rev | cut -c 4- | rev`
#SENSOR_THICKNESS=`head -45 $o"0001.cbf" | grep "thickness" | cut -c 29- | rev | cut -c 4- | rev`
DETECTOR=`head -45 $o"0001.cbf" | grep "Detector:" | cut -c 13- | rev | cut -c 26- | rev`
DA=$(echo "$DISTANCE * 1000" | bc -l)
echo The detector is $DETECTOR

if [[ $DETECTOR == *"2M"* ]]
then
  echo "It's a 2M!";
  SENSOR_THICKNESS=0.32
  #sleep 5
fi
if [[ $DETECTOR == *"6M"* ]]
then
  echo "It's a 6M!";
  SENSOR_THICKNESS=0.45
  #sleep 5 
fi


			
########################################WRITE XDS INPUT TO INDEX FILE########################################################
echo JOB= XYCORR COLSPOT INIT IDXREF> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo DATA_RANGE= $m $n >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo SPOT_RANGE= 1 16 >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo SPOT_RANGE= 435 450 >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo BACKGROUND_RANGE= $m $n >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo                         >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP

if [[ $DETECTOR == *"2M"* ]]
then
cat /dls/mx-scratch/matt/FutA/process_160914/2M_detector.dat >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP
fi
if [[ $DETECTOR == *"6M"* ]]
then 
cat /dls/mx-scratch/matt/FutA/process_160914/6M_detector.dat >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP  
fi

echo   SECONDS=600   >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   MINIMUM_NUMBER_OF_PIXELS_IN_A_SPOT= 3  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   !STRONG_PIXEL= 3.0  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   OSCILLATION_RANGE= $OSCI  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   X-RAY_WAVELENGTH= $WAVELENGTH  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   NAME_TEMPLATE_OF_DATA_FRAMES= $o"????.cbf !CBF"  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   DETECTOR_DISTANCE= $DA  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   DETECTOR= PILATUS MINIMUM_VALID_PIXEL_VALUE= 0.0 OVERLOAD= 1048500  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   SENSOR_THICKNESS= $SENSOR_THICKNESS  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   ORGX= 1219.05 ORGY= 1263.22  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   NX= 2463 NY= 2527  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   QX= 0.1720  QY= 0.1720  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   VALUE_RANGE_FOR_TRUSTED_DETECTOR_PIXELS= 7000 30000  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   DIRECTION_OF_DETECTOR_X-AXIS= 1.0 0.0 0.0  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   DIRECTION_OF_DETECTOR_Y-AXIS= 0.0 1.0 0.0  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   ROTATION_AXIS= 1.0 0.0 0.0 >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   INCIDENT_BEAM_DIRECTION= 0.0 0.0 1.0  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   FRACTION_OF_POLARIZATION= 0.99  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   POLARIZATION_PLANE_NORMAL= 0.0 1.0 0.0  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   SPACE_GROUP_NUMBER= 4  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   UNIT_CELL_CONSTANTS= 39.18 77.08 47.49 90 98.14 90  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   INCLUDE_RESOLUTION_RANGE= 50.0 0.0  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   "REFINE(INTEGRATE)= BEAM ORIENTATION CELL"  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   MAXIMUM_NUMBER_OF_PROCESSORS= 16  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 

########################################END XDS INPUT FILE###################################################### 
				cd ./folder_$ba/wedge_$fa/sweep_$l				
				xds_par				
				
				COLSP=`grep -A 3 NSTRONG COLSPOT.LP | head -7 | tail -1 | cut -c 27- | rev | cut -c 9- | rev`
			        echo There are $COLSP strong spots on image 1 of this dataset.
				#sleep 5
					if [ $COLSP -le 50 ]
			    			then
			    			mv XDS.INP COLSPOT.INP
						cp COLSPOT.LP COLSP.LP 
			   	                 m=$(( ($i * ( $k - 1 )+7) ))
	               			    echo Start image is number $m
		                	    n=$((( $i * $k )+6))
      			                	echo Final image number is $n 
                           ########################################RE-WRITE XDS INPUT TO INDEX FILE##############
                           echo JOB= XYCORR COLSPOT INIT IDXREF > XDS.INP
                           echo DATA_RANGE= 10 900 >> XDS.INP 
                           echo SPOT_RANGE= 10 26 >> XDS.INP
                           echo SPOT_RANGE= 435 450 >> XDS.INP 
                           echo BACKGROUND_RANGE= 7 16 >> XDS.INP 
                           echo                         >> XDS.INP
			   tail -45 COLSPOT.INP >> XDS.INP 
			   #######################################################################################
			   xds_par
			   mv XDS.INP INDEX.INP
			   ########################################WRITE XDS INPUT TO INTEGRATE FILE##############
                           echo JOB= DEFPIX INTEGRATE CORRECT > XDS.INP
                           echo DATA_RANGE= $m $n >> XDS.INP 
                           echo SPOT_RANGE= $m $n >> XDS.INP
                           echo SPOT_RANGE= $m $n >> XDS.INP 
                           echo BACKGROUND_RANGE= $m $n >> XDS.INP 
                           echo                         >> XDS.INP
			   tail -45 COLSPOT.INP >> XDS.INP 
			   #######################################################################################
			   xds_par

						fi
						if [ $COLSP -gt 50 ]
			    then
			    echo $COLSP is greater than 50!
			    mv XDS.INP COLSPOT.INP 
			    cp COLSPOT.LP COLSP.LP
                            ####################################WRITE XDS INPUT TO INTEGRATE FILE##############
                           echo JOB= DEFPIX INTEGRATE CORRECT > XDS.INP
                           echo DATA_RANGE= $m $n >> XDS.INP 
                           echo SPOT_RANGE= $m $n >> XDS.INP
                           echo SPOT_RANGE= $m $n >> XDS.INP 
                           echo BACKGROUND_RANGE= $m $n >> XDS.INP 
                           echo                         >> XDS.INP
			   tail -45 COLSPOT.INP >> XDS.INP 
			   #######################################################################################
			   xds_par
				fi

				cd /dls/mx-scratch/matt/FutA/process_160914/xds

				fi
				cd /dls/mx-scratch/matt/FutA/process_160914/xds

				if [ $k -gt 1 ]
				then
				    
                                    cd /dls/mx-scratch/matt/FutA/process_160914/xds
				    pwd
				    	mkdir ./folder_$ba/wedge_$fa/sweep_$l
					cp ./folder_$ba/wedge_$fa/sweep_001/*cbf ./folder_$ba/wedge_$fa/sweep_$l/
					cp ./folder_$ba/wedge_$fa/sweep_001/SPOT.XDS ./folder_$ba/wedge_$fa/sweep_$l/
					cp ./folder_$ba/wedge_$fa/sweep_001/XPARM.XDS ./folder_$ba/wedge_$fa/sweep_$l/
					cp ./folder_$ba/wedge_$fa/sweep_001/COLSPOT.LP ./folder_$ba/wedge_$fa/sweep_$l/
					cp ./folder_$ba/wedge_$fa/sweep_001/XDS.INP ./folder_$ba/wedge_$fa/sweep_$l/
					cp ./folder_$ba/wedge_$fa/sweep_001/COLSP.LP ./folder_$ba/wedge_$fa/sweep_$l/

                                   cd ./folder_$ba/wedge_$fa/sweep_$l/
					mv XDS.INP SWEEP001.INP
					COLSP=`grep -A 3 NSTRONG COLSP.LP | head -7 | tail -1 | cut -c 27- | rev | cut -c 9- | rev`

					if [ $COLSP -le 50 ]
				    		then
					m=$(( ($i * ( $k - 1 )+7) ))
      					echo Start image is number $m
					n=$((( $i * $k )+6))
      					echo Final image number is $n 
			   ########################################WRITE XDS INPUT TO INTEGRATE FILE##############
                           echo JOB= DEFPIX INTEGRATE CORRECT > XDS.INP
                           echo DATA_RANGE= $m $n >> XDS.INP 
                           echo SPOT_RANGE= $m $n >> XDS.INP
                           echo SPOT_RANGE= $m $n >> XDS.INP 
                           echo BACKGROUND_RANGE= $m $n >> XDS.INP 
                           echo                         >> XDS.INP
			   tail -45 SWEEP001.INP >> XDS.INP 
			   #######################################################################################
			   xds_par
				    fi  
					

				     if [ $COLSP -gt 50 ]
				       then
				
					m=$(( ($i * ( $k - 1 )+1) ))
      					echo Start image is number $m
					n=$((( $i * $k )))
      					echo Final image number is $n 
			   ########################################WRITE XDS INPUT TO INTEGRATE FILE##############
                           echo JOB= DEFPIX INTEGRATE CORRECT > XDS.INP
                           echo DATA_RANGE= $m $n >> XDS.INP 
                           echo SPOT_RANGE= $m $n >> XDS.INP
                           echo SPOT_RANGE= $m $n >> XDS.INP 
                           echo BACKGROUND_RANGE= $m $n >> XDS.INP 
                           echo                         >> XDS.INP
			   tail -45 SWEEP001.INP >> XDS.INP 
			   #######################################################################################
			   xds_par
				fi
				   cd /dls/mx-scratch/matt/FutA/process_160914/xds
				fi
				cd /dls/mx-scratch/matt/FutA/process_160914/xds				
				(( k ++ ))
				done
	(( f ++ ))
	done
(( b ++ ))

	done

