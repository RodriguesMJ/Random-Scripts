%%%% Plot 1 and 2 %%%%
%Plot the change co-efficient 'a' which relates to the gradient of the
%exponential and 'n' which relates to the y-offset of the exponential
%against dose with standard errors shown. X-axis is dose (kilograys),
%Y-axis has no units.


x=EstimatedDosekGy(1:24,1);
ya=(CoeffSpectra(1,1,1:maxspec));   %Co-efficient a

%set(gcf,'Color',[1,0.4,0.6])
scatter(x,ya,'filled','k');
hold on;


%%%%
%Error bars
yae1=(CoeffSpectra(5,1,1:maxspec));   % Coeff a minus standard error
yae2=(CoeffSpectra(6,1,1:maxspec));   % Coeff a plus standard error
%scatter(x,yae1,'k','^');

hold on

%scatter(x,yae2,'v','k');
hold on
%Natural log of 'a' standard errors
logyae1=(CoeffSpectra(8,1,1:maxspec));
logyae2=(CoeffSpectra(9,1,1:maxspec));

%scatter(x,logyae1,'^','k');
hold on
%scatter(x,logyae2,'v','k');

%%Plot 1 formatting 
xlabel('Dose (kilogray)') % x-axis label
ylabel('Co-efficient value') % y-axis label
legend('Black: Exponential co-efficient')
title('Plot of changes in exponential gaussian fit parameter (a)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)

yn=(CoeffSpectra(1,10,1:maxspec));  %Coefficient n
scatter(x,yn,'filled','g');
hold on
yne1=(CoeffSpectra(5,10,1:maxspec));   % Coeff n minus standard error
yne2=(CoeffSpectra(6,10,1:maxspec));   % Coeff n plus standard error
hold on

scatter(x,yne1,'k','^');

hold on

scatter(x,yne2,'v','k');

%%Plot 2 formatting
xlabel('Dose (kilogray)') % x-axis label
ylabel('Co-efficient value') % y-axis label
legend('Black: Y-offset (n) co-efficient')
title('Plot of changes in y-offset gaussian fit parameter')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)   %%%%Plot co-efficient b with standard errors%%%%%
yb=(CoeffSpectra(1,2,1:maxspec))
ybe1=(CoeffSpectra(5,2,1:maxspec));   % Coeff b minus standard error
ybe2=(CoeffSpectra(6,2,1:maxspec));   % Coeff b plus standard error

scatter(x,yb,'filled','b');  %Scatter coeff b vs dose filled blue
hold on
%scatter(x,ybe1,'b','^');
hold on
%scatter(x,ybe2,'v','b');
hold on
%Natural log of 'a' standard errors
logybe1=(CoeffSpectra(8,2,1:maxspec));
logybe2=(CoeffSpectra(9,2,1:maxspec));
scatter(x,logybe1,'^','k');
hold on
scatter(x,logybe2,'v','k');
xlabel('Dose (kilogray)') % x-axis label
ylabel('Co-efficient value') % y-axis label
legend('Blue: Exponential x-offset (b) co-efficient')
title('Plot of changes in exponential x-offset (b) parameter')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4)   %%%%Plot co-efficient c with standard errors%%%%%
yc=(CoeffSpectra(1,3,1:maxspec))
yce1=(CoeffSpectra(5,3,1:maxspec));   % Coeff c minus standard error
yce2=(CoeffSpectra(6,3,1:maxspec));   % Coeff c plus standard error

scatter(x,yc,'filled','b');  %Scatter coeff c vs dose filled blue
hold on
scatter(x,yce1,'b','^');
hold on
scatter(x,yce2,'v','b');
hold on
%Natural log of 'a' standard errors
logyce1=(CoeffSpectra(8,3,1:maxspec));
logyce2=(CoeffSpectra(9,3,1:maxspec));
%scatter(x,logyce1,'^','k');
hold on
%scatter(x,logyce2,'v','k');
xlabel('Dose (kilogray)') % x-axis label
ylabel('Co-efficient value') % y-axis label
legend('Blue: Exponential half life co-efficient(c)')
title('Plot of changes in exponential half life parameter (c)')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(5)   %%%%Plot co-efficient d with standard errors%%%%%
yd=(CoeffSpectra(1,4,1:maxspec))
yde1=(CoeffSpectra(5,4,1:maxspec));   % Coeff d minus standard error
yde2=(CoeffSpectra(6,4,1:maxspec));   % Coeff d plus standard error

