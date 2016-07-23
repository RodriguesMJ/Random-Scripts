%This script will import all UV-Vis spectra with the Master.Absorbance 
%extension and load them into a 3-D array called Spectra.

%Created by Matt Rodrigues 01/12/2014




%Tell the script which folder to look for the spectra in
myFolder = '/Users/matt/Dropbox/Pdx1project/PhD/Spectroscopy/ESRFSpec/mx1733/Moritz/Matt/Glyercol_40_R3/';


%Error message will show if the myFolder directory cannot be found
if ~isdir(myFolder);
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end

%Reads the pattern for the files with .Master.Absorbance extension
filepattern = fullfile(myFolder, 'Glyercol_40_R3*.txt');
specfiles = dir(filepattern);

for k = 1:length(specfiles);
    baseFilename = specfiles(k).name;
    fullFilename = fullfile(myFolder, baseFilename);
    fprintf (1, 'Now reading %s\n', fullFilename);

    
   %Import data from text file
   delimiter = '\t';
   startRow = 20;
   formatSpec = '%s%s%[^\n\r]';
   fileID = fopen(fullFilename,'r');
   dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false); 
   fclose(fileID);
        %% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end
%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
 
Glyercol_40_R3(:,:,k)= cell2mat(raw);

%% Clear temporary variables
clearvars i k filename delimiter startRow formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me R;
end
