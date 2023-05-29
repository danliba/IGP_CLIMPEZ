function cellArray = expandAndFillNaN(cellArray,indxcell)
    % Get the size of the first cell array
    originalSize = size(cellArray{double(indxcell)});

    % Determine the number of rows to add
    numRowsToAdd = 1;

    % Create a NaN-filled row to add
    nanRow = NaN(1, originalSize(2));

    % Expand the first cell array and fill with NaN values
    expandedArray = padarray(cell2mat(cellArray{double(indxcell)}), numRowsToAdd, NaN, 'post');

    % Replace the first cell in the cell array with the expanded array
    cellArray{double(indxcell)} = num2cell(expandedArray);
end

