function [valuesAbove,otrosIndex] = extractValuesAboveOthers(cellArray,INPUT)
    % Find the index of the cell named "Otros"
    
    otrosIndex = find(strcmp(cellArray, INPUT));

    % Extract the values above "Otros"
    valuesAbove = cellArray(1:otrosIndex-1);
end