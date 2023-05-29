function resultCellArray = concatenateCellArrays(cellArray1, cellArray2)
    % Check if the input arrays have the same size
    if ~isequal(size(cellArray1), size(cellArray2))
        error('Input arrays must have the same size.');
    end
    
    % Preallocate the result cell array
    resultCellArray = cell(size(cellArray1));

    % Perform concatenation
    for i = 1:size(cellArray1, 1)
        for j = 1:size(cellArray1, 2)
            resultCellArray{i, j} = [cellArray1{i, j}, '_', cellArray2{i, j}];
        end
    end
end
