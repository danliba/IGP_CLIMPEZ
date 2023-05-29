function repeatedIndices = findRepeatedIndices(species_t)
    % Initialize an empty cell array to store the repeated indices
    repeatedIndices = {};

    % Iterate over each pair of cell arrays
    for i = 1:numel(species_t)-1
        for j = i+1:numel(species_t)
            % Get the current pair of cell arrays
            cellArray1 = species_t{i};
            cellArray2 = species_t{j};

            % Compare the values and find the indices where they are similar
            isRepeated = ismember(cellArray1, cellArray2);

            % Store the indices of the similar values
            repeatedIndices{end+1} = find(isRepeated);
        end
    end
end
%You can use this function by passing your species_t cell array as an argument. The function will return the indices of the similar values in each pair of cell arrays as a cell array repeatedIndices, where repeatedIndices{i,j} represents the indices of the similar values between species_t{1,i} and species_t{1,j}.






