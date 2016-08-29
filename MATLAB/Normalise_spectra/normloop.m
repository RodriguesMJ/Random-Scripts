%Script to internally normalise the spectra at 900 nm where no signal is
%expected.
%'a' is a variable that will increase until it is equal to the number of 
%pages in the Glycerol_R2 3D array
a=1;
while a<=size(K98A_2nd_Crystal_R2, 3)
    %Subtract the smoothed absorbance value at 899.53 nm spectrum 'a' from
    %every smoothed absorbance value in spectrum 'a' and write values in to
    %column four of the 3D array.
    K98A_2nd_Crystal_R2(:,4,a)=(K98A_2nd_Crystal_R2(:,3,a)-K98A_2nd_Crystal_R2(912,3,a));    
    a=a+1;
end
%Clear temporary variables
clearvars a