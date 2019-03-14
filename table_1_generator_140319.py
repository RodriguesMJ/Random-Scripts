#!/usr/bin/env python3.7

import glob
import math
import re
import subprocess
import sys
import numpy as np
import csv
import pandas as pd
import matplotlib as plot
import os
from matplotlib.ft2font import FT2Font
from matplotlib.font_manager import FontProperties
import matplotlib.pyplot as plt
from prettytable import PrettyTable


plt.rc('text', usetex=True)
plt.rc('font', family='serif')
dose = 1.74
space_group = "P6122" 
beamline = "DLS I24"


mtz_paths = []
for filename in glob.iglob('./CCT368375_aimless_files/aimless/**/sweep_.log', recursive=True):
    mtz_paths.append(filename)
mtz_paths.sort()

c = len(mtz_paths)
d = 0
cellA = []
cellB = []
cellC = []
cell_alpha = []
cell_beta  = []
cell_gamma = []
wavelength = []
low_res = []
low_high_res = []
high_res = []
unique_all = []
unique_high = []
unique_low = []
multi_all = []
multi_high = []
multi_low = []
rpim_all = []
rpim_high = []
rpim_low = []
rmeas_all = []
rmeas_high = []
rmeas_low = []
CC_half_high = []
CC_half_all = []
CC_half_low = []
sigI_high = []
sigI_all = []
sigI_low = []
comp_high = []
comp_all = []
comp_low = []
wilsonB = []

