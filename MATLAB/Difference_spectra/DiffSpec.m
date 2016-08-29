%Script to subtract initial spectrum in a series from every subsequent 
%spectrum
%'a' is a variable that will increase until it is equal to the number of 
%pages in the Glycerol_R2 3D array
a=1;
while a <= size(K98A_2nd_Crystal_R2, 3)
    %Subtract the first smoothed and normalised spectrum collected 
    %(in column 4) from every other smoothed and normailsed specrum in the
    %array
    K98A_2nd_Crystal_R2(:,5,a)=K98A_2nd_Crystal_R2(:,4,a)-K98A_2nd_Crystal_R2(:,4,1);
    a=a+1;
end
%Clear temporary variables
clearvars a;