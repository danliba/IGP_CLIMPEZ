%% crearemos climatologias de las variables fisicas
clear all; close all; clc;
cd D:\trabajo\IGP\CLIM_PEZ\Variables_ordenadas\mensual
%% 

fn1='Base_de_Datos.xlsx';
[status,sheets] = xlsfinfo(fn1);

[numData, textData, raw] = xlsread(fn1, char(sheets(5))); %caudal
%% 
time=numData(:,1)+693960;
[yr,mo,da,hr,min,sec]=datevec(time);
time=datenum(yr,mo,da,hr,min,sec);

%% climato
%2002/Setiembre a 2015/Agosto
meses={'Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Set','Oct','Nov','Dic'};
most=1; moen=12;

for ii=most:1:moen
    indxclim=find(mo==ii);
    data_clim(ii,:)=nanmean(numData(indxclim,2:end),1);
    disp(['Climatologia Mes ', num2str(ii)])
end

T_clim=array2table(data_clim);
columnNames=textData(1,2:end);
T_clim.Properties.VariableNames=columnNames;
T_clim.Properties.RowNames=cellstr(string(meses));

%% 
my_file=['Climato_fis.xlsx'];
writetable(T_clim,my_file,'Sheet',1);