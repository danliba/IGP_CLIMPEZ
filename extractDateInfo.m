function [mo, yr, datenumVal, dateStr] = extractDateInfo(cellData)
    % Extract the month and year from the cell
    % try
    % % Try splitting the cellData string using the original delimiters
    % splitData = strsplit(cellData, {' : ', ' - '});
    % catch
    % % If the original split fails, use alternative delimiters and trim leading/trailing spaces
    % splitData = strsplit(cellData, {':', '-'});
    % splitData = strtrim(splitData);
    % end
    % %splitData = strsplit(cellData, {'   :   ', ' - '});
    % mo = splitData{2};
    % yr = splitData{3};
    % 
    % % Remove leading/trailing whitespaces from month and year
    % mo = strtrim(mo);
    % yr= strtrim(yr);

    patterns = {'PERIODO\s*:\s*(\w+)\s*-\s*(\d+)', 'PERIODO\s*:\s*(\w+)\s*-\s*(\d+)', 'PERIODO\s*:\s*(\w+)\s+(\d+)'};

    matched = false;
    for i = 1:numel(patterns)
        match = regexp(cellData, patterns{i}, 'tokens');
        if ~isempty(match)
            mo = strtrim(match{1}{1});
            yr = strtrim(match{1}{2});
            matched = true;
            break;
        end
    end
    
    if ~matched
        error('Invalid date format');
    end

    monumber=double(month(mo,'mmmm'));
    yrnumber=double(year(yr,'yyyy'));
    % Create a datenumber using the extracted month and year
    dateStr = sprintf('%02d-%d-%04d', 1, monumber, yrnumber);
    datenumVal = datenum(yrnumber, monumber, 1);
    % Create a date vector using the datenumber
    dateVec = datevec(datenumVal);
end
