
linabsplot(:,1)= [Ma150_1_0linbg(283,1); Ma150_1_1linbg(283,1); Ma150_1_2linbg(283,1); Ma150_1_3linbg(283,1); Ma150_1_4linbg(283,1); Ma150_1_5linbg(283,1);Ma150_1_6linbg(283,1); Ma150_1_7linbg(283,1); Ma150_1_8linbg(283,1); Ma150_1_9linbg(283,1); Ma150_1_10linbg(283,1); Ma150_1_11linbg(283,1); Ma150_1_12linbg(283,1); Ma150_1_13linbg(283,1); Ma150_1_14linbg(283,1); Ma150_1_15linbg(283,1); Ma150_1_16linbg(283,1); Ma150_1_17linbg(283,1); Ma150_1_18linbg(283,1); Ma150_1_19linbg(283,1); Ma150_1_20linbg(283,1);Ma150_1_21linbg(283,1); Ma150_1_22linbg(283,1); Ma150_1_23linbg(283,1); Ma150_1_24linbg(283,1); Ma150_1_25linbg(283,1); Ma150_1_26linbg(283,1); Ma150_1_27linbg(283,1); Ma150_1_28linbg(283,1);];
expnumber= [0;1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26;27;28]; 



DosevsAbs(:,1)= EstimatedDosekGy(:,1);
DosevsAbs(:,2)= linabsplot(:,1);

DosevsAbs(:,3)= (DosevsAbs(:,2)/DosevsAbs(1,2))*100;

figure (2);
scatter (DosevsAbs(:,1),DosevsAbs(:,3))
axis ([0 50 0 100])
title('Percentage reduction in I320 absorbance in response to X-ray irradiation')
xlabel('Dose (kilograys)') % x-axis label
ylabel('Percentage of pre-exposure absorbance remaining') % y-axis label
PercentReduction= DosevsAbs(:,3);

