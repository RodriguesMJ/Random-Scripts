%String together the SGOLAY loop, 900 nm normalisation and diffspec 
%subtraction into a single script

%Script to smooth all absorbance values in the 3D array Glycerol_R2 using
%a Savitzky-Golay Filter

%'a' is a variable that will increase until it is equal to the number of 
%pages in the Glycerol_R2 3D array
a=1;
while a<=size(GOL100_F1, 3)
    %Write absorbance values to temporary array 'y' column 1
    y(:,1)=GOL100_F1(:,2,a);    
    %Perform smoothing with a window of 20 and a polynomial order of 2
    %write smoothed values to 'y' column 2
    y(:,2)=smooth(y(:,1),40,'sgolay',2);
    %Write smoothed values to 3D array, column 3, page 'a'
    GOL100_F1(:,3,a)=y(:,2);
    %Loopend
    
    a=a+1;
    %Clear temporary variable
    clearvars y;
end

%Script to internally normalise the spectra at 900 nm where no signal is
%expected.
%'a' is a variable that will increase until it is equal to the number of 
%pages in the Glycerol_R2 3D array
a=1;
while a<=size(GOL100_F1, 3)
    %Subtract the smoothed absorbance value at 899.53 nm spectrum 'a' from
    %every smoothed absorbance value in spectrum 'a' and write values in to
    %column four of the 3D array.
    GOL100_F1(:,4,a)=(GOL100_F1(:,3,a)-GOL100_F1(912,3,a));    
    a=a+1;
end
%Clear temporary variables
clearvars a

%Script to subtract initial spectrum in a series from every subsequent 
%spectrum
%'a' is a variable that will increase until it is equal to the number of 
%pages in the Glycerol_R2 3D array
a=1;
while a <= size(GOL100_F1, 3)
    %Subtract the first smoothed and normalised spectrum collected 
    %(in column 4) from every other smoothed and normailsed specrum in the
    %array
    GOL100_F1(:,5,a)=GOL100_F1(:,4,a)-GOL100_F1(:,4,1);
    a=a+1;
end
%Clear temporary variables
clearvars a;