while d < c:
	txt = mtz_paths[d]
	log_file = open(txt)
	d_wavelength = []
	d_low_res = []
	d_high_res = []
	d_unique = []
	d_multi = []
	for line in open(txt):
		if "Average unit cell" in line:
			cell = []
			cell.append(line)
			
	cell_string = cell[0]
	cell_string = cell_string.split(':')[1]
	cell_string = ' '.join(cell_string.split())

	d_cell_a = cell_string.split(' ')[0]
	d_cell_b = cell_string.split(' ')[1]
	d_cell_c = cell_string.split(' ')[2]
	d_cell_alpha = cell_string.split(' ')[3]
	d_cell_beta = cell_string.split(' ')[4]
	d_cell_gamma = cell_string.split(' ')[5]
	cellA.append(d_cell_a)
	cellB.append(d_cell_b)
	cellC.append(d_cell_c)
	cell_alpha.append(d_cell_alpha)
	cell_beta.append(d_cell_beta)
	cell_gamma.append(d_cell_gamma)

	for line in open(txt):
		if "Wavelength" in line:
			d_wavelength.append(line)
			d_wavelength_string = d_wavelength[0]
			d_wavelength_string = d_wavelength_string.split(':')[1]
			d_wavelength_string = d_wavelength_string.replace(" ", "")
			d_wavelength_string = d_wavelength_string.split('\n')[0]
			d_wavelength_np = np.array(d_wavelength_string, dtype=np.float32)
			d_wavelength_np = np.around(d_wavelength_np, decimals=4)

	wavelength.append(d_wavelength_np)

	for line in open(txt):
		if "Low resolution limit" in line:
			d_low_res.append(line)
			d_low_res_string = d_low_res[0]
			d_low_res_string = re.sub(' +', ' ', d_low_res_string)
			d_low = d_low_res_string.split(' ')[3]
			d_low_hi = d_low_res_string.split(' ')[5]
			d_low_hi = d_low_hi.split('\n')[0]
	
	low_res.append(d_low)
	low_high_res.append(d_low_hi)

	for line in open(txt):
		if "High resolution limit" in line:
			if "reset" in line:
				continue
			else:
				d_high_res.append(line)
				d_high_res_string = d_high_res[0]
				d_high_res_string = re.sub(' +', ' ', d_high_res_string)
				d_high = d_high_res_string.split(' ')[5]
				d_high = d_high.split('\n')[0]
	high_res.append(d_high)

	for line in open(txt):
		if "Total number unique" in line:
			d_unique.append(line)
			d_unique_string = d_unique[0]
			d_unique_string = re.sub(' +', ' ', d_unique_string)
			d_unique_high = d_unique_string.split(' ')[5]
			d_unique_low = d_unique_string.split(' ')[4]
			d_unique_all = d_unique_string.split(' ')[3]
			d_unique_high = d_unique_high.split('\n')[0]
	unique_high.append(d_unique_high)
	unique_low.append(d_unique_low)
	unique_all.append(d_unique_all)

	for line in open(txt):
		if "Multiplicity          " in line:
			d_multi.append(line)
			d_multi_string = d_multi[0]
			d_multi_string = re.sub(' +', ' ', d_multi_string)
			d_multi_high = d_multi_string.split(' ')[3]
			d_multi_low = d_multi_string.split(' ')[2]
			d_multi_all = d_multi_string.split(' ')[1]
			d_multi_high = d_multi_high.split('\n')[0]
	multi_high.append(d_multi_high)
	multi_low.append(d_multi_low)
	multi_all.append(d_multi_all)

	for line in open(txt):
		if "Rpim (all I+ & I-)  " in line:
			d_rpim = []
			d_rpim.append(line)
			d_rpim_string = d_rpim[0]
			d_rpim_string = re.sub(' +', ' ', d_rpim_string)
			d_rpim_string = d_rpim_string.split(')')[1]
			d_rpim_high = d_rpim_string.split(' ')[3]
			d_rpim_low = d_rpim_string.split(' ')[2]
			d_rpim_all = d_rpim_string.split(' ')[1]
			d_rpim_high = d_rpim_high.split('\n')[0]
	rpim_high.append(d_rpim_high)
	rpim_low.append(d_rpim_low)
	rpim_all.append(d_rpim_all)

	for line in open(txt):
		if "Rmeas (all I+ & I-)   " in line:
			d_rmeas = []
			d_rmeas.append(line)
			d_rmeas_string = d_rmeas[0]
			d_rmeas_string = re.sub(' +', ' ', d_rmeas_string)
			d_rmeas_string = d_rmeas_string.split(')')[1]
			d_rmeas_high = d_rmeas_string.split(' ')[3]
			d_rmeas_low = d_rmeas_string.split(' ')[2]
			d_rmeas_all = d_rmeas_string.split(' ')[1]
			d_rmeas_high = d_rmeas_high.split('\n')[0]
	rmeas_high.append(d_rmeas_high)
	rmeas_low.append(d_rmeas_low)
	rmeas_all.append(d_rmeas_all)	
	
	for line in open(txt):
		if "Mn(I) half-set correlation CC(1/2) " in line:
			d_cc_half = []
			d_cc_half.append(line)
			d_cc_half_string = d_cc_half[0]
			d_cc_half_string = re.sub(' +', ' ', d_cc_half_string)
			d_cc_half_high = d_cc_half_string.split(' ')[6]
			d_cc_half_low = d_cc_half_string.split(' ')[5]
			d_cc_half_all = d_cc_half_string.split(' ')[4]
			d_cc_half_high = d_cc_half_high.split('\n')[0]
	CC_half_high.append(d_cc_half_high)
	CC_half_low.append(d_cc_half_low)
	CC_half_all.append(d_cc_half_all)

	for line in open(txt):
		if "Mean((I)/sd(I))" in line:
			d_sigI = []
			d_sigI.append(line)
			d_sigI_string = d_sigI[0]
			d_sigI_string = re.sub(' +', ' ', d_sigI_string)
			d_sigI_high = d_sigI_string.split(' ')[3]
			d_sigI_low = d_sigI_string.split(' ')[2]
			d_sigI_all = d_sigI_string.split(' ')[1]
			d_sigI_high = d_sigI_high.split('\n')[0]
	sigI_high.append(d_sigI_high)
	sigI_low.append(d_sigI_low)
	sigI_all.append(d_sigI_all)

	for line in open(txt):
		if "Completeness      " in line:
			d_comp = []
			d_comp.append(line)
			d_comp_string = d_comp[0]
			d_comp_string = re.sub(' +', ' ', d_comp_string)
			d_comp_high = d_comp_string.split(' ')[3]
			d_comp_low = d_comp_string.split(' ')[2]
			d_comp_all = d_comp_string.split(' ')[1]
			d_comp_high = d_comp_high.split('\n')[0]
	comp_high.append(d_comp_high)
	comp_low.append(d_comp_low)
	comp_all.append(d_comp_all)

	for line in open(txt):
		if "Wilson plot - estimated B factor" in line:
			d_wilson = []
			d_wilson.append(line)
			d_wilson_string = d_wilson[0]
			d_wilson_string = re.sub(' +', ' ', d_wilson_string)
			d_wilson_string = d_wilson_string.split('=')[1]
			d_wilson = d_wilson_string.split(' ')[1]
	wilsonB.append(d_wilson)


	d += 1

