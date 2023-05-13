clear all; close all; clc
%%  Vamos a calcular los periodos de aguas altas y aguas bajas
%Caso 1: Aguas Altas: Marzo-Abril-Mayo
%Aguas Bajas: Agosto-Setiembre-Octubre
% ya se hizo en excel
cd D:\trabajo\IGP\CLIM_PEZ\avances_semanales\sensibilidad_clusters
%% Caso 2: 
%Aguas Altas: Abril-Mayo
%Aguas Bajas: Agosto-Setiembre
%% leemos datos de caudal
fncaudal='promedios_caudales_correcto_requena_yurimaguas.xlsx';

[status,sheets] = xlsfinfo(fncaudal);
%Para esto calculamos el año hidrologico de caudales y sedimentos
[data,raw,j]=xlsread(fncaudal,'prom_mensual_caudales');

%% caudal data
time=data(:,1)+693960 ;
[yr,mo,da,hr]=datevec(double(time));

chazuta_caudal=data(:,3);
sregis_caudal=data(:,4);
req_caudal=data(:,6);
tamshi_caudal=data(:,7);
t=datestr(time);
%% leemos datos de sedimentos
path01='D:\trabajo\IGP\CLIM_PEZ\Variables_ordenadas\sedimentos';
fnsedimentos='Sedimentos.xlsx';

fnsedi=fullfile(path01,fnsedimentos)
[status,sheets_sed] = xlsfinfo(fnsedimentos);
%Para esto calculamos el año hidrologico de caudales y sedimentos
[data_sed,raw_sed,j_sed]=xlsread(fnsedimentos,'mensual_correcto');

%% sedimentos data
time_sed=data_sed(:,1)+693960 ;
[yr_sed,mo_sed,da_sed,hr_sed]=datevec(double(time_sed));

req_sed=data(:,2);
tamshi_sed=data(:,3);
chazuta_sed=data(:,4);

%% temperature data
load('temperature_amazonas_adcp_Modis_MUR.mat');

%% %%
time_temp=table2array(T_temperaturas(:,1));
[yrt,mot,dat,hrt]=datevec(double(time_temp));

%% %% select only the period Im interested in
% En-2003 a Dic-2015
% En-2002 a Dic-2015
time_window=[datenum(2003,01,01) datenum(2016,12,30)];

indxtime_wd=find(time>=time_window(1)&time<=time_window(2));

new_caud=data(indxtime_wd,2:end);
new_time=time(indxtime_wd);

t=datestr(new_time);

indxtime_sed=(time_sed>=time_window(1)&time_sed<=time_window(2));
new_sed=data_sed(indxtime_sed,2:end);
%% %%AGUAS ALTAS 
%finding the hidrological year
% hidrological year Aguas Altas defined as Abril-Mayo --> 2003 year
yrst=2003;
yren=2016;
most=4;
moen=5;
dast=1; daen=28;
jj=0;
    for iy=yrst:1:yren
        jj=jj+1;
        fechas=[datenum(iy,most,dast) datenum(iy,moen,daen)];

        indxtime=find(new_time>=fechas(1)&new_time<=fechas(2));
        cprintf('*black',['Procesando año ',num2str(iy),'\n'])
        disp(['Meses ',datestr(datenum(iy,most,dast)),' a ',...
            datestr(datenum(iy,moen,daen))])
        
        tamshi_c(jj,:)=nanmean(new_caud(indxtime,5));
        san_regis_c(jj,:)=nanmean(new_caud(indxtime,3));
        requena_c(jj,:)=nanmean(new_caud(indxtime,4));
        chazuta_c(jj,:)=nanmean(new_caud(indxtime,2));
        
        tamshi_sedi(jj,:)=nanmean(new_sed(indxtime,2));
        req_sedi(jj,:)=nanmean(new_sed(indxtime,1));
        chazuta_sedi(jj,:)=nanmean(new_sed(indxtime,3));
        
        ADCP(jj,:)=nanmean(table2array(T_temperaturas(indxtime,2)));
        MODia(jj,:)=nanmean(table2array(T_temperaturas(indxtime,3)));
        MONoche(jj,:)=nanmean(table2array(T_temperaturas(indxtime,4)));
        MOprom(jj,:)=nanmean(table2array(T_temperaturas(indxtime,5)));
        MUR1(jj,:)=nanmean(table2array(T_temperaturas(indxtime,6)));
        MUR2(jj,:)=nanmean(table2array(T_temperaturas(indxtime,7)));
        MUR3(jj,:)=nanmean(table2array(T_temperaturas(indxtime,8)));

        years(jj,1)=iy;
    end

%% tabla y guardamos
C1_abr_mayo_sed_caud_aguas_altas=table(years,tamshi_c,san_regis_c,requena_c,chazuta_c,tamshi_sedi,req_sedi,...
    chazuta_sedi,ADCP,MODia,MONoche,MOprom,MUR1,MUR2,MUR3);
save('C1_abr_mayo_sed_caud_aguas_altas.mat','C1_abr_mayo_sed_caud_aguas_altas');

my_file=['C1_abr_mayo_sed_caud_aguas_altas.xlsx'];
writetable(C1_abr_mayo_sed_caud_aguas_altas,my_file,'Sheet',1);

