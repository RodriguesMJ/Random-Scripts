%Commands to run for spectra plotting
%Command for making tick label latex format
set(groot, 'defaultAxesTickLabelInterpreter','latex'); set(groot, 'defaultLegendInterpreter','latex'); 

%Set colour matrices
my_blue = [0 0 1];
my_green = [24 180 54] ./ 255;
my_orange = [254 164 5] ./ 255;
my_purple = [86 27 110] ./ 255;


%Plot raw spectra (can be changed
plot (Cryo_R2(:,1,4),Cryo_R2(:,5,4), 'Color', my_blue);
hold on;
plot (Cryo_R2(:,1,16),Cryo_R2(:,5,16), 'Color', my_orange);
plot (Cryo_R2(:,1,89),Cryo_R2(:,5,89), 'Color', my_green);

%Set axis 
%axis([200 800 -0.02 2]);

%Set precision on axis ticks (.2f is two decimal points)
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))

%Set font size
set(gca,'fontsize',18);

%Set axis labels
xlabel('Wavelength (nm)','Interpreter','latex');
ylabel('Absorbance','Interpreter','latex');


%How big? (Need figuresize function) https://github.com/wspr/matlabpkg/blob/master/figuresize.m#L28

figuresize( 15 , 15 , 'centimeters' )

grid on
%Where to save



