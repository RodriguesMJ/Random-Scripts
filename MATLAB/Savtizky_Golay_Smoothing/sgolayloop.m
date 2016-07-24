%Script to smooth all absorbance values in the 3D array Glycerol_R2 using
%a Savitzky-Golay Filter

%'a' is a variable that will increase until it is equal to the number of 
%pages in the Glycerol_R2 3D array
a=1;
while a<=size(K98A_2nd_Crystal_R1, 3)
    %Write absorbance values to temporary array 'y' column 1
    y(:,1)=K98A_2nd_Crystal_R1(:,5,a);    
    %Perform smoothing with a window of 20 and a polynomial order of 2
    %write smoothed values to 'y' column 2
    y(:,2)=smooth(y(:,1),40,'sgolay',2);
    %Write smoothed values to 3D array, column 3, page 'a'
    K98A_2nd_Crystal_R1(:,6,a)=y(:,2);
    %Loop
    a=a+1;
    %Clear temporary variable
    clearvars y;
end


