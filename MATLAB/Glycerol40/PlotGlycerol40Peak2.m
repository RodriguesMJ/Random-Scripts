%plot gausschange glycerol 40% r3


figure


clearvars r
r(:,1)=GaussCoeff_glycerol40_r3(1,4,:);
r(:,2)=smooth(r(:,1),100,'sgolay',2);
plot(((1:size(GaussCoeff_glycerol40_r3, 3))/2)-10,r(:,2))
grid on
axis([-10 2000 0 30])

%Set axis labels
xlabel('Time (seconds)','Interpreter','latex');
ylabel('Area under 590 nm peak','Interpreter','latex');
%Set precision on axis ticks (.2f is two decimal points)
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.0f'))
%Set font size
set(gca,'fontsize',18);
first_axis = gca;
sqz = 0; %// distance to squeeze the first plot
set(first_axis, 'Position', get(first_axis, 'Position') + [0 sqz 0 -sqz ]);
ax2 = axes('Position', get(first_axis, 'Position') .* [1 1 1 1] - [0 sqz 0 0],'Color','none');
scale_factor = 111/1000; %// change this to your satisfaction
xlim(get(first_axis, 'XLim') * scale_factor);
set(ax2, 'XScale', get(first_axis, 'XScale')); %// make logarithmic if first axis is too
xlabel('Dose (kGy)','Interpreter','latex');
set(ax2,'XAxisLocation','top');
set(ax2,'YTickLabel',[]);
set(ax2,'ytick',[])
set(ax2,'fontsize',30);
second_axis= ax2;
%Set font size
set(gca,'fontsize',18);
set(first_axis,'XTick',0:300:1800)
set(first_axis,'XTickLabel',{'0';'300';'600';'900';'1200';'1500';'1800';})

%Add dose axis

figuresize( 20 , 20 , 'centimeters' )