
absplot(:,1)= [Ma148_5_0Adjusted(283,1); Ma148_5_1Adjusted(283,1); Ma148_5_2Adjusted(283,1); Ma148_5_3Adjusted(283,1); Ma148_5_4Adjusted(283,1); Ma148_5_5Adjusted(283,1);Ma148_5_6Adjusted(283,1); Ma148_5_7Adjusted(283,1); Ma148_5_8Adjusted(283,1); Ma148_5_9Adjusted(283,1); Ma148_5_10Adjusted(283,1); Ma148_5_11Adjusted(283,1); Ma148_5_12Adjusted(283,1); Ma148_5_13Adjusted(283,1); Ma148_5_14Adjusted(283,1);];
expnumber= [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15];



DosevsAbs(:,1)= EstimatedDosekGy(:,1)
DosevsAbs(:,2)= absplot(:,1)

DosevsAbs(:,3)= (DosevsAbs(:,2)/DosevsAbs(1,2))*100


scatter (DosevsAbs(:,1),DosevsAbs(:,3))