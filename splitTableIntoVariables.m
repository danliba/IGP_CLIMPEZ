function splitTableIntoVariables(tableData)
    % Get the column names
    columnNames = tableData.Properties.VariableNames;

    % Split the table into variables
    for i = 1:numel(columnNames)
        varName = columnNames{i}(1:3);
        varData = tableData.(columnNames{i});
        assignin('base', varName, varData);
    end
end