%% AGUAS BAJAS
% hidrological year Aguas Altas defined as AGOSTO_SETIEMBRE --> 2003 year
yrst=2003;
yren=2016;
most=8;
moen=9;
dast=1; daen=28;
jj=0;
    for iy=yrst:1:yren
        jj=jj+1;
        fechas=[datenum(iy,most,dast) datenum(iy,moen,daen)];

        indxtime=find(new_time>=fechas(1)&new_time<=fechas(2));
        cprintf('*black',['Procesando año ',num2str(iy),'\n'])
        disp(['Meses ',datestr(datenum(iy,most,dast)),' a ',...
            datestr(datenum(iy,moen,daen))])
        
        tamshi_c(jj,:)=nanmean(new_caud(indxtime,5));
        san_regis_c(jj,:)=nanmean(new_caud(indxtime,3));
        requena_c(jj,:)=nanmean(new_caud(indxtime,4));
        chazuta_c(jj,:)=nanmean(new_caud(indxtime,2));
        
        tamshi_sedi(jj,:)=nanmean(new_sed(indxtime,2));
        req_sedi(jj,:)=nanmean(new_sed(indxtime,1));
        chazuta_sedi(jj,:)=nanmean(new_sed(indxtime,3));
        
        ADCP(jj,:)=nanmean(table2array(T_temperaturas(indxtime,2)));
        MODia(jj,:)=nanmean(table2array(T_temperaturas(indxtime,3)));
        MONoche(jj,:)=nanmean(table2array(T_temperaturas(indxtime,4)));
        MOprom(jj,:)=nanmean(table2array(T_temperaturas(indxtime,5)));
        MUR1(jj,:)=nanmean(table2array(T_temperaturas(indxtime,6)));
        MUR2(jj,:)=nanmean(table2array(T_temperaturas(indxtime,7)));
        MUR3(jj,:)=nanmean(table2array(T_temperaturas(indxtime,8)));

        years(jj,1)=iy;
    end

%% tabla y guardamos
C1_B_Ago_Set_sed_caud_aguas_bajas=table(years,tamshi_c,san_regis_c,requena_c,chazuta_c,tamshi_sedi,req_sedi,...
    chazuta_sedi,ADCP,MODia,MONoche,MOprom,MUR1,MUR2,MUR3);

save('C1_B_Ago_Set_sed_caud_aguas_bajas.mat','C1_B_Ago_Set_sed_caud_aguas_bajas');

my_file=['C1_B_Ago_Set_sed_caud_aguas_bajas.xlsx'];
writetable(C1_B_Ago_Set_sed_caud_aguas_bajas,my_file,'Sheet',1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% temperatura vs caudal %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;
%% Temperatura
load('temperature_amazonas_adcp_Modis_MUR.mat');

%% %%
time_temp=table2array(T_temperaturas(:,1));
[yr,mo,da,hr]=datevec(double(time_temp));

%% %% %%AGUAS ALTAS 
%finding the hidrological year
% hidrological year Aguas Altas defined as Abril-Mayo --> 2003 year
yrst=2003;
yren=2016;
most=4;
moen=5;
dast=1; daen=28;
jj=0;
    for iy=yrst:1:yren
        jj=jj+1;
        fechas=[datenum(iy,most,dast) datenum(iy,moen,daen)];

        indxtime=find(time_temp>=fechas(1)&time_temp<=fechas(2));
        cprintf('*black',['Procesando año ',num2str(iy),'\n'])
        disp(['Meses ',datestr(datenum(iy,most,dast)),' a ',...
            datestr(datenum(iy,moen,daen))])
        
        ADCP(jj,:)=nanmean(table2array(T_temperaturas(indxtime,2)));
        MODia(jj,:)=nanmean(table2array(T_temperaturas(indxtime,3)));
        MONoche(jj,:)=nanmean(table2array(T_temperaturas(indxtime,4)));
        MOprom(jj,:)=nanmean(table2array(T_temperaturas(indxtime,5)));
        MUR1(jj,:)=nanmean(table2array(T_temperaturas(indxtime,6)));
        MUR2(jj,:)=nanmean(table2array(T_temperaturas(indxtime,7)));
        MUR3(jj,:)=nanmean(table2array(T_temperaturas(indxtime,8)));
        
        years(jj,1)=iy;
    end
%% 
C2_abr_mayo_temp_aguas_altas=table(years,ADCP,MODia,MONoche,MOprom,MUR1,...
    MUR2,MUR3);

[R,P]=corrplot(C2_abr_mayo_temp_aguas_altas(:,2:end));
%%
labs=C2_abr_mayo_temp_aguas_altas.Properties.VariableNames;
labels=labs(2:end);
isupper = logical(triu(ones(size(R)),1));
R(isupper) = NaN;

P(P>0.1)=NaN;
PP=~isnan(P);
RR=R.*PP;
RR(RR==0)=NaN;
%% 
h = heatmap(RR,'MissingDataColor','w','Colormap',cool);
h.XDisplayLabels = labels;  
h.YDisplayLabels = labels; 
grid on
%% 
save('C2_abr_mayo_temp_aguas_altas.mat','C2_abr_mayo_temp_aguas_altas');



