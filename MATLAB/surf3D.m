%Script for making 3D surface plots
%y is the wavelength 
load('mattscolormap.mat')
set(groot, 'defaultAxesTickLabelInterpreter','latex'); set(groot, 'defaultLegendInterpreter','latex'); 
set(0,'DefaultFigureColormap',MAP)
y=Cryo_R2(1:783,1);

%b is the spectrum number at the start of the X-ray exposure
b=4;

%d is the time in seconds between collection of spectra
d=16.5;
%e is the dose rate in Gray per second 
e=178;
%x is the spectrum number
x=1:1:size(Cryo_R2, 3);
testtime(1,:)=(x(1,:)-b)*d;
x=testtime;

%mesh grid creates two matrices that describe the wavelength and spectrum number at each point on the surface plot  
[xx,yy]=meshgrid(x,y);

%Create Z, the grid of absorbance values. 
Z(1:783,1:size(Cryo_R2, 3))=zeros;

a=1;
while a <= size(Cryo_R2, 3)
 %   while a <= 200
Z(:,a)=Cryo_R2(1:783,5,a);
a=a+1;
end
a=1; %re-set a
figure
surf(xx,yy,Z); axis tight; shading interp; colorbar;

%surf(xx,yy,Z); set(gca,'ZScale','log'); axis tight; shading interp

%Set font size
set(gca,'fontsize',18);

%Set axis labels
%xlabel('Spectrum Number','Interpreter','latex');
xlabel('Time (s)','Interpreter','latex');
ylabel('Wavelength (nm)','Interpreter','latex');
c=colorbar;
ylabel(c,'Absorbance','Interpreter','latex');

caxis([0 0.8])
set(c,'YTickLabel',{'0.00';'-0.10';'0.20';'0.30';' 0.40';'0.50 ';' 0.60';'0.70 ';' 0.80';})
%set(c,'YTickLabel',{'-0.2000';'-0.1000';'0.0000';'0.1000';' 0.2000';'0.3000 ';' 0.4000';})
%set(gca,'XTickLabel',{'0';'300';'600';'900';'1200';'1500';'1800';'2000';})
view([0 90]);

%ax.YTick = [200 300 400 500 600 700 800 900];

%How big? (Need figuresize function) https://github.com/wspr/matlabpkg/blob/master/figuresize.m#L28

figuresize( 30 , 24, 'centimeters' )

first_axis = gca;
sqz = 0; %// distance to squeeze the first plot
set(first_axis, 'Position', get(first_axis, 'Position') + [0 sqz 0 -sqz ]);
ax2 = axes('Position', get(first_axis, 'Position') .* [1 1 1 1] - [0 sqz 0 0],'Color','none');
scale_factor = e/1000; %// change this to your satisfaction
xlim(get(first_axis, 'XLim') * scale_factor);
set(ax2, 'XScale', get(first_axis, 'XScale')); %// make logarithmic if first axis is too
xlabel('Dose (kGy)','Interpreter','latex');
set(ax2,'XAxisLocation','top');
set(ax2,'YTickLabel',[]);
set(ax2,'ytick',[])
set(ax2,'fontsize',15);


ax = gca;
ax.BoxStyle = 'full';
ax.LineWidth = 3.2;
clearvars testtime x xx yy y Z e
