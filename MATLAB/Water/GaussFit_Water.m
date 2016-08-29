a=1;
GaussCoeff_Water_R3(1:6,1:4,1:size(Water_R3, 3))=zeros;
while a<=size(Water_R3, 3);
    %while a<=100;    
    testx=Water_R3(1:982,1,a);
    testy=Water_R3(1:982,5,a);

    Fit1gaussianWater(testx, testy);
    %Writes coefficient parameters to Coeff 3d matrix line 1
    
    GaussCoeff_Water_R3(1,:,a)=coeffvalues(ans);
    
    %Writes 95% confidence lower and upper bounds to lines 2 and 3 of Coeff
    GaussCoeff_Water_R3(2:3,:,a)=confint(ans);
    
    %Converts confidence bounds to standard error and writes to row Coeff 4
    GaussCoeff_Water_R3(4,:,a)=(((GaussCoeff_Water_R3(3,:,a))-(GaussCoeff_Water_R3(2,:,a)))/3.92);
    
    %Makes row 5 the co-efficient minus the Standard Error and row 6 the 
    %coefficient plus the Standard Error
    GaussCoeff_Water_R3(5,:,a)=(GaussCoeff_Water_R3(1,:,a))-((GaussCoeff_Water_R3(4,:,a)));
    GaussCoeff_Water_R3(6,:,a)=(GaussCoeff_Water_R3(1,:,a))+((GaussCoeff_Water_R3(4,:,a)));
    %FitOutPut(a,:)=coeffvalues(ans);
a=a+1;
end;

%Plot Figure

figure
clearvars r
r(:,1)=GaussCoeff_Water_R3(1,4,:);
plot((1:size(GaussCoeff_Water_R3, 3))/2,r(:,1))
r(:,1)=GaussCoeff_Water_R3(1,1,:);
hold on
plot((1:size(GaussCoeff_Water_R3, 3))/2,r(:,1))
