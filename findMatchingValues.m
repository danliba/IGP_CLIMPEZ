function [commonValues,ia,IndexVal] = findMatchingValues(cellArray)
    % Initialize the commonValues cell array to store the matching values
    commonValues = {};
    IndexVal = {};
    ia={};
    %cellArray=species_r;
    % Compare each cell array with the rest of the cell arrays
    for i = 1:numel(cellArray)
        currentArray = cellArray{i};
        remainingArrays = cellArray([1:i-1, i+1:end]);

        % Find the matching values between the current array and the remaining arrays
        commonValues{i} = currentArray;
        for j = 1:numel(remainingArrays)
            [commonValues{i},ia{i},IndexVal{i}] = intersect(commonValues{i}, remainingArrays{j}, 'stable');
        end
    end
end
