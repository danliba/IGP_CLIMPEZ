    %% Ahora que tenemos la base de datos vamos a hacer los match y missmatch 
    % todo esta ordenado por tiempo, ahora vamos a hacer el match %no need Dimensions
    clear all; close all; clc;

    %load('Fishdatabase_2003_2015.mat')
    load('TrueFishdatabase_2003_2015.mat')

    species_r=sortedspecies;
    puertos_r=sortedpuertos;
    datafish_r=sorteddata_fish;

    %% Matching 
    % Example cell array with 12 cells of varying sizes, containing character values
    [commonSpecies,~,~] = findMatchingValues(species_r);
    
    [commonPorts,~,~] = findMatchingValues(puertos_r);

    %especies_elegidas=species_r{1}(IndexSpecies{1, 1});

    % ya encontramos los patrones ahora encontremos los indices
    PatronSpecies=commonSpecies{1,1};
    PatronSpecies{21} ='PAICHE';

    PatronPuertos=commonPorts{1,1};

    % ahora let's match y encontrar el index

    % Find the indexes that match the pattern within the larger array
    for ii=1:1:length(species_r)
        IndexSpecies = find(ismember(species_r{ii}, PatronSpecies));
        IndexPort = find(ismember(puertos_r{ii}, PatronPuertos));
        fish_data{ii} = datafish_r{ii}(IndexSpecies,IndexPort);
    end

    %expand the array para que todos tengan el mismo tamaño
    fish_array = expandAndFillNaN(fish_data);
    %% now extract the data fish_data
    % vamos a coger el primer valor de todas las celdas que corresponde a 
    % Iquitos - Acarahuazu
    PatronSpecies{9}='CHIO_CHIO';
    PatronSpecies{20}='PANA';
    %PatronSpecies{21} ='PAICHE';

    PatronPuertos{2}='YURIMAG';
    %creamos una matriz de nombres para que encajen con la data
    D1_species = repmat(PatronSpecies, 1, length(PatronPuertos));

    % %puertos
    D2_puertos=repmat(PatronPuertos,length(PatronSpecies),1);
    
    %combinamos los nombres
    % Preallocate the result cell array
    result = concatenateCellArrays(D2_puertos, D1_species);

    %% crear una variable por cada cell array Puerto-Specie
for icol=1:1:length(PatronPuertos)

   for k=1:1:length(PatronSpecies) %row
    for  i = 1:numel(fish_array)
        data_cat=fish_array{i}{k,icol};
        fish_values{i,1} = data_cat;

        %data_2=cell2mat(data_cat);
        my_field=char(result{k,icol});
        %nombre=char(puertos(ii));
        %disp([nombre,' ', char(especies{k})])
        P.(my_field)= fish_values;
    end
   end
end

%% nos Falta el Paiche

%% struct to table
tiempo=cell2mat(sortedtiempo)';

myTable = struct2table(P);
date=cellstr(datestr(tiempo));
myTable.Properties.RowNames = date;
% table time
%myTable = addvars(myTable, tiempo, 'Tiempo');

%% ploteamos
% Specify the folder path
folderPath = 'D:\trabajo\IGP\CLIM_PEZ\Estadistica_Mensual_DIREPRO_2000_2020-20230310T225135Z-001\Estadistica_Mensual_DIREPRO_2000_2020/figures';

% Save the figure to the specified folder
%saveas(gcf, fullfile(folderPath, fileName));
% Get the variable names (column names) of the table
varNames = myTable.Properties.VariableNames;

figure
P=get(gcf,'position');
P(3)=P(3)*3;
P(4)=P(4)*1.2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');
% Iterate over the columns and create a separate plot for each column
for col = 1:numel(varNames)
    % Get the data for the current column
    data = myTable.(varNames{col});
    
    % Create a new figure and plot the data
  
    plot(tiempo,cell2mat(data),'o--');
    datetick('x')
    grid on
    %hold on
    % Set title and labels
    title(varNames{col});
    xlabel('Tiempo');
    ylabel('T.M:B');
    legend(varNames{col})
    % Add any other customization as needed
    
    % Pause to allow time for each plot to be viewed
    pause(0.5);
    % Specify the file name and extension
    fileName = char(varNames{col});
    print(fullfile(folderPath, fileName), '-dpng', '-r500');
