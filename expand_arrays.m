originalSize = size(fish_data{1});

% Determine the number of rows to add
numRowsToAdd = 1;

% Create a NaN-filled row to add
nanRow = NaN(1, originalSize(2));

% Expand the first cell array and fill with NaN values
expandedArray = padarray(cell2mat(fish_data{1}), numRowsToAdd, NaN, 'post');

% Replace the first cell in the cell array with the expanded array
cellArray{1} = expandedArray;

% Display the modified cell array
disp(cellArray);