paths = []
for filename in glob.iglob('../dose_refinement_180315/occ//**/refine.pdb', recursive=True):
    paths.append(filename)


paths.sort()
a = len(paths)
#print(a)
b = 0
freeR = []
Rwork = []
rama_out = []
rama_fav = []
favored = []
allowed = []
outlier = []
water_count = []
water_average = []
protein_count = []
protein_average = []
ligand_count = []
ligand_average = []
bond_deviation = []
angle_deviation = []

while b < a:
	txt = paths[b]
	pdb_file = open(txt)
	b_free = []
	b_work = []
	b_water_b = []
	b_prot_b = []
	b_lig_b = []
	b_dev = []
	b_ang = []
	for line in open(txt):
		#Grep the Rfree and Rwork values from PDB header
		if "free" in line:
			line1 = line.split('free')[1]
			line1 = line1.split('/')[1]
			line1 = line1.split('\n')[0]
			b_free.append(line1)	
			line2 = line.split('free')[1]
			line2 = line2.split(' ')[1]
			line2 = line2.split('/')[0]
			b_work.append(line2)	

		if "BOND LENGTHS" in line:
			if "(A)" in line:
				devline = line.split(':')[1]
				devline = devline.replace(" ", "")
				devline = devline.split('\n')[0]
				b_dev.append(devline)

		if "BOND ANGLE" in line:
			if "DEGREES" in line:
				angline = line.split(':')[1]
				angline = angline.replace(" ", "")
				angline = angline.split('\n')[0]
				b_ang.append(angline)		
	Rwork.append(b_work[0])
	freeR.append(b_free[0])	
	bond_deviation.append(b_dev[0])
	angle_deviation.append(b_ang[0])

	#Calculate residual b-factors for protein, ligand and water
	for line in open(txt):	
		if "ATOM" in line:
			if "REMARK" in line:
				continue
			else:
				prot_b = line[61:66]
				b_prot_b.append(prot_b)
		if "HETATM" in line:
			if "HOH" in line:
				water_b = line[61:66]		
				b_water_b.append(water_b)
			else:
				lig_b = line[61:66]
				b_lig_b.append(lig_b)


	#Now count waters
	no_wat = len(b_water_b)	
	b_water_b_np = b_water_b.copy()
	b_water_b_np = np.array(b_water_b_np, dtype=np.float32)
	water_count.append(no_wat)	
	water_count_np = water_count.copy()
	water_count_np = np.array(water_count_np, dtype=np.float32)
	water_b_sum = np.sum(b_water_b_np)
	wat_ave_b = np.divide(water_b_sum, no_wat)
	wat_ave_b_round = "%.2f" % round(wat_ave_b,2)
	water_average.append(wat_ave_b_round ) 

	#Now count protein atoms
	no_prot_atom = len(b_prot_b)
	b_prot_b_np = b_prot_b.copy()
	b_prot_b_np = np.array(b_prot_b_np, dtype=np.float32)
	protein_count.append(no_prot_atom)
	protein_count_np = protein_count.copy()
	protein_count_np = np.array(protein_count_np, dtype=np.float32)
	protein_b_sum = np.sum(b_prot_b_np)
	prot_ave_b = np.divide(protein_b_sum, no_prot_atom)
	prot_ave_b_round = "%.2f" % round(prot_ave_b,2)
	protein_average.append(prot_ave_b_round) 

	#Finally, count ligand atoms
	no_lig_atom = len(b_lig_b)
	b_lig_b_np = b_lig_b.copy()
	b_lig_b_np = np.array(b_lig_b_np, dtype=np.float32)
	ligand_count.append(no_lig_atom)
	ligand_count_np = ligand_count.copy()
	ligand_count_np = np.array(ligand_count_np, dtype=np.float32)
	ligand_b_sum = np.sum(b_lig_b_np)
	lig_ave_b = np.divide(ligand_b_sum, no_lig_atom)
	lig_ave_b_round = "%.2f" % round(lig_ave_b,2)
	ligand_average.append(lig_ave_b_round) 

	PDB_IN = paths[b]	
	proc = subprocess.run(["mmtbx.validation_summary", PDB_IN], encoding='utf-8', stdout=subprocess.PIPE)
	for line in proc.stdout.split('\n'):
		if "Ramachandran outliers" in line:
			line = line.split('outliers')[1]	
			line = line.replace(" ", "")
			line = line.split('=')[1]
			line = line.split('%')[0]
			rama_out.append(line)
		
		if "favored" in line:
                        line = line.split('favored')[1]
                        line = line.replace(" ", "")
                        line = line.split('=')[1]
                        line = line.split('%')[0]
                        rama_fav.append(line)

	proc = subprocess.run(["phenix.ramalyze", PDB_IN], encoding='utf-8', stdout=subprocess.PIPE) 
	for line in proc.stdout.split('\n'):	
		if "SUMMARY" in line:
			if "residues" in line:
				line1 = line.split(':')[1]
				line1 = line1.replace(" ", "") 
				line1 = line1.split('Favored')[0]	
				favored.append(line1)

			if "residues" in line:
				line2 = line.split('Favored,')[1]
				line2 = line2.replace(" ", "")
				line2 = line2.split('Allowed')[0]
				allowed.append(line2)
	
			if "residues" in line:
				line = line.split('Allowed,')[1]
				line = line.split('Outlier')[0]
				outlier.append(line)


	
	b += 1

