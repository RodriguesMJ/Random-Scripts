#Script to run XDS on all of the Pdx1 I320 datasets

#Make executable with the command: chmod 755 xds_I320.sh

#Search for all files ending with 0001.cbf in the 151213 folder and the paths
#to the ori1.dat text file. Search through ori1 for test images and remove them
#from the list of files

find /Volumes/SOTONTEWS/ESRF/151213/ -name "*0001.cbf" > ori1.dat
sed -i.bak '/test/d' ./ori1.dat #remove test images

#Make xds directory
mkdir xds

a=1

#Count the number of different datasets that are listed in ori1 and save as 
#variable b

b=`wc ori1.dat | awk '{print $1}'`

#k is the number of images per sweep, can be changed depending on acceptable 
#dose
k=30

echo There are $b datasets

#c will be the variable used as a counter that increases with each loop iteration
c=1

while [ $c -le $b ]
	do
   	#d is the directory that each dataset is in
        d=$(dirname `awk "FNR == $c" ori1.dat`)
   	
	#ca is c written as a three digit number, if c is 12, ca is 012.
	ca=`printf "%03d" $c`
	
	#e is the file pattern for the dataset with the image number cut off 
	e=`awk "FNR == $c" ori1.dat | rev | cut -c 9- | rev`
	
	#Keep track of which dataset becomes which wedge in xds_I320 log file 
	echo Wedge_$ca is $d >> xds_I320.log 

	####### GREP Data Collection Parameters form Image Header#######	
	head -40 $e"0001.cbf" > header.txt
	###$WL is wavelength variable
	WL=$(head -40 header.txt | grep "Wavelength" | awk -F" " '{print $3}')
	
	###$DIS is detector distance variable
	DIS=`grep -e 'Detector_distance' header.txt | cut -c 21- | rev | cut -c 4- |rev`
	DISa=$(echo "scale=5; $DIS*1000" | bc -l)
	mkdir xds/wedge_$ca
	###$BMX and $BMY define the beam origin for the detector
	BMX=`grep -e 'Beam_xy' header.txt | cut -c 12- | rev | cut -c 19-| rev` 
	BMY=`grep -e 'Beam_xy' header.txt  | cut -c 21- | rev | cut -c 10- |rev`
	
	###List the file names of all images in dataset in ori2.dat text file
	ls $e*cbf > ori2.dat
	
	#Count how many lines are in ori2.dat and therfore how many images there are
	
	f=`wc ori2.dat | awk '{print $1}'`
	echo There are $f images in dataset $c >> xds_I320.log	
	echo There are $f images in dataset $c 

	#Divide the number of images in the dataset by the number of images per sweep
	#to calculate the number of sweeps that can be obtained from the dataset, save
	#as variable g

	g=$(echo "$f/$k" | bc) 
	echo Wedge_$ca will have $g sweeps	

	#Sweep number counter will be $h
	
	h=1
	while [ $h -le $g ]
   	do

		ha=`printf "%03d" $h`
		mkdir xds/wedge_$ca/sweep_$ha
		touch xds/wedge_$ca/sweep_$ha/XDS.INP
		
		i=$(( ($k * ( $h - 1 )+1) ))
		echo Start image is number $i

      		j=$(( $k * $h ))
      		echo Final image number is $j

