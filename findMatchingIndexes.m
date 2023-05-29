function matchingIndexes = findMatchingValuesIndex(cellArray)
    % Initialize the matchingIndexes cell array to store the indexes of matching values
    matchingIndexes = cell(size(cellArray));

    % Iterate through each cell array
    for i = 1:numel(cellArray)
        currentArray = cellArray{i};

        % Compare the current array with the rest of the cell arrays
        for j = 1:numel(cellArray)
            if j ~= i
                compareArray = cellArray{j};

                % Find the matching values and their indexes
                [~, ~, matchingIdx] = intersect(currentArray, compareArray, 'stable');

                % Store the indexes of matching values
                matchingIndexes{i}{j} = matchingIdx;
            end
        end
    end
end
