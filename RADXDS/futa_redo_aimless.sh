find /Volumes/TewsBackupDisk4/Moritz/process_160831/aimless/ -name "*aimless*log" > ori1.dat

file_no=`wc ori1.dat | awk '{print $1}'`
echo There are $file_no composite datasets to process

a=1
	while [ $a -le $file_no ]
	do

	aa=`printf "%03d" $a`	
	
	#Read in log file for sweep $a aimless 
	AIM_IN="`awk "FNR == $a" ori1.dat`"

	#Cut out scale factor plot and write as ori2.dat
	cat $AIM_IN | awk -v N=3 '{print}/Bdecay/&&--N<=0{exit}' | awk '/Bdecay/{f=1;}f' | sed '1,/Bdecay/d' | sed -n -e :a -e '1,2!{P;N;D;};N;ba' > ori2.dat

	#Cut columns 2 (image number) and 6 (scale factor) from the table and shortern multiple spaces to single space
	cat ori2.dat | tr -s ' ' | cut -d ' ' -f2,6 > ori3.dat
	
	#Calculate the average scale factor for all images in the dataset
	Mn=`awk '{ total += $2 } END { print total/NR }' ori3.dat`

	echo The average scale factor for sweep $aa is  $Mn

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


	(( a ++ ))
done

#Clean up 
rm ori3.dat ori2.dat
