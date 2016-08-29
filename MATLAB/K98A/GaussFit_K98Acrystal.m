a=1;
GaussCoeff_K98A_R2(1:6,1:10,1:size(K98A_2nd_Crystal_R2, 3))=zeros;
while a<=size(K98A_2nd_Crystal_R2, 3);
    %while a<=100;    
    testx=K98A_2nd_Crystal_R2(1:982,1,a);
    testy=K98A_2nd_Crystal_R2(1:982,5,a);

    Fit3gaussians(testx, testy);
    %Writes coefficient parameters to Coeff 3d matrix line 1
    
    GaussCoeff_K98A_R2(1,:,a)=coeffvalues(ans);
    
    %Writes 95% confidence lower and upper bounds to lines 2 and 3 of Coeff
    GaussCoeff_K98A_R2(2:3,:,a)=confint(ans);
    
    %Converts confidence bounds to standard error and writes to row Coeff 4
    GaussCoeff_K98A_R2(4,:,a)=(((GaussCoeff_K98A_R2(3,:,a))-(GaussCoeff_K98A_R2(2,:,a)))/3.92);
    
    %Makes row 5 the co-efficient minus the Standard Error and row 6 the 
    %coefficient plus the Standard Error
    GaussCoeff_K98A_R2(5,:,a)=(GaussCoeff_K98A_R2(1,:,a))-((GaussCoeff_K98A_R2(4,:,a)));
    GaussCoeff_K98A_R2(6,:,a)=(GaussCoeff_K98A_R2(1,:,a))+((GaussCoeff_K98A_R2(4,:,a)));
    %FitOutPut(a,:)=coeffvalues(ans);
a=a+1;
end;
