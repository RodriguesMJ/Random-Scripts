%MATLAB script to import all UV-Vis spectra in a directory from the Shimadzu
%spectrophotometer into a single labelled cell array.

dir_to_search = '\example\directory';

txtpattern = fullfile(dir_to_search, '*.txt');

dinfo = dir(txtpattern);

for K = 1 : length(dinfo)
  thisfilename = fullfile(dir_to_search, dinfo(K).name);  %just the name
  thisdata = dlmread(thisfilename, ',', 2, 0); %load just this file
  %fprintf( 'File #%d, "%s", maximum value was: %g\n', K, thisfilename, max(thisdata(:)) );   %do something with the data
  YourString=thisfilename;
  lastdot_pos = find(YourString == '\', 1, 'last');
  part12 = YourString(1 : lastdot_pos );
  a = extractAfter(YourString, part12);
  a = extractBefore(a, '.txt');
  %fprintf( a )
  M{K,1} = thisdata;
  M{K,2} = a;
end

%clean up
clearvars thisdata YourString lastdot_pos  part12 a dinfo dir_to_search K thisfilename txtpattern;  