#Multiply Rwork and Rfree by 100
Rwork_np = Rwork.copy()
Rwork_np = np.array(Rwork, dtype=np.float32)
Rwork_scale_np =  np.multiply(Rwork_np, 100)
Rwork_scale_np = np.around(Rwork_scale_np, decimals=2)
Rwork = Rwork_scale_np.tolist()
Rwork = [ '%.2f' % x for x in Rwork ]

Rfree_np = freeR.copy()
Rfree_np = np.array(Rfree_np, dtype=np.float32)
Rfree_scale_np =  np.multiply(Rfree_np, 100)
Rfree_scale_np = np.around(Rfree_scale_np, decimals=2)
Rfree = Rfree_scale_np.tolist()
Rfree = [ '%.2f' % x for x in Rfree ]

#Multiply Rpim by 100
rpim_all_np = np.array(rpim_all, dtype=np.float32)
rpim_all_np = np.multiply(rpim_all_np, 100)
rpim_all_np = np.around(rpim_all_np, decimals=1)
rpim_all = rpim_all_np.tolist()
rpim_all = [round(x, 1) for x in rpim_all]

rpim_low_np = np.array(rpim_low, dtype=np.float32)
rpim_low_np = np.multiply(rpim_low_np, 100)
rpim_low_np = np.around(rpim_low_np, decimals=1)
rpim_low = rpim_low_np.tolist()
rpim_low = [round(x, 1) for x in rpim_low]

rpim_high_np = np.array(rpim_high, dtype=np.float32)
rpim_high_np = np.multiply(rpim_high_np, 100)
rpim_high_np = np.around(rpim_high_np, decimals=1)
rpim_high = rpim_high_np.tolist()
rpim_high = [round(x, 1) for x in rpim_high]

#Multiply Rmeas by 100
rmeas_all_np = np.array(rmeas_all, dtype=np.float32)
rmeas_all_np = np.multiply(rmeas_all_np, 100)
rmeas_all_np = np.around(rmeas_all_np, decimals=1)
rmeas_all = rmeas_all_np.tolist()
rmeas_all = [round(x, 1) for x in rmeas_all]

