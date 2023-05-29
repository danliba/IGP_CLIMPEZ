%cd D:\trabajo\IGP\CLIM_PEZ\Estadistica_Mensual_DIREPRO_2000_2020-20230310T225135Z-001\Estadistica_Mensual_DIREPRO_2000_2020\2000
%% 
clear all; close all; clc;
yrst=2003; yren=2003;

for iy=yrst:1:yren
path01 = sprintf('D:\\trabajo\\IGP\\CLIM_PEZ\\Estadistica_Mensual_DIREPRO_2000_2020-20230310T225135Z-001\\Estadistica_Mensual_DIREPRO_2000_2020\\%d', iy);
%path01 = sprintf('D:\\trabajo\\IGP\\CLIM_PEZ\\pesca\\Estadistica_Mensual_DIREPRO_2000_2020\\%d', iy);
hdir=dir(fullfile(path01,'E*.xlsx'));

if iy>2014
    hdir=dir(fullfile(path01,'C*.xlsx'));
end
%% 1er codigo del 2000 al 2014
% vamos a coger los puertos desde Requena hasta Bazan

for ifloat=1:1:size(hdir,1)
    fname=hdir(ifloat).name;
    disp(fname)

    [status,sheets] = xlsfinfo(fname);

    % Regular expression pattern
    pattern = 'EXTR.*1';
    %pattern= 'F*';
    % Initialize an empty cell array to store the matched names
    matchedNames = {};

    % Iterate over each cell name and check if it matches the pattern
    for i = 1:numel(sheets)
        name = sheets{i};
        if ~isempty(regexp(name, pattern, 'once'))
            matchedNames{end+1} = name;
        end
    end
    % Display the matched names
    sel_sheet=strjoin(matchedNames);
    disp(sel_sheet);

    %read the excel values 
    [numData, textData, raw] = xlsread(fname, sel_sheet);
    
    %% now we play with raw to get the time

    raw1=textData(:,1);
    patternTime='PERI*';
    
    matchedDate = findMatchedNames(raw1, patternTime);
    disp(matchedDate(1))
    cellData=char(matchedDate(1));

    [mo, yr, datenumVal, dateStr] = extractDateInfo(cellData);
    disp(mo);
    disp(yr);
    disp(datestr(datenumVal));

    %% now we get the species
    patternSpec='ESPE*';
    
    raw2=textData(:,1);
    matchedIndices = findPatternIndex(raw2, patternSpec);
    
    for ii=1:1:length(matchedIndices)
        puertos=textData(matchedIndices(ii),:);
        isNanArray = cellfun(@(x) all(isnan(x(:))), puertos);
        isNanSum(ii)=sum(isNanArray);
    end
    
    [~, indexmin] = min(isNanSum);
    disp(indexmin); 
    
    if indexmin<2

    raw2=textData(:,2);
    matchedIndices = findPatternIndex(raw2, patternSpec);
    
    for ii=1:1:length(matchedIndices)
        puertos=textData(matchedIndices(ii),:);
        isNanArray = cellfun(@(x) all(isnan(x(:))), puertos);
        isNanSum(ii)=sum(isNanArray);
    end
    
    [~, indexmin] = min(isNanSum);
    puertos_sel=textData(matchedIndices(indexmin),:);
    else
        puertos_sel=textData(matchedIndices(indexmin),:);
    end
    
    disp(puertos_sel);
    clear isNanSum isNanArray indexmin

    %% ahora vamos a coger los puertos
    % 

    % Find the index of the cell named "IQUITOS"
    index_cell = find(strcmp(puertos_sel, 'IQUITOS'));
    
    % Extract the cells to the right of "IQUITOS"
    extractedCells = raw(:,index_cell:end);
       
    % now lets see how many NaNs we have 
    isNanArray2 = cellfun(@(x) all(isnan(x(:))), extractedCells);
    isNanSum2=sum(isNanArray2,2);
    
    % lets erase the NaN
    indxData=find(isNanSum2<max(max(isNanSum2))-2);
    
    %clear isNanSum isNanArray indexmin
    %now we extract the data without NaN   
    extractedData=extractedCells(indxData,:);

    % Extract now the species names
    nameSpecies = raw2(indxData,:);
    
    %lets erase the NaNs of the columns of extracted Data
    isNanArray3 = cellfun(@(x) all(isnan(x(:))), extractedData);
    isNanSum3=sum(isNanArray3,1);
    
    % lets erase the NaN
    indxCol=find(isNanSum3<2);

    % now we drop the cols with NaN
    cleanData=extractedData(:,indxCol);
    
    %clear isNanSum isNanArray indexmin
    %% now we will order our matrix
    %we can create a repeated matrix of nameSpecies
    % % Find the index of 'Species'
    % indexremove = find(strcmp(nameSpecies, 'ESPECIES'));
    varNames=cleanData(1,:);
    % % Remove the cell from the cell array
     %now lets identify the string data
    targetString = 'IQUITOS';
    indices = findStringCells(cleanData, targetString);
    disp(indices)
    cleanData(indices,:)=[];
    
    % patternDel = 'EXTRACCION*';
    % matchedNamesdel = findMatchedNames(nameSpecies,patternDel);
    
    % si no hay extraccion para borrar , continua
    % if ~isempty(matchedNamesdel)
    % indi = findStringCells(nameSpecies, matchedNamesdel);
    % nameSpecies(indi,:)=[];
    % else
    %     disp('Seguimos')
    %     continue
    %     %disp('Seguimos')
    % end
    %disp('NOT SKIPPED')
    %%
    valuesToDelete = {'OTROS', 'ESPECIES', 'TOTAL','NOTA '};

    % Find indices of cells to delete
    indicesToDelete = ismember(nameSpecies, valuesToDelete);
    
    % Delete cells from the original cell array
    nameSpecies(indicesToDelete) = [];
    
    % Verify the updated cell array
    disp(nameSpecies);
    %% values above OTROS
    % [valuesAbove,otrosIndex] = extractValuesAboveOthers(nameSpecies,'ZUNGARO');
    % disp(otrosIndex)
    
    %% 
    %nameSpecies=nameSpecies(1:otrosIndex,:);
    cleanData=cleanData(1:otrosIndex,:); % aqui el problema con otrosIndex
    disp(nameSpecies);
    %hasta aqui todo cuadra
    % ahora vamos a crear la tabla
    % crear variables por cada puerto y agregar el tiempo
    % corre muy bien para el 2003
    %% table

    T=cell2table(cleanData);
    T.Properties.VariableNames = varNames;
    T.Properties.RowNames = nameSpecies;

    % Split the table into variables
    columnNames = T.Properties.VariableNames;
    
    % Create the table with row names
    species_t{:,ifloat}=nameSpecies;
    disp(species_t{ifloat})
    data_cleaned{:,ifloat}=cleanData;


end
    
end

%%  usar una misma matriz, ordenarla y trabajar con ella
% no usar mas matrices porque es confuso

