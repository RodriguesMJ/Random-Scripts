a=1;


GaussCoeff_glycerol_r3(1:6,1:7,1:size(glycerol100r3, 3))=zeros;
while a<=size(glycerol100r3, 3);
    %while a<=100;    
    testx=glycerol100r3(1:982,1,a);
    testy=glycerol100r3(1:982,5,a);

    Fit2gaussians(testx, testy);
    %Writes coefficient parameters to Coeff 3d matrix line 1
    
    GaussCoeff_glycerol_r3(1,:,a)=coeffvalues(ans);
    
    %Writes 95% confidence lower and upper bounds to lines 2 and 3 of Coeff
    GaussCoeff_glycerol_r3(2:3,:,a)=confint(ans);
    
    %Converts confidence bounds to standard error and writes to row Coeff 4
    GaussCoeff_glycerol_r3(4,:,a)=(((GaussCoeff_glycerol_r3(3,:,a))-(GaussCoeff_glycerol_r3(2,:,a)))/3.92);
    
    %Makes row 5 the co-efficient minus the Standard Error and row 6 the 
    %coefficient plus the Standard Error
    GaussCoeff_glycerol_r3(5,:,a)=(GaussCoeff_glycerol_r3(1,:,a))-((GaussCoeff_glycerol_r3(4,:,a)));
    GaussCoeff_glycerol_r3(6,:,a)=(GaussCoeff_glycerol_r3(1,:,a))+((GaussCoeff_glycerol_r3(4,:,a)));
    %FitOutPut(a,:)=coeffvalues(ans);
a=a+1;
end;

figure
clearvars r
r(:,1)=GaussCoeff_glycerol_r3(1,4,:);
plot((1:size(GaussCoeff_glycerol_r3, 3))/2,r(:,1))
r(:,1)=GaussCoeff_glycerol_r3(1,1,:);
hold on
plot((1:size(GaussCoeff_glycerol_r3, 3))/2,r(:,1))

% opts.Lower = [0 70 218 0 225 508 0];
% opts.StartPoint = [2 23.4 220 1 233 510 0];
% opts.Upper = [Inf 80 222 100 235 512 0];