rmeas_low_np = np.array(rmeas_low, dtype=np.float32)
rmeas_low_np = np.multiply(rmeas_low_np, 100)
rmeas_low_np = np.around(rmeas_low_np, decimals=1)
rmeas_low = rmeas_low_np.tolist()
rmeas_low = [round(x, 1) for x in rmeas_low]

rmeas_high_np = np.array(rmeas_high, dtype=np.float32)
rmeas_high_np = np.multiply(rmeas_high_np, 100)
rmeas_high_np = np.around(rmeas_high_np, decimals=1)
rmeas_high = rmeas_high_np.tolist()
rmeas_high = [round(x, 1) for x in rmeas_high]

#Round all cc half values to 3 decimal places/

CC_half_all = np.array(CC_half_all, dtype=np.float32)
CC_half_all = np.around(CC_half_all, decimals=3)
CC_half_all = CC_half_all.tolist()
CC_half_all = [round(x, 3) for x in CC_half_all]

CC_half_high = np.array(CC_half_high, dtype=np.float32)
CC_half_high = np.around(CC_half_high, decimals=3)
CC_half_high = CC_half_high.tolist()
CC_half_high = [round(x, 3) for x in CC_half_high]

CC_half_low = np.array(CC_half_low, dtype=np.float32)
CC_half_low = np.around(CC_half_low, decimals=3)
CC_half_low = CC_half_low.tolist()
CC_half_low = [round(x, 3) for x in CC_half_low]

#Ramachandran values
np.set_printoptions(precision=3)
rama_out_np = rama_out.copy()
rama_out_np = np.array(rama_out_np, dtype=np.float32)

rama_fav_np = rama_fav.copy()
rama_fav_np = np.array(rama_fav_np, dtype=np.float32)
rama_allowed_np = 100 - np.add(rama_out_np, rama_fav_np)

#Total number of atoms 
total_atom_np = np.add(water_count, protein_count)
total_atom_np = np.add(total_atom_np, ligand_count)
###########################################################################################
#Prepare lists for input to table

#Make a list of X-ray doses for table
a = 1 
b = len(cellA)
dose_list = []
while a <= b:
	current_dose = dose * a 
	dose_list.append(current_dose)
	a +=1

#Make a list of strings with cell a and c dimensions.
a = 0
b = len(cellA)
combi_cell = []

while a < b:
	if a == 0:
		combi_cell.append('Unit cell (a, b, c)')
	if a >= 0:
		stringa = cellA[a]
		stringc = cellC[a]
		string_add = stringa + ', ' + stringc
		combi_cell.append(string_add)
	a += 1

#Make a list of strings with cell alpha and gamma angles
a = 0
b = len(cellA)
combi_angle = []

while a < b:
	if a == 0:
		combi_angle.append('Unit Cell (a, b, g)')
	if a >= 0:
		stringa = cell_alpha[a]	
		stringb = cell_beta[a]
		stringc = cell_gamma[a]
		string_add = stringa + ', ' + stringc
		string_add = stringa + ', ' + stringb + ', ' + stringc
		combi_angle.append(string_add)
	a += 1

#Make a list of strings with total resolution limits
a = 0
b = len(cellA)
combi_reso = []

while a < b:
	if a == 0:
		combi_reso.append('Resolution ()')
	if a >= 0:
		stringa = low_res[a]	
		stringb = high_res[a]
		string_add = stringa + '-' + stringb
		combi_reso.append(string_add)
	a += 1

#Make a list of strings with total resolution limits
a = 0
b = len(cellA)
combi_hireso = []

while a < b:
	if a == 0:
		combi_hireso.append('')
	if a >= 0:
		stringa = low_high_res[a]	
		stringb = high_res[a]
		string_add = '(' + stringa + '-' + stringb + ')'
		combi_hireso.append(string_add)
	a += 1


#Make a list of strings with number of unique reflections
a = 0
b = len(cellA)
combi_unique = []

while a < b:
	if a == 0:
		combi_unique.append('Unique reflections')
	if a >= 0:
		stringa = unique_all[a]	
		stringb = unique_high[a]
		string_add = stringa + ' (' + stringb + ')'
		combi_unique.append(string_add)
	a += 1