#If this is the first sweep of the dataset first run XDS indexing using multiple spot ranges.
#Make sure the x_geo_corr.cbf and y_geo_corr.cbf are in the correct directory.
#If a data collected from a detector that is not a PILATUS 6M-F the trusted regions, and other detector parameters will need 
#to be changed.   
#Change unit cell parameters and resolution shell depending on protein / estimated quality of data.    
if [ $h -eq 1 ]
then
############################################ START WRITING XDS.INP INDEXING #################################################
echo   JOB= XYCORR COLSPOT INIT IDXREF >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !JOB= DEFPIX XPLAN INTEGRATE CORRECT  				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   DATA_RANGE= 1 300					           >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   								           >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   SPOT_RANGE= 1 20 						   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   SPOT_RANGE= 100 120 						   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   SPOT_RANGE= 200 220 						   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   BACKGROUND_RANGE= 1 20						   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !masking non sensitive area of Pilatus				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE= 487  495     0 2528				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE= 981  989     0 2528			           >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=1475 1483     0 2528			           >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=1969 1977     0 2528				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464   195  213				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464   407  425			           >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464   619  637				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464   831  849				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464  1043 1061				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464  1255 1273				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464  1467 1485				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464  1679 1697				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464  1891 1909				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464  2103 2121				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464  2315 2333				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   TRUSTED_REGION=0.0 1.41 !Relative radii limiting trusted		   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !correction tables to compensate the misorientations of the modules >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   X-GEO_CORR= /Volumes/SOTONTEWS/ESRF/151213/RAW_DATA/ma94-5/w2/process//x_geo_corr.cbf >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   Y-GEO_CORR= /Volumes/SOTONTEWS/ESRF/151213/RAW_DATA/ma94-5/w2/process//y_geo_corr.cbf >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   SECONDS=600							   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   MINIMUM_NUMBER_OF_PIXELS_IN_A_SPOT= 3				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !STRONG_PIXEL= 3.0						   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   OSCILLATION_RANGE= 0.2000					   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   X-RAY_WAVELENGTH=  $WL						   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   NAME_TEMPLATE_OF_DATA_FRAMES= $e"????.cbf !CBF"			   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !STARTING_ANGLES_OF_SPINDLE_ROTATION= 0 180 10			   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !TOTAL_SPINDLE_ROTATION_RANGES= 60 180 10			   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   DETECTOR_DISTANCE= $DISa					           >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   DETECTOR= PILATUS MINIMUM_VALID_PIXEL_VALUE= 0.0 OVERLOAD= 1048500  >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   SENSOR_THICKNESS=0.32						   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   ORGX= $BMX ORGY= $BMY						   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   NX= 2463 NY= 2527						   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   QX= 0.1720  QY= 0.1720						   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   VALUE_RANGE_FOR_TRUSTED_DETECTOR_PIXELS= 7000 30000		   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   DIRECTION_OF_DETECTOR_X-AXIS= 1.0 0.0 0.0			   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   DIRECTION_OF_DETECTOR_Y-AXIS= 0.0 1.0 0.0                           >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   ROTATION_AXIS= 1.0 0.0 0.0					   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   INCIDENT_BEAM_DIRECTION= 0.0 0.0 1.0				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   FRACTION_OF_POLARIZATION= 0.99					   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   POLARIZATION_PLANE_NORMAL= 0.0 1.0 0.0				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !AIR= %.8f							   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   SPACE_GROUP_NUMBER= 146						   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNIT_CELL_CONSTANTS= 178.64 178.64 116.63 90 90 120		   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   INCLUDE_RESOLUTION_RANGE= 50.0 2					   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !RESOLUTION_SHELLS= 15.0 8.0 4.0 2.8 2.4				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !STRICT_ABSORPTION_CORRECTION=TRUE                                  >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   "REFINE(INTEGRATE)= BEAM ORIENTATION CELL"			   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !== Default value recommended					   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !DELPHI= %.3f							   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   MAXIMUM_NUMBER_OF_PROCESSORS= 8					   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !MAXIMUM_NUMBER_OF_JOBS= 16					   >> xds/wedge_$ca/sweep_$ha/XDS.INP
########################################END XDS INDEXING FILE######################################################

                #Change directory to same directory as XDS input file
		cd xds/wedge_$ca/sweep_$ha/
		
		#Run XDS indexing procedures. 
		xds_par
		
		#Return to starting directory
		cd -
fi

