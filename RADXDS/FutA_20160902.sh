#Script to process Moritz' FutA data, used on Diamond system, (process_20160831)
#Module load XDS before running 

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
a=`wc ori2.dat | awk '{print $1}'`
echo There are $a datasets.
mv ori2.dat ori1.dat

b=1

while [ $b -le $a ]
        do
	cd /dls/mx-scratch/matt/FutA/process_160831/xds
	ba=`printf "%03d" $b`
	mkdir ./folder_$ba

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
	i=20


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
		
			k=1
			while [ $k -le $j ]  
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
					
########################################WRITE XDS INPUT TO INDEX FILE########################################################
echo JOB= XYCORR COLSPOT INIT IDXREF> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo DATA_RANGE= $m $n >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo SPOT_RANGE= 1 16 >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo SPOT_RANGE= 435 450 >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo BACKGROUND_RANGE= $m $n >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo                         >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo !masking non sensitive area of Pilatus  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP  
echo   UNTRUSTED_RECTANGLE= 487  495    0 2528 >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE= 981  989    0 2528 >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=1475 1483    0 2528 >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=1969 1977    0 2528 >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464  195  213 >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464  407  425 >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464  619  637 >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464  831  849 >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   UNTRUSTED_RECTANGLE=   0 2464 1043 1061 >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464 1255 1273 >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464 1467 1485 >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464 1679 1697 >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464 1891 1909 >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   UNTRUSTED_RECTANGLE=   0 2464 2103 2121 >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464 2315 2333 >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP

echo   TRUSTED_REGION=0.0 1.41 !Relative radii limiting trusted detector region >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   !correction tables to compensate the misorientations of the modules >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   X-GEO_CORR= /dls/mx-scratch/matt/FutA/ESRF_2016/FutAPm/FutAPm-MM1/1/process/x_geo_corr.cbf.bz2  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   Y-GEO_CORR= /dls/mx-scratch/matt/FutA/ESRF_2016/FutAPm/FutAPm-MM1/1/process/y_geo_corr.cbf.bz2  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP
echo   SECONDS=600   >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   MINIMUM_NUMBER_OF_PIXELS_IN_A_SPOT= 3  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   !STRONG_PIXEL= 3.0  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   OSCILLATION_RANGE= 0.2000  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   X-RAY_WAVELENGTH= 0.97625  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   NAME_TEMPLATE_OF_DATA_FRAMES= $o"????.cbf !CBF"  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   DETECTOR_DISTANCE= 159.8  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   DETECTOR= PILATUS MINIMUM_VALID_PIXEL_VALUE= 0.0 OVERLOAD= 1048500  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
echo   SENSOR_THICKNESS=0.45  >> ./folder_$ba/wedge_$fa/sweep_$l/XDS.INP 
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
                           echo DATA_RANGE= 1 900 >> XDS.INP 
                           echo SPOT_RANGE= 10 26 >> XDS.INP
                           echo SPOT_RANGE= 435 450 >> XDS.INP 
                           echo BACKGROUND_RANGE= 7 26 >> XDS.INP 
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

				cd /dls/mx-scratch/matt/FutA/process_160831/xds

				fi
				cd /dls/mx-scratch/matt/FutA/process_160831/xds

				if [ $k -gt 1 ]
				then
				    
                                    cd /dls/mx-scratch/matt/FutA/process_160831/xds
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
				   cd /dls/mx-scratch/matt/FutA/process_160827/xds
				fi
				cd /dls/mx-scratch/matt/FutA/process_160827/xds				
				(( k ++ ))
				done
	(( f ++ ))
	done
(( b ++ ))
done