#Make a list of strings with multiplicity of reflections
a = 0
b = len(cellA)
combi_multi = []

while a < b:
	if a == 0:
		combi_multi.append('Multiplicity')
	if a >= 0:
		stringa = multi_all[a]	
		stringb = multi_high[a]
		string_add = stringa + ' (' + stringb + ')'
		combi_multi.append(string_add)
	a += 1

#Make a list of strings with Rpim of reflections
a = 0
b = len(cellA)
combi_rpim = []
while a < b:
	if a == 0:
		combi_rpim.append('Rp.i.m (%)')
	if a >= 0:
		stringa = rpim_all[a]
		stringa = str(stringa)	
		stringb = rpim_high[a]
		stringb = str(stringb)
		string_add = stringa + ' (' + stringb + ')'
		combi_rpim.append(string_add)
	a += 1

#Make a list of strings with Rmeas of reflections
a = 0
b = len(cellA)
combi_rmeas = []
while a < b:
	if a == 0:
		combi_rmeas.append('Rmeas (%)')
	if a >= 0:
		stringa = rmeas_all[a]
		stringa = str(stringa)	
		stringb = rmeas_high[a]
		stringb = str(stringb)
		string_add = stringa + ' (' + stringb + ')'
		combi_rmeas.append(string_add)
	a += 1

#Make a list of strings with CC0.5 of reflections
a = 0
b = len(cellA)
combi_cc = []
while a < b:
	if a == 0:
		combi_cc.append('CC0.5')
	if a >= 0:
		stringa = CC_half_all[a]
		stringa = str(stringa)	
		stringb = CC_half_high[a]
		stringb = str(stringb)
		string_add = stringa + ' (' + stringb + ')'
		combi_cc.append(string_add)
	a += 1

#Make a list of strings with I/sigma of reflections
a = 0
b = len(cellA)
combi_sig = []
while a < b:
	if a == 0:
		combi_sig.append('I/sig(I)')
	if a >= 0:
		stringa = sigI_all[a]
		stringa = str(stringa)	
		stringb = sigI_high[a]
		stringb = str(stringb)
		string_add = stringa + ' (' + stringb + ')'
		combi_sig.append(string_add)
	a += 1

#Make a list for thhe spacegroup information

a = 0
b = len(cellA)
combi_sg = []

while a < b:
	if a == 0:
		combi_sg.append('Space group')
	if a >= 0:
		combi_sg.append(space_group)
	a += 1

#Make a beamline list
a = 0 
b = len(cellA)
combi_beam = []

while a < b:
	if a == 0:
		combi_beam.append('Beamline')
	if a >= 0:
		combi_beam.append(beamline)
	a += 1

#Make a beamline list
a = 0 
b = len(cellA)
combi_wave = []

while a < b:
	if a == 0:
		combi_wave.append('Wavelength ()')
	if a >= 0:
		combi_wave.append(wavelength[a])
	a += 1

#Make a list of doses 
a = 0 
b = len(cellA)
combi_dose = []

while a < b:
	if a == 0:
		combi_dose.append('Dose (MGy)')
	if a >= 0:
		combi_dose.append(dose_list[a])
	a += 1



#Make a blank line with the correct number of fields
a = 0 
b = len(cellA)
blank = []

while a < b:
	if a == 0:
		blank.append('')
	if a >= 0:
		blank.append('')
	a += 1

#Make a list of overall and outer shell completeness 
a = 0
b = len(cellA)
combi_comp = []
while a < b:
	if a == 0:
		combi_comp.append('Completeness (%)')
	if a >= 0:
		stringa = comp_all[a]
		stringa = str(stringa)	
		stringb = comp_high[a]
		stringb = str(stringb)
		string_add = stringa + ' (' + stringb + ')'
		combi_comp.append(string_add)
	a += 1

#Make a list of wilson B factors
a = 0 
b = len(cellA)
combi_wilson = []

while a < b:
	if a == 0:
		combi_wilson.append('Wilson B ()')
	if a >= 0:
		combi_wilson.append(wilsonB[a])
	a += 1
