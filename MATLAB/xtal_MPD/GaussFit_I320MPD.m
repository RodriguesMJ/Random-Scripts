a=1;
GaussCoeff_Ma280_5(1:6,1:10,1:size(Ma280_5, 3))=zeros;
while a<=size(Ma280_5, 3);
    %while a<=100;    
    testx=Ma280_5(1:982,1,a);
    testy=Ma280_5(1:982,5,a);

    Fit3gaussians(testx, testy);
    %Writes coefficient parameters to Coeff 3d matrix line 1
    
    GaussCoeff_Ma280_5(1,:,a)=coeffvalues(ans);
    
    %Writes 95% confidence lower and upper bounds to lines 2 and 3 of Coeff
    GaussCoeff_Ma280_5(2:3,:,a)=confint(ans);
    
    %Converts confidence bounds to standard error and writes to row Coeff 4
    GaussCoeff_Ma280_5(4,:,a)=(((GaussCoeff_Ma280_5(3,:,a))-(GaussCoeff_Ma280_5(2,:,a)))/3.92);
    
    %Makes row 5 the co-efficient minus the Standard Error and row 6 the 
    %coefficient plus the Standard Error
    GaussCoeff_Ma280_5(5,:,a)=(GaussCoeff_Ma280_5(1,:,a))-((GaussCoeff_Ma280_5(4,:,a)));
    GaussCoeff_Ma280_5(6,:,a)=(GaussCoeff_Ma280_5(1,:,a))+((GaussCoeff_Ma280_5(4,:,a)));
    %FitOutPut(a,:)=coeffvalues(ans);
a=a+1;
end;