end

%% separamos los totales y los ponemos en otra tabla
% Get the column names of the table
columnNames = myTable.Properties.VariableNames;

% Find the indices of columns with names matching the pattern 'TOTAL.*'
pattern = {'TOTAL.*'};
matchingIndices = regexpi(columnNames, pattern);

% Convert the cell array of indices to a logical array
matchingIndices = ~cellfun(@isempty, matchingIndices);

% Retrieve the column indices of matching columns
columnIndices = find(matchingIndices);

%tabla de totales_PESCA TOTAL por ESPECIE
PESCA_TOTAL = myTable(:, columnIndices);

%ahora el array de pesca sin totales
nonMatchingIndices = find(matchingIndices==0);

% Retrieve the column indices of non-matching columns
PESCA_TMB=myTable(:, nonMatchingIndices);

%% vamos a seleccionar la data que nos interesa
%primero encontramos los 0 en la tabla 

% Find zero values in the table
numericArray = table2array(PESCA_TMB);
%numericArray=cell2mat(numericArray);

% Find zero values in the numeric array
zeroValues = cellfun(@(x) isnumeric(x) && x == 0, numericArray);

% Count the number of zero values in each column
columnCounts = sum(zeroValues);

%encuentra las columnas con 0
indx0=find(columnCounts<=size(zeroValues,1)-10); %12 meses

%extract desired data
extractedTable = PESCA_TMB(:, indx0);

%encuentra puertos sin missing data
indx1=find(columnCounts==0); %0 meses

%no missing data Tables
CompleteTable = PESCA_TMB(:, indx1);

%% less missing data table maximun 2 años de missing data--> 24 datos
indx2=find(columnCounts<=24); %24 meses
FishTable = PESCA_TMB(:, indx2);

%Ahora separamos solo los puertos que nos interesan
PORTSpattern={'IQUITOS_*','NAUTA_*','REQUENA_*','YURIMAG_*'};

% Get the column names of the table
for ij=1:1:length(PORTSpattern)
    columnNamesPorts = FishTable.Properties.VariableNames;
    
    % Initialize the variable to store the matching column indices
    matchingIndices0 = regexpi(columnNamesPorts, PORTSpattern{ij});
    
    % Convert the cell array of indices to a logical array
    matchingIndices0 = ~cellfun(@isempty, matchingIndices0);
    
    % Retrieve the column indices of matching columns
    columnIndices0 = find(matchingIndices0);
    indx_PORTS{ij}=columnIndices0;
end

combinedData = [indx_PORTS{:}];

%% extraemos solo los puertos que nos interesan
PESCA_AMAZONAS = FishTable(:, combinedData);

save('PESCA_AMAZONAS.mat',"PESCA_AMAZONAS");
%% 
% Specify the filename
filename = 'PESCA_AMAZONAS.xlsx';

% Export the table to the file
writetable(PESCA_AMAZONAS, filename);

%% %% ploteamos
% Specify the folder path
folderPath = 'D:\trabajo\IGP\CLIM_PEZ\Estadistica_Mensual_DIREPRO_2000_2020-20230310T225135Z-001\Estadistica_Mensual_DIREPRO_2000_2020/Amazonas_fig';
mkdir Amazonas_fig
% Save the figure to the specified folder
%saveas(gcf, fullfile(folderPath, fileName));
% Get the variable names (column names) of the table
varNames = PESCA_AMAZONAS.Properties.VariableNames;

figure
P=get(gcf,'position');
P(3)=P(3)*3;
P(4)=P(4)*1.2;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');
% Iterate over the columns and create a separate plot for each column
for col = 1:numel(varNames)
    % Get the data for the current column
    data = PESCA_AMAZONAS.(varNames{col});
    
    % Create a new figure and plot the data
  
    plot(tiempo,cell2mat(data),'o--');
    datetick('x')
    grid on
    %hold on
    % Set title and labels
    title(varNames{col});
    xlabel('Tiempo');
    ylabel('T.M:B');
    legend(varNames{col})
    % Add any other customization as needed
    
    % Pause to allow time for each plot to be viewed
    pause(0.5);
    % Specify the file name and extension
    fileName = char(varNames{col});
    print(fullfile(folderPath, fileName), '-dpng', '-r500');
end



