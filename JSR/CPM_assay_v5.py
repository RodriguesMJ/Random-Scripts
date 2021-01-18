#! /Users/matt/opt/anaconda3/bin/python3.7

import numpy as np
import scipy
import csv
import re
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit
from scipy.stats import linregress
from operator import itemgetter
import math

#Use Latex typeface / font
from matplotlib import rc
#rc('font',**{'family':'sans-serif','sans-serif':['Helvetica']})
## for Palatino and other serif fonts use:
#rc('font',**{'family':'serif','serif':['Palatino']})
#rc('text', usetex=True)

#Funtion to round window centre up to nearest integer if non-integer
def round_half_up(n, decimals=0):
	multiplier = 10 ** decimals
	return math.floor(n*multiplier + 0.5) / multiplier

#Function to off-set third y-axis for matplotlib
def make_patch_spines_invisible(ax):
	ax.set_frame_on(True)
	ax.patch.set_visible(False)
	for sp in ax.spines.values():
		sp.set_visible(False)

def stripheader(str):
	str = str.replace("'", "")
	str = str.replace("]", "")
	str = str.rsplit(", ")
	str = str[2:]
	str = [float(item) for item in str]
	return str
#Fit Generic sigmoid to CPM data
def fsigmoid(x, a, b, c, d):
	return a + ( b - a ) / (1.0 + np.exp((c - x) / d))
	# a bottom, b = top c = V50/estTm d = slope
# def fsigmoid(x, a, b):
# 	return 1.0  / (1.0 + np.exp(-a*(x-b)))
#Fit Santoro-Bolen to CPM data 
def santoro(x, yf, mf, yu, mu, tm, R, H):
	return ((yf + (mf * x)) + ((yu + (mu * x)) * np.exp( H * ((x - tm)/tm) / (R * x)))) / (1 + np.exp(H * ((x -tm)/tm)/(R * x))) 

#Scale and normalise fluoresence data
def snfluo(y):
	y = np.asarray(y) - min(y)
	sf = 100 / max(y)
	return y * sf
###########Read in CSV file with TSA data
csv_in = []


with open('./data_file.csv', newline='') as csvfile:
	spamreader = csv.reader(csvfile, delimiter=';')
	for row in spamreader:
		csv_in.append(row)
#Find samples of interest and get their data, search by 'subs' substring
subs = '500ug'
samples = []
header = []
linreg_out = []
for row in csv_in:
	res = [x for x in row if re.search(subs, x)]
	if len(res) > 0:
		samples.append(row)

a = len(samples[1])
b = len(samples)
c = b - 2
print('There are {0} samples'.format(b))

#Get the x-axis temperature points
subs1 = 'Page'
for row in csv_in:
	res = [x for x in row if re.search(subs1, x)]
	if len(res) > 0:	
		header.append(row)
		x = str(header[0])

#Format temperature point data into Python list, and format x-axis data 
x = stripheader(x)
#print(x)

###########Create lists to contain metadata and plot sample data#############
sample_name = []
sample_number = []
d = 0
while d < b:
	y = samples[d]
	sample_number = y[0]
	sample_name = y[1]
	y = y[2:]
	y = [float(item) for item in y]
	y = snfluo(y)
	ID = sample_number + " " + sample_name
	plt.plot(x, y, label = ID)
	d = d + 1
