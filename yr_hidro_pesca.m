cd D:\trabajo\IGP\CLIM_PEZ\Estadistica_Mensual_DIREPRO_2000_2020-20230310T225135Z-001\Estadistica_Mensual_DIREPRO_2000_2020
%% Año hidrologico especies
clear all; close all; clc;

load('PESCA_AMAZONAS2.mat');
%% tiempo 

[yr,mo,da,hr]=datevec(double(tiempo));

%% %%PESCA
%finding the hidrological year
% hidrological year Aguas Altas defined as Abril-Mayo --> 2003 year
yrst=2003;
yren=2015;
most=9;
moen=8;
dast=1; daen=28;
jj=0;
    for iy=yrst:1:yren
        jj=jj+1;
        fechas=[datenum(iy-1,most,dast) datenum(iy,moen,daen)];

        indxtime=find(tiempo>=fechas(1)&tiempo<=fechas(2));
        cprintf('*black',['Procesando año ',num2str(iy),'\n'])
        disp(['Meses ',datestr(datenum(iy-1,most,dast)),' a ',...
            datestr(datenum(iy,moen,daen))])
        
        tabla=PESCA_AMAZONAS2(indxtime,:);
        % Assuming you have a table named 'myTable'
        %temparray=cell2mat(tabla{:,:});
        rowSums = nansum(cell2mat(tabla{:,:}), 1);
        rowMean = nanmean(cell2mat(tabla{:,:}),1);
        rowSTD = ;
        
        catedsum(jj,:)=rowSums;
        catedmean(jj,:)=rowMean;
        years(jj,1)=iy;
    end

%% create the yr table


