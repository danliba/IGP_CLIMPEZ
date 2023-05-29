function matchedIndex = findPatternIndex(cellArray, patternSpec)
    matchedIndex = [];
    for i = 1:numel(cellArray)
        if ~isempty(regexp(cellArray{i}, patternSpec, 'once'))
            matchedIndex = [matchedIndex, i];
        end
    end
end
%%finds the indx of any cell