if [ $h -gt 1 ]
then 
#If this is not the first sweep in the dataset then copy the output files from the indexing run to the folder for the new sweep
#rather than re-running the indexing for each sweep.
cp xds/wedge_$ca/sweep_001/*cbf            xds/wedge_$ca/sweep_$ha/
cp xds/wedge_$ca/sweep_001/SPOT.XDS        xds/wedge_$ca/sweep_$ha/
cp xds/wedge_$ca/sweep_001/GXPARM.XDS      xds/wedge_$ca/sweep_$ha/ 
cp xds/wedge_$ca/sweep_001/XPARM.XDS       xds/wedge_$ca/sweep_$ha/ 
fi

#See above indexing procedure, run the integration procedure in XDS 
############################################ START WRITING XDS.INP INTEGRATION #################################################
echo   JOB= DEFPIX INTEGRATE > xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !JOB= DEFPIX XPLAN INTEGRATE CORRECT  				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   DATA_RANGE= $i $j					           >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   								           >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   SPOT_RANGE= $i $j 						   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   BACKGROUND_RANGE= $i $j						   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !masking non sensitive area of Pilatus				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE= 487  495     0 2528				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE= 981  989     0 2528			           >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=1475 1483     0 2528			           >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=1969 1977     0 2528				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464   195  213				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464   407  425			           >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464   619  637				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464   831  849				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464  1043 1061				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464  1255 1273				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464  1467 1485				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464  1679 1697				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464  1891 1909				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464  2103 2121				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNTRUSTED_RECTANGLE=   0 2464  2315 2333				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   TRUSTED_REGION=0.0 1.41 !Relative radii limiting trusted		   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !correction tables to compensate the misorientations of the modules >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   X-GEO_CORR= /Volumes/SOTONTEWS/ESRF/151213/RAW_DATA/ma94-5/w2/process//x_geo_corr.cbf >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   Y-GEO_CORR= /Volumes/SOTONTEWS/ESRF/151213/RAW_DATA/ma94-5/w2/process//y_geo_corr.cbf >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   SECONDS=600							   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   MINIMUM_NUMBER_OF_PIXELS_IN_A_SPOT= 3				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !STRONG_PIXEL= 3.0						   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   OSCILLATION_RANGE= 0.2000					   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   X-RAY_WAVELENGTH=  $WL						   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   NAME_TEMPLATE_OF_DATA_FRAMES= $e"????.cbf !CBF"			   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !STARTING_ANGLES_OF_SPINDLE_ROTATION= 0 180 10			   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !TOTAL_SPINDLE_ROTATION_RANGES= 60 180 10			   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   DETECTOR_DISTANCE= $DISa					           >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   DETECTOR= PILATUS MINIMUM_VALID_PIXEL_VALUE= 0.0 OVERLOAD= 1048500  >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   SENSOR_THICKNESS=0.32						   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   ORGX= $BMX ORGY= $BMY						   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   NX= 2463 NY= 2527						   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   QX= 0.1720  QY= 0.1720						   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   VALUE_RANGE_FOR_TRUSTED_DETECTOR_PIXELS= 7000 30000		   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   DIRECTION_OF_DETECTOR_X-AXIS= 1.0 0.0 0.0			   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   DIRECTION_OF_DETECTOR_Y-AXIS= 0.0 1.0 0.0                           >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   ROTATION_AXIS= 1.0 0.0 0.0					   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   INCIDENT_BEAM_DIRECTION= 0.0 0.0 1.0				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   FRACTION_OF_POLARIZATION= 0.99					   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   POLARIZATION_PLANE_NORMAL= 0.0 1.0 0.0				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !AIR= %.8f							   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   SPACE_GROUP_NUMBER= 146						   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   UNIT_CELL_CONSTANTS= 178.64 178.64 116.63 90 90 120		   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   INCLUDE_RESOLUTION_RANGE= 50.0 2					   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !RESOLUTION_SHELLS= 15.0 8.0 4.0 2.8 2.4				   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !STRICT_ABSORPTION_CORRECTION=TRUE                                  >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo									   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   "REFINE(INTEGRATE)= BEAM ORIENTATION CELL"			   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !== Default value recommended					   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !DELPHI= %.3f							   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   MAXIMUM_NUMBER_OF_PROCESSORS= 8					   >> xds/wedge_$ca/sweep_$ha/XDS.INP
echo   !MAXIMUM_NUMBER_OF_JOBS= 16					   >> xds/wedge_$ca/sweep_$ha/XDS.INP
########################################END XDS INTEGRATION FILE######################################################
                #Change directory to location of XDS input file
                cd xds/wedge_$ca/sweep_$ha/
		
		#Run XDS
		xds_par
		
		#Return to original directory 
		cd -
		
		#Increment sweep counter 
		(( h ++ ))
		done
	#Increment wedge / dataset number
	(( c ++ ))
  	done  
