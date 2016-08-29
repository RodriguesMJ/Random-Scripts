a=1;

dlow=0;
GaussCoeff_MPD_R1(1:6,1:7,1:size(MPD_40_R1, 3))=zeros;
while a<=size(MPD_40_R1, 3);
    %while a<=100;    
    testx=MPD_40_R1(1:982,1,a);
    testy=MPD_40_R1(1:982,5,a);

    Fit2gaussiansMPD40(testx, testy);
    %Writes coefficient parameters to Coeff 3d matrix line 1
    
    GaussCoeff_MPD_R1(1,:,a)=coeffvalues(ans);
    
    %Writes 95% confidence lower and upper bounds to lines 2 and 3 of Coeff
    GaussCoeff_MPD_R1(2:3,:,a)=confint(ans);
    
    %Converts confidence bounds to standard error and writes to row Coeff 4
    GaussCoeff_MPD_R1(4,:,a)=(((GaussCoeff_MPD_R1(3,:,a))-(GaussCoeff_MPD_R1(2,:,a)))/3.92);
    
    %Makes row 5 the co-efficient minus the Standard Error and row 6 the 
    %coefficient plus the Standard Error
    GaussCoeff_MPD_R1(5,:,a)=(GaussCoeff_MPD_R1(1,:,a))-((GaussCoeff_MPD_R1(4,:,a)));
    GaussCoeff_MPD_R1(6,:,a)=(GaussCoeff_MPD_R1(1,:,a))+((GaussCoeff_MPD_R1(4,:,a)));
    %FitOutPut(a,:)=coeffvalues(ans);
a=a+1;
end;


% opts.Lower = [0 70 218 0 225 508 0];
% opts.StartPoint = [2 23.4 220 1 233 510 0];
% opts.Upper = [Inf 80 222 100 235 512 0];