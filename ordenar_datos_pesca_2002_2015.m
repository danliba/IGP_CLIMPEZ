%cd D:\trabajo\IGP\CLIM_PEZ\Estadistica_Mensual_DIREPRO_2000_2020-20230310T225135Z-001\Estadistica_Mensual_DIREPRO_2000_2020\2000
%% hacemos el 2002
clear all; close all; clc;
%% 
yrst=2002; yren=2015;

iter0=0;
for iy=yrst:1:yren
iter0=iter0+1;
disp(iter0)
path01 = sprintf('D:\\trabajo\\IGP\\CLIM_PEZ\\Estadistica_Mensual_DIREPRO_2000_2020-20230310T225135Z-001\\Estadistica_Mensual_DIREPRO_2000_2020\\%d', iy);
%path01 = sprintf('D:\\trabajo\\IGP\\CLIM_PEZ\\pesca\\Estadistica_Mensual_DIREPRO_2000_2020\\%d', iy);

hdir=dir(fullfile(path01,'E*.xlsx'));

% If no XLSX files found, search for XLS files
if isempty(hdir)
    hdir = dir(fullfile(path01, 'E*.xls'));
end

if iy>2014
    hdir=dir(fullfile(path01,'C*.xlsx'));
end
%% 1er codigo del 2000 al 2014
% vamos a coger los puertos desde Requena hasta Bazan
%ifloat=1:1:size(hdir,1)
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
    %dt = datetime(mo, 'Locale', 'es_ES');

    %fecha=datenum(yr,month(mo),15);
    disp(datestr(datenumVal))
    
    %% we grab a matrix with all what we need
    patternSpec='IQUI.*';
    

   % Find indices that match the pattern
    [rowIndices, colIndices] = find(cellfun(@(x) ischar(x) && ~isempty(regexp(x, patternSpec, 'once')), raw));
    
    rowstart=rowIndices(1); colstart=colIndices(1)-1;
    % Display the indices
    new_array=raw(rowstart:end,colstart:end);
    
    %borramos los NaN
    rowNaN = find(~cellfun(@(x) any(isnan(x)), new_array(:,1)));

    new_array2=new_array(rowNaN,:);
    
    %ahora borramos los NaN en las columnas
    colNaN = find(~cellfun(@(x) any(isnan(x)), new_array2(1,:)));
    
    new_array3=new_array2(:,colNaN);
    
    %borrando los NaN que aun quedan
    %sumamos todos los no NaN en el array
    isNanArray = cellfun(@(x) all(~isnan(x(:))), new_array3);
    isNanSum=sum(isNanArray,2);
    
    %encontramos los rows con NaN > numero de puertos
    %numero de puertos
    n_puertos=length(new_array3(1,:))-2;
    
    %ahora encontramos la condicion NaN > numero de puertos
    indxnan=find(isNanSum>=n_puertos);
    
    %FINALMENTE borramos los NaN
    new_array4=new_array3(indxnan,:);

    %con el new array4 tenemos la data en bruto, ahora hay que limpiarla
     valuesToDelete = {'OTROS', 'ESPECIES', 'TOTAL','NOTA '};
    
    %nombre de los puertos
    puertos=new_array4(1,2:end);
    
    %nameSpecies=new_array4(:,1);
    % Find indices of cells to delete
    indicesToDelete = ismember(new_array4(:,1), valuesToDelete);
    
    % Delete cells from the original cell array
    new_array4(indicesToDelete,:) = [];
    
    %ahora cogemos las especies, ya limpias
    nameSpecies=new_array4(:,1);

    %Y los datos de la pesca
    datafished=new_array4(:,2:end);
    
    %verificamos el size de nuestros arrays:
    %puertos, nameSpecies, datafished

    %ahora guardamos
    species_t{:,ifloat}=nameSpecies;
    data_fish{:,ifloat}=datafished;
    puertos_t{:,ifloat}=puertos;
    tiempo_t{:,ifloat}=datenumVal;

    %hacemos tablas para verificar
    T=cell2table(datafished);
    T.Properties.VariableNames = puertos;
    T.Properties.RowNames = nameSpecies;

    %disp(T)   
    
end
    tiempo_y(:,iter0)=tiempo_t;
    species_y(:,iter0)=species_t;
    puertos_y(:,iter0)=puertos_t;
    datafish_y(:,iter0)=data_fish;

    
end
    %% otras soluciones
    tiempo_r=reshape(tiempo_y.', 1, []);
    species_r=reshape(species_y.', 1, []);
    puertos_r=reshape(puertos_y.', 1, []);
    datafish_r=reshape(datafish_y.', 1, []);

    %% ordenamos el tiempo
    % Sort the numeric array in ascending order
    dateNumbersNumeric = cell2mat(tiempo_r);

    [sortedDateNumbersNumeric, sortedIndices] = sort(dateNumbersNumeric);
    
    %datestr(sortedDateNumbersNumeric);
    % ahora vamos a ordernar los demas cells arrays de acuerdo al sort de
    % tiempo para ver si funciona
    sortedtiempo=tiempo_r(sortedIndices);
    % species_t
    sortedspecies = species_r(sortedIndices);
    % puertos_t
    sortedpuertos=puertos_r(sortedIndices);
    %data fished
    sorteddata_fish=datafish_r(sortedIndices);
    
    date=cellstr(datestr(cell2mat(sortedtiempo)))
save('TrueFishdatabase_2002_2015.mat','sortedtiempo','sortedspecies','sortedpuertos','sorteddata_fish');
%2002 is ok
%now 2016
