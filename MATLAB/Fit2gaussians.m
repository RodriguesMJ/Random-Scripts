function [fitresult, gof] = createFit(Ma150_1_0wav, Ma150_1_0abs)
%CREATEFIT(MA150_1_0WAV,MA150_1_0ABS)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : Ma150_1_0wav
%      Y Output: Ma150_1_0abs
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 26-Nov-2014 11:42:04  Edited since, see Matts lab book 3, 27/11/14.


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( Ma150_1_0wav, Ma150_1_0abs );

% Set up fittype and options.
ft = fittype( '(d/(e*(sqrt(pi/2))))*exp(-2*(x-f)*(x-f)/(e*e))+(h/(k*(sqrt(pi/2))))*exp(-2*(x-l)*(x-l)/(k*k))+n', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0 75 200 0 240 510 0];
opts.StartPoint = [2 23.4 220 1 260 520 0];
opts.Upper = [Inf 85 Inf 100 280 530 0];
% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts )

% Plot fit with data.
%figure( 'Name', 'Ma151-1' );
%h = plot( fitresult, xData, yData );
%legend( h, 'Ma150_1_0abs vs. Ma150_1_0wav', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes
%xlabel( 'Wavelength (nm)', 'Interpreter','none' );
%ylabel( 'Absorbance', 'Interpreter','none' );
%title( 'Ma151-1_0 fit of Gaussians on Exponential Background','Interpreter','none' )
%grid on




