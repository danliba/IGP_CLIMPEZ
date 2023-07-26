%% crearemos climatologias de la pesca 
clear all; close all; clc;
cd D:\trabajo\IGP\CLIM_PEZ\Variables_ordenadas\mensual
%% 

fn1='Base_de_Datos.xlsx';
[status,sheets] = xlsfinfo(fn1);

[numData, textData, raw] = xlsread(fn1, char(sheets(4)));
%% 
time=numData(:,1)+693960;
[yr,mo,da,hr,min,sec]=datevec(time);
time=datenum(yr,mo,da,hr,min,sec);

numData(numData==0)=NaN;
%% climato
%2002/Setiembre a 2015/Agosto

meses={'Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Set','Oct','Nov','Dic'};
most=1; moen=12;

for ii=most:1:moen
    indxclim=find(mo==ii);
    data_clim(ii,:)=nanmean(numData(indxclim,2:end),1);
end

T_pescaclim=array2table(data_clim);
columnNames=textData(1,2:end);
T_pescaclim.Properties.VariableNames=columnNames;
T_pescaclim.Properties.RowNames=cellstr(string(meses));
%%
% Preallocate arrays to store maximum values and indices
maxValues = zeros(1, size(data_clim, 2));
maxIndices = zeros(1, size(data_clim, 2));

% Iterate over each column
for col = 1:size(data_clim, 2)
    % Find the maximum value and its index in the column
    [maxValue, maxIndex] = max(data_clim(:, col));
    
    % Store the maximum value and index in the respective arrays
    maxValues(col) = maxValue;
    maxIndices(col) = maxIndex;
end

% Display the maximum values and indices
disp("Maximum values:");
disp(maxValues);
disp("Indices of maximum values:");
disp(maxIndices);
%%
for i=1:1:15
    max_mes(i)=meses(maxIndices(i));
end
%%
%bar(T_pescaclim.IQUITOS_BOQUICHICO)

my_file=['Climato_pesca3.xlsx'];
writetable(T_pescaclim,my_file,'Sheet',1);
%% ahora correr todo pero eliminando y cambiando los 0s por NAN
bar(T_pescaclim.IQUITOS_BOQUICHICO)
