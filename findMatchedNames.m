function matchedNames = findMatchedNames(cellArray, pattern)
%pattern has to be a string
    % Initialize an empty cell array to store the matched names
    matchedNames = {};

    % Iterate over each cell name and check if it matches the pattern
    for i = 1:numel(cellArray)
        name = cellArray{i};
        if ~isempty(regexp(name, pattern, 'once'))
            matchedNames{end+1} = name;
        end
    end
end