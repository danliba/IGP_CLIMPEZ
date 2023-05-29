function indices = findStringCells(cellArray, targetString)
    indices = find(strcmp(cellArray, targetString));
end