plt.legend()
plt.title('Scaled and Normalised CPM Data')
plt.tight_layout()
plt.xlabel('Temperature (Degrees Celcius)')
plt.ylabel('Fluorescence (RFU)')
plt.xlim(min(x), max(x))
plt.ylim(min(y), (max(y) * 1.05))
plt.grid()
plt.show()
###############################################################################
#Loop through samples and then try different windows for linear regression
###############################################################################
d = 0
#Loop through samples
while d < b:
	y = samples[d]
	sample_number = y[0]
	sample_name = y[1]
	ID = sample_number + " " + sample_name
	y = y[2:] #fluorescence data for sample
	y = [float(item) for item in y]
	y = snfluo(y)
	fit_data = 1
	min_fluo = sorted(zip(y,x), key=itemgetter(0), reverse = False)[0][1]
	if min_fluo >= 65:
		fit_data = 0 
		print('Don\'t fit spectrum {}'.format(d))
		d = d + 1
		continue
	window = 5 #Initial window length
	max_win = 35 #Maximum window length
	win_opt = []
	#Loop through window size
	while window <= max_win:
		start = 0
		finish = start + window
		center = x[int(round_half_up(start + ((window - 1) / 2)))]
		win_slope = [] #Store slope values for given window size
		win_rvalu = [] #Store R-values for given window size
		win_center = []#Temperature at center of window 
		win_ar = []    #Slope multiplied by R_value
		win_size = []  #Store window sizes
		#Slide window across fluorescence range.
		while finish <= len(y):
			#Perform linear regression of temperature against fluorescence within the current temperature window 
			slope, intercept, r_value, p_value, std_err = linregress(x[start:finish],y[start:finish])
			#print('The window size is {0}, {1} start, {2} window end, slope is {3}, R-value is {4}.'.format(window, start, finish, slope, r_value))
			win_center.append(center)
			win_slope.append(slope)
			win_rvalu.append(r_value)
			win_ar.append(slope * r_value)
			win_size.append(window)
			start = start + 1
			finish = finish + 1
			center = center + 1
		#plt.plot(win_center, win_slope)	
		window_stats = sorted(zip(win_ar, win_center, win_slope, win_rvalu, win_size), reverse =True)
		win_opt.append(window_stats[0])
		window = window + 2
	#plt.grid()
	#plt.show()
	win_opt = sorted(win_opt, key=itemgetter(4), reverse = True)
	#Search for greatest window size with R-value > 0.996
	win_count = 0
	while win_count < len(win_opt):
		find_r = win_opt[win_count][3]
		if find_r > 0.996:
			opt_window = win_opt[win_count][4]
			est_tm = win_opt[win_count][1]
			est_slope = win_opt[win_count][2]
			break
		win_count = win_count + 1
	print(est_tm)
	bottom = min(y)
	top = max(y)
	
	#Fit spline with found window to data 
	spl_start = int(0 + (0.5 * (opt_window - 1)))
	max_spl_count = int(max(x) - (0.5 * opt_window))
	finish = 0
	start = 0
	derivative_list = []
	center1_list = []
	while finish <= len(y):
		finish = start + window
		splx_in = x[start:finish]
		sply_in = y[start:finish]
		window_spl = scipy.interpolate.UnivariateSpline(splx_in, sply_in, k=2)
		xwindow = np.linspace(min(x), max(x), 1000)
		spline = list(window_spl(xwindow))
		spl_derivative = window_spl.derivative()
		center1 = ((((max(splx_in) - min(splx_in)) / 2 ) + min(splx_in)))
		derivative = spl_derivative(center1)
		derivative_list.append(float(derivative))
		center1_list.append(center1)
		start = start + 1
	#Fit Boltzmann
	hightop = ( max(y) * 1.1 )
	lowtop = ( max(y) * 0.9 )
	highbottom = ( min(y) * 1.1 )
	lowbottom = ( min(y) * 0.9 )
	lowtm = est_tm - 5
	hightm = est_tm + 5
	highslope = est_slope * 1.0
	lowslope = est_slope * 0.0
	p0 = []
	p0.append(max(y))
	p0.append(min(y))
	p0.append(est_tm)
	p0.append(est_slope)
	#print('The hightop is {0}, lowtop is {1}. High bottom is {2}, lowbottom is {3}. Low est tm is {4}, high est tm is {5}. High slope estimate is {6}, low slope estimate is {7}!'.format(hightop, lowtop, highbottom, lowbottom, lowtm, hightm, highslope, lowslope))
	#popt, pcov = curve_fit(fsigmoid, x, y, method='dogbox', bounds = ([float(lowbottom), float(lowtop), float(lowtm), float(lowslope)], [float(highbottom), float(hightop), float(hightm), float(highslope)]))
	try:
		popt, pcov = curve_fit(fsigmoid, x, y, p0 = p0, method='dogbox')
		bolt_tm = popt[2]
		#print(popt)
		plt.plot(x, fsigmoid(x, *popt), label='Boltzmann Fit')
		plt.plot(x, y, label = ID)
	except RuntimeError:
		print("Error - sigmoid fit failed")
	#print('The Tm is {}'.format(popt[2]))



	#Santoro-Bolen
	#	Define pre-transition and region
	sb_prex = x[:10]
	sb_prey = y[:10]
	slope, intercept, r_value, p_value, std_err = linregress(sb_prex, sb_prey)	
	#print('The pre-slope is {0} and intercept is {1}'.format(slope, intercept))
	sb_sloprey = slope
	sb_intprey = intercept
	#	Define post-transition and region
	sb_postx = x[(len(x)-10):]
	sb_posty = y[(len(x)-10):]
	slope, intercept, r_value, p_value, std_err = linregress(sb_postx, sb_posty)	
	#print('The post-slope is {0} and intercept is {1}'.format(slope, intercept))

	#Set delta H for enthalpy of unfolding to 0
	deltaH = 0

	#set gas constant as float
	gassy = 8.314

	#Fit Santoro Bolen
	#EE@@@@@@@@@@@@@@@@@@@@@@@@##############def santoro(x, yf, mf, yu, mu, tm, R, H):
	p1 = [0,0,100,0, 1,8.314,1]
	try:
		popt, pcov = curve_fit(santoro, x, y, p0 = p1, method='trf')
		residuals = y - santoro(np.asarray(x), * popt)
		ss_res = np.sum(residuals**2)
		ss_tot = np.sum((y - np.mean(y))**2)
		r_square = 1 - (ss_res / ss_tot)
		#popt, pcov = curve_fit(santoro, x, y, method='trf')
		popt2 = list(popt)
		sant_tm = popt2[4]
		print('Sample {3} estimated Tm by linear fit is {0}, by fitting the Boltzmann sigmoid it is {1} and by Santoro-Bolen fit it is {2}'.format(est_tm, bolt_tm, sant_tm, ID))
		print('Santoro-Bolen R-square: {}'.format(r_square))
		plt.plot(x, santoro(np.asarray(x), *popt2), label='Santoro Fit')
	except RuntimeError:
		print("Error - curve_fit failed")

	
	
	if r_square <= 0.95:
		p1 = [0,sb_sloprey,65,0, est_tm,8.314,1]
		try:
			popt, pcov = curve_fit(santoro, x, y, p0 = p1, method='dogbox', bounds = (['0.', '0.','50.','-20.','30.','8.313', '-1000.'],['0.1','20','150','20.', '100.', '8.315', '1000.']))
			print('Sample {3} estimated Tm by linear fit is {0}, by fitting the Boltzmann sigmoid it is {1} and by Santoro-Bolen fit it is {2}'.format(est_tm, bolt_tm, sant_tm, ID))
			print('Santoro-Bolen R-square: {}'.format(r_square))
		except RuntimeError:
			print("Error - initial Santoro Bolen fit failed")
		popt3 = list(popt2)
		residuals = y - santoro(np.asarray(x), * popt3)
		ss_res = np.sum(residuals**2)
		ss_tot = np.sum((y - np.mean(y))**2)
		r_square = 1 - (ss_res / ss_tot)
		print('Adjusted Santoro-Bolen R-square: {}'.format(r_square))
		plt.plot(x, santoro(np.asarray(x), *popt3), label='Santoro Fit Adjusted')

	plt.tight_layout()
	plt.xlabel('Temperature (Degrees Celcius)')
	plt.ylabel('Fluorescence')
	plt.legend()
	plt.grid()
	plt.ylim(min(y), (max(y) * 1.1))
	plt.xlim(min(x), max(x))
	plt.show()
	d = d + 1
