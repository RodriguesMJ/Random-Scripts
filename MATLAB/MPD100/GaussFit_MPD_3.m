a=1;
GaussCoeff_MPD_R3(1:6,1:4,1:size(MPD100_3, 3))=zeros;
while a<=size(MPD100_3, 3);
    %while a<=100;    
    testx=MPD100_3(1:982,1,a);
    testy=MPD100_3(1:982,5,a);

    Fit1gaussianMPD(testx, testy);
    %Writes coefficient parameters to Coeff 3d matrix line 1
    
    GaussCoeff_MPD_R3(1,:,a)=coeffvalues(ans);
    
    %Writes 95% confidence lower and upper bounds to lines 2 and 3 of Coeff
    GaussCoeff_MPD_R3(2:3,:,a)=confint(ans);
    
    %Converts confidence bounds to standard error and writes to row Coeff 4
    GaussCoeff_MPD_R3(4,:,a)=(((GaussCoeff_MPD_R3(3,:,a))-(GaussCoeff_MPD_R3(2,:,a)))/3.92);
    
    %Makes row 5 the co-efficient minus the Standard Error and row 6 the 
    %coefficient plus the Standard Error
    GaussCoeff_MPD_R3(5,:,a)=(GaussCoeff_MPD_R3(1,:,a))-((GaussCoeff_MPD_R3(4,:,a)));
    GaussCoeff_MPD_R3(6,:,a)=(GaussCoeff_MPD_R3(1,:,a))+((GaussCoeff_MPD_R3(4,:,a)));
    %FitOutPut(a,:)=coeffvalues(ans);
a=a+1;
end;
clearvars r
r(:,1)=GaussCoeff_MPD_R3(1,1,:);
figure
plot((1:size(GaussCoeff_MPD_R3, 3))/2,r(:,1))
