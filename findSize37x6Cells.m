function indexes = findSize37x6Cells(cellArray,rows,cols)
desired_size=[rows,cols];
    % Initialize an empty array to store the indexes
    indexes = [];

    % Iterate through each cell in the cell array
    for i = 1:numel(cellArray)
        % Check the size of the current cell
        if size(cellArray{i}, 1) == double(desired_size(1)) && size(cellArray{i}, 2) == double(desired_size(2))
            % If the size matches, add the index to the 'indexes' array
            indexes = [indexes, i];
        end
    end
end
