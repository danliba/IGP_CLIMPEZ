%% vamos a calcular el año hidrologico de las regiones de Temperatura extraidas en MUR 
clear all; close all; clc;
load('MUR_3_amazonas.mat');
%%
[yr,mo,da,hr,min,sec]=datevec(time2);
time2=datenum(yr,mo,da,hr,min,sec);

%% %% creamos el promedio anual hidrologico
% año va del 09/yr al 08/yr+1
%el año empieza en 1984/09 al 1985/08 --> 1984
%1985/09 al 1986/08 --> 1985

%puertos=[j(1,2:end)];
yrst=yr(1);
yren=yr(end);
jj=0;
    for iy=yrst:1:yren
        jj=jj+1;
        fechas=[datenum(iy,09,01) datenum(iy+1,08,01)];

        indxtime=find(time2>=fechas(1)&time2<=fechas(2));
        disp(['Procesando año ',num2str(yr(indxtime(1)))])
        
        region1_SST(jj,:)=nanmean(sst_MUR_reg1(indxtime));
        region2_SST(jj,:)=nanmean(sst_MUR_reg2(indxtime));
        region3_SST(jj,:)=nanmean(sst_MUR_reg3(indxtime));
        years(jj,1)=iy;
    end

%%
plot(years,region1_SST,'x--'); grid minor;
hold on
plot(years,region2_SST,'o:'); %grid minor;
hold on
plot(years,region3_SST,'d--'); %grid minor;
title('AÑO Hidrologico MUR Temperatura agua');

legend('Region 1','Region 2','Region 3');
%% save at variables_ordenadas
%save('MUR_SST_newloc.mat','lat','lon','sst','time', '-v7.3')
save('MUR_sst_hidrological_yr.mat','years','region1_SST','region2_SST',...
    'region3_SST');