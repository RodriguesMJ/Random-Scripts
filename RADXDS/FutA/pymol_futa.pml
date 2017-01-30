#PyMol script that will load the refined structure and all of the Fon-Fo1 difference maps so that the differences can be plotted
#with changes in electron density plotted in absolute values as has been done for I320.

#Map 1 has a sigma of 0.030931 and a mean of 0.000
#All maps will therefore be contoured at 0.092793 and -0.092793 

#Ammendment to the sigma above, the maps blow up at that contour
#level past wedge 20. Instead we'll take the 3 sigma value of the 
#last map, which is 0.139995

set normalize_ccp4_maps, off

load /Users/matt/Dropbox/FutA_Damage/Matt_FutA_I2/CCP4_IMPORTED_FILES/FutA_001_1.pdb

set_name FutA_001_1, futa

hide lines 
hide nonbonded

show cartoon
set cartoon_color, white
bg_color white
set cartoon_transparency, 0.8

show sp, resi 1 and chain H 
set sphere_scale, 0.45
select TYRS, resi 200+199+13+143
show st, TYRS
hide st, name c+o+n
color cyan, TYRS
color red, TYRS and name OH

select site, chain h+s and resi 200+199+13+143+1

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_001.png


load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_002.map.ccp4
isomesh negmap, cad_fon_fo1_002.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_002.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_002.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_003.map.ccp4
isomesh negmap, cad_fon_fo1_003.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_003.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_003.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_004.map.ccp4
isomesh negmap, cad_fon_fo1_004.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_004.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_004.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_005.map.ccp4
isomesh negmap, cad_fon_fo1_005.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_005.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_005.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_006.map.ccp4
isomesh negmap, cad_fon_fo1_006.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_006.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_006.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_007.map.ccp4
isomesh negmap, cad_fon_fo1_007.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_007.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_007.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_008.map.ccp4
isomesh negmap, cad_fon_fo1_008.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_008.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_008.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_009.map.ccp4
isomesh negmap, cad_fon_fo1_009.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_009.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_009.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_010.map.ccp4
isomesh negmap, cad_fon_fo1_010.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_010.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_010.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_011.map.ccp4
isomesh negmap, cad_fon_fo1_011.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_011.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_011.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_012.map.ccp4
isomesh negmap, cad_fon_fo1_012.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_012.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_012.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_013.map.ccp4
isomesh negmap, cad_fon_fo1_013.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_013.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_013.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_014.map.ccp4
isomesh negmap, cad_fon_fo1_014.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_014.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_014.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_015.map.ccp4
isomesh negmap, cad_fon_fo1_015.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_015.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_015.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_016.map.ccp4
isomesh negmap, cad_fon_fo1_016.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_016.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_016.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_017.map.ccp4
isomesh negmap, cad_fon_fo1_017.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_017.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_017.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_018.map.ccp4
isomesh negmap, cad_fon_fo1_018.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_018.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_018.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_019.map.ccp4
isomesh negmap, cad_fon_fo1_019.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_019.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_019.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_020.map.ccp4
isomesh negmap, cad_fon_fo1_020.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_020.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_020.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_021.map.ccp4
isomesh negmap, cad_fon_fo1_021.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_021.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_021.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_022.map.ccp4
isomesh negmap, cad_fon_fo1_022.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_022.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_022.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_023.map.ccp4
isomesh negmap, cad_fon_fo1_023.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_023.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_023.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_024.map.ccp4
isomesh negmap, cad_fon_fo1_024.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_024.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_024.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_025.map.ccp4
isomesh negmap, cad_fon_fo1_025.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_025.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_025.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_026.map.ccp4
isomesh negmap, cad_fon_fo1_026.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_026.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_026.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_027.map.ccp4
isomesh negmap, cad_fon_fo1_027.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_027.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_027.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_028.map.ccp4
isomesh negmap, cad_fon_fo1_028.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_028.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_028.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_029.map.ccp4
isomesh negmap, cad_fon_fo1_029.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_029.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_029.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_030.map.ccp4
isomesh negmap, cad_fon_fo1_030.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_030.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_030.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_031.map.ccp4
isomesh negmap, cad_fon_fo1_031.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_031.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_031.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_032.map.ccp4
isomesh negmap, cad_fon_fo1_032.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_032.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_032.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_033.map.ccp4
isomesh negmap, cad_fon_fo1_033.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_033.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_033.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_034.map.ccp4
isomesh negmap, cad_fon_fo1_034.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_034.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_034.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_035.map.ccp4
isomesh negmap, cad_fon_fo1_035.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_035.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_035.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_036.map.ccp4
isomesh negmap, cad_fon_fo1_036.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_036.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_036.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_037.map.ccp4
isomesh negmap, cad_fon_fo1_037.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_037.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_037.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_038.map.ccp4
isomesh negmap, cad_fon_fo1_038.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_038.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_038.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_039.map.ccp4
isomesh negmap, cad_fon_fo1_039.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_039.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_039.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_040.map.ccp4
isomesh negmap, cad_fon_fo1_040.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_040.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_040.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_041.map.ccp4
isomesh negmap, cad_fon_fo1_041.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_041.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_041.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_042.map.ccp4
isomesh negmap, cad_fon_fo1_042.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_042.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_042.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_043.map.ccp4
isomesh negmap, cad_fon_fo1_043.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_043.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_043.png

load /Volumes/TewsBackupDisk4/Moritz/process_160831/fft/cad_fon_fo1_044.map.ccp4
isomesh negmap, cad_fon_fo1_044.map, 0.139995, site, carve=3.0
isomesh posmap, cad_fon_fo1_044.map, -0.139995, site, carve=3.0  
color red, negmap
color green, posmap

set_view (\
     0.457009822,    0.540623546,    0.706307352,\
    -0.042266227,    0.806385875,   -0.589877129,\
    -0.888454974,    0.239726797,    0.391377777,\
     0.000000000,    0.000000000,  -33.986755371,\
    -3.188999891,   -3.917999983,   13.864999771,\
    -0.994595051,   68.968132019,  -20.000000000 )

ray 300, 300
png ./img/FutA_001_044.png