#refinement and ramachandran table divide 
a = 0 
b = len(cellA)
blank_refine = []
blank_rama = []
blank_b = []
while a < b:
	if a == 0:
		blank_refine.append('Refinement')
		blank_rama.append('Ramachandran (#, %)')
		blank_b.append('B-factors')
	if a >= 0:
		blank_refine.append('')
		blank_rama.append('')
		blank_b.append('')
	a += 1

#Rfactor list
a = 0
b = len(cellA)
combi_rfactor = []
while a < b:
	if a == 0:
		combi_rfactor.append('Rwork / Rfree')
	if a >= 0:
		stringa = Rwork[a]
		stringa = str(stringa)	
		stringb = Rfree[a]
		stringb = str(stringb)
		string_add = stringa + ' / ' + stringb
		combi_rfactor.append(string_add)
	a += 1

#Make a list of total number of atoms
a = 0 
b = len(cellA)
combi_atom_no = []
combi_prot_no = []
combi_lig_no = []
combi_wat_no = []

while a < b:
	if a == 0:
		combi_atom_no.append('No. Atoms')
		combi_prot_no.append('Protein')
		combi_lig_no.append('Ligand / Ion')
		combi_wat_no.append('Water')
	if a >= 0:
		combi_atom_no.append('')
		combi_prot_no.append(protein_count_np[a])
		combi_lig_no.append(ligand_count_np[a])
		combi_wat_no.append(water_count_np[a])
	a += 1
#Make a combined list of Ramachandran status by number and percentage
a = 0 
b = len(cellA)
combi_rama_fav = []
combi_rama_allowed = []
combi_rama_out = []
while a < b:
	if a == 0:
		combi_rama_fav.append('Allowed')
		combi_rama_allowed.append('Generally Allowed')
		combi_rama_out.append('Disallowed')

	if a >= 0:
		fstring = str("%.2f" % np.around(rama_fav_np[a], decimals=2))
		fav_string = favored[a] + " (" + fstring + "%)"
		combi_rama_fav.append(fav_string)

		astring = str("%.2f" % np.around(rama_allowed_np[a], decimals=2))
		all_string = allowed[a] + " (" + astring + "%)"
		combi_rama_allowed.append(all_string)

		ostring = str("%.2f" % np.around(rama_out_np[a], decimals=2))		
		out_string = outlier[a] + " (" + ostring + "%)"
		combi_rama_out.append(out_string)
	a += 1

#Make lists for protein, ligand and water B-factors
a = 0 
b = len(cellA)
combi_prot_b = []
combi_lig_b  = []
combi_wat_b  = []
while a < b:
	if a == 0:
		combi_prot_b.append('Protein ()')
		combi_lig_b.append('Ligand / Ion ()')
		combi_wat_b.append('Water ()')
	if a >= 0:
		combi_prot_b.append(protein_average[a])
		combi_lig_b.append(ligand_average[a])
		combi_wat_b.append(water_average[a]) 
	a += 1
#Make list of bond and angle RMSDs
a = 0
b = len(cellA)
blank_RMSD  = []
combi_bond  = []
combi_angle_dev = []
while a < b:
	if a == 0:
		blank_RMSD.append('R.M.S. deviations')
		combi_bond.append('Bond lengths ()')
		combi_angle_dev.append('Bond angles ()')
	if a >= 0:
		blank_RMSD.append('')
		combi_bond.append(bond_deviation[a])
		string_angle = str("%.2f" % float(angle_deviation[a]))
		combi_angle_dev.append(string_angle) 
	a += 1

############## Pretty table ###############################

y = list()

xy = len(cellA)
a = 0

while a <= xy:
	if a == 0:
		string = ''
		y.append(string)
	if a > 0:
		string = 'sweep '
		string += str(a)
		y.append(string)
	a += 1