scatter(x,yd,'filled','g');  %Scatter coeff d vs dose filled green
hold on
scatter(x,yde1,'k','^');
hold on
scatter(x,yde2,'v','k');
hold on
%Natural log of 'a' standard errors
logyde1=(CoeffSpectra(8,4,1:maxspec));
logyde2=(CoeffSpectra(9,4,1:maxspec));
%scatter(x,logyde1,'^','k');
hold on
%scatter(x,logyde2,'v','k');
xlabel('Dose (kilogray)') % x-axis label
ylabel('Co-efficient value') % y-axis label
legend('Blue: Area under 280 gaussian co-efficient(d)')
title('Plot of changes in 280 nm gaussian parameter (d)')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(6)   %%%%Plot co-efficient e with standard errors%%%%%
ye=(CoeffSpectra(1,5,1:maxspec))
yee1=(CoeffSpectra(5,5,1:maxspec));   % Coeff d minus standard error
yee2=(CoeffSpectra(6,5,1:maxspec));   % Coeff d plus standard error

scatter(x,ye,'filled','r');  %Scatter coeff e vs dose filled red
hold on
scatter(x,yee1,'r','^');
hold on
scatter(x,yee2,'v','r');
hold on
%Natural log of 'a' standard errors
logyee1=(CoeffSpectra(8,5,1:maxspec));
logyee2=(CoeffSpectra(9,5,1:maxspec));
%scatter(x,logyee1,'^','k');
hold on
%scatter(x,logyee2,'v','k');
xlabel('Dose (kilogray)') % x-axis label
ylabel('Co-efficient value') % y-axis label
legend('Red: Sigma of the 280 gaussian co-efficient(e)')
title('Plot of changes in 280 nm gaussian sigma(e)')





%%%%%%%%%%%%%%%%%%%%%%%%%Format plot 1%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xlabel('Dose (kilogray)') % x-axis label
ylabel('Co-efficient value') % y-axis label
legend('Black: Exponential co-efficient','Green: Y-offset of exponential')
title('Plot of changes in exponential gaussian fit parameters')
%axis([0 500 0 5])





%Clear variables
clearvars yae1 yae2 logyae1 logyae2 ya yne1 yne2 yb
















% %plot dose against area under 320 gaussian (coefficient h, listed in Coeff line 1, column 7)
% y(:,1)=(CoeffSpectra(1,7,1:24));
% 
% 
% scatter (EstimatedDosekGy(1:24,1),y,'g','filled')
% 
% hold on
% 
% %Plot 280 change
% y(:,1)=(CoeffSpectra(1,4,1:24));
% scatter (EstimatedDosekGy(1:24,1),y,'b','filled')
% 
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%Format plot%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xlabel('Dose (kilogray)') % x-axis label
% ylabel('Area under gaussian') % y-axis label
% legend('Green:320nm gaussian','Blue:280nm gaussian')
% title('Plot of changes in exponential gaussian fit parameters')
% axis([0 500 0 10])
% 
% 
% 
% 
% figure(2);
% 
% %Sigma 280
% y(:,1)=(CoeffSpectra(1,5,1:24));
% scatter (EstimatedDosekGy(1:24,1),y,'r','filled')
% 
% hold on
% %Sigma 320
% y(:,1)=(CoeffSpectra(1,8,1:24));
% scatter (EstimatedDosekGy(1:24,1),y,'k','filled')
% 
% xlabel('Dose (kilogray)') % x-axis label
% ylabel('Gaussian Sigma') % y-axis label
% legend('Black:320nm gaussian sigma','Red:280nm gaussian sigma')
% title('Plot of changes in gaussian sigmas against dose')
% %axis([0 500 0 10])
