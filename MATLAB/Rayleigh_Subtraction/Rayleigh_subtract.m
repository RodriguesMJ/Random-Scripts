d=1;
e=1;

while d<=e
WL=ma2742(1:982,1,d);
Abs=ma2742(1:982,2,d);

Rayleigh_Fit(WL,Abs);

Coeff=coeffvalues(ans);
a=Coeff(1,1);
b=Coeff(1,2);
c=Coeff(1,3);


ma2742(:,3,d)=((a*(ma2742(:,1,d).^b))+c);

ma2742(:,4,d)=ma2742(:,2,d)-ma2742(:,3,d);


plot(ma2742(:,1,d),ma2742(:,4,d))
hold on
d=(d+1);
end
%plot(Pdx1K166R201015I320WS(:,1),Pdx1K166R201015I320WS(:,2))
%hold on
%plot(Pdx1K166R201015I320WS(:,1),Pdx1K166R201015I320WS(:,3))