z = PrettyTable(y)
z.add_row(combi_dose)
z.add_row(combi_sg)
z.add_row(combi_cell)
z.add_row(combi_angle)
z.add_row(combi_beam)
z.add_row(combi_wave)
z.add_row(combi_reso)
z.add_row(combi_hireso)
z.add_row(combi_unique)
z.add_row(combi_multi)
z.add_row(combi_rpim)
z.add_row(combi_rmeas)
z.add_row(combi_cc)
z.add_row(combi_sig)
z.add_row(combi_comp)
z.add_row(combi_wilson)
z.add_row(blank)
z.add_row(blank_refine)
z.add_row(combi_rfactor)
z.add_row(combi_atom_no)
z.add_row(combi_prot_no)
z.add_row(combi_lig_no)
z.add_row(combi_wat_no)
z.add_row(blank_rama)
z.add_row(combi_rama_fav)
z.add_row(combi_rama_allowed)
z.add_row(combi_rama_out)
z.add_row(blank_b)
z.add_row(combi_prot_b)
z.add_row(combi_lig_b)
z.add_row(combi_wat_b)
z.add_row(blank)
z.add_row(blank_RMSD)
z.add_row(combi_bond)
z.add_row(combi_angle_dev)
#print(z.get_string(start=1, end=4))
print(z)

#Plot figures in matplotlib
plt.figure(1, figsize=(20, 6))
#plt.subplots_adjust(left=None, bottom=0.2, right=None, top=1.5, wspace=0.75, hspace=None)
plt.subplot(131)
x = list(range(1, (len(CC_half_high))+ 1))
x1 = x[::2]
y = list(CC_half_high)
# print(y)
plt.plot(x,y)
plt.ylim([0,1])
plt.xlabel(r'Dataset Number')
plt.ylabel(r'Outer Shell CC$_{\frac{1}{2}}$')
plt.xticks(x1)
plt.grid(which='major', axis='both', linestyle='-', linewidth=0.1)
plt.title(r'Outer Shell CC$_{\frac{1}{2}}$')

plt.subplot(132)
x = list(range(1, (len(CC_half_high))+ 1))
x1 = x[::2]
y = list(sigI_high)
y_floats = [float(i) for i in y]
ylim = math.ceil(max(y_floats))
plt.plot(x, y_floats)
plt.xticks(x1)
plt.ylim([0, ylim])
plt.title(r'Outer Shell I/$\sigma$(I)')
plt.xlabel(r'Dataset Number')
plt.ylabel(r'Outer Shell I/$\sigma$(I)')
plt.grid(which='major', axis='both', linestyle='-', linewidth=0.1)


# plt.subplot(133)
# x = list(range(1, (len(CC_half_high))+ 1))
# x1 = x[::2]
# y1 = list(Rwork)
# y2 = list(Rfree)
# print(y1)
# print(y2)
# y1_floats = [float(i) for i in y1]
# y2_floats = [float(i) for i in y2]
# ylim2 = int(math.ceil(max(y2_floats)))
# ylim1 = int(min(y1_floats))
# plt.plot(x,y1, label='Rwork')
# plt.plot(x,y2, label='Rfree')
# plt.xlabel(r'Dataset Number')
# plt.ylabel(r'R$_{work}$')
# plt.xticks(x1)
# plt.grid(which='major', axis='both', linestyle='-', linewidth=0.1)
# plt.title(r'R$_{work}$')
# plt.legend(loc='upper left');
# plt.ylim([ylim1,ylim2])
# #plt.gca().invert_yaxis()

plt.subplot(133)
x = list(range(1, (len(CC_half_high))+ 1))
x1 = x[::2]
y1 = list(Rwork)
y2 = list(Rfree)
# print(y1)
# print(y2)
y1_floats = [float(i) for i in y1]
y2_floats = [float(i) for i in y2]
ylim2 = int(math.ceil(max(y2_floats)))
ylim1 = int(min(y1_floats))
plt.plot(x,y1_floats, label=r'R$_{work}$')
plt.plot(x,y2_floats, label=r'R$_{free}$')
plt.xlabel(r'Dataset Number')
plt.ylabel(r'R$_{work}$ / R$_{free}$')
plt.xticks(x1)
plt.grid(which='major', axis='both', linestyle='-', linewidth=0.1)
plt.legend(loc='upper left');
plt.ylim([ylim1,ylim2])
plt.title(r'R$_{work}$ / R$_{free}$')

plt.show()








