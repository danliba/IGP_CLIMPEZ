clear all; close all; clc;
%%
cd D:\trabajo\IGP\CLIM_PEZ\victoria_vera
%% Temperatura
% save to D:\trabajo\IGP\CLIM_PEZ\Variables_ordenadas
%% datos
[data,raw,j]=xlsread('datos_1_1.xlsx','base_Datos_mensual');
%% separamos el tiempo y las variables

time=data(:,1)+693960 ;
[yr,mo,da,hr]=datevec(double(time));

%% select only the period Im interested in
% En-2003 a Dic-2015
time_window=[datenum(2003,01,01) datenum(2015,12,30)];

indxtime_wd=find(time>=time_window(1)&time<=time_window(2));

new_db=data(indxtime_wd,2:end);
new_time=time(indxtime_wd);
%% now we defined the new database from 2003-2015, lets start finding the hidrological year
yrst=2003;
yren=2015;

jj=0;
    for iy=yrst:1:yren
        jj=jj+1;
        fechas=[datenum(iy,09,01) datenum(iy+1,08,01)];

        indxtime=find(new_time>=fechas(1)&new_time<=fechas(2));
        disp(['Procesando año ',num2str(iy)])
        
        temp_dia(jj,:)=nanmean(new_db(indxtime,2));
        temp_noche(jj,:)=nanmean(new_db(indxtime,3));
        sed_requena(jj,:)=nanmean(new_db(indxtime,4));
        sed_chazuta(jj,:)=nanmean(new_db(indxtime,5));
        sed_tamshi(jj,:)=nanmean(new_db(indxtime,6));
        caudal_tamshi(jj,:)=nanmean(new_db(indxtime,7));
        caudal_requena(jj,:)=nanmean(new_db(indxtime,8));
        req_boquichico(jj,:)=nanmean(new_db(indxtime,10));
        yu_boquichico(jj,:)=nanmean(new_db(indxtime,11));
        Iq_boquichico(jj,:)=nanmean(new_db(indxtime,12));
        req_llambina(jj,:)=nanmean(new_db(indxtime,13));
        yu_llambina(jj,:)=nanmean(new_db(indxtime,14));
        Iq_llambina(jj,:)=nanmean(new_db(indxtime,15));
        req_palometa(jj,:)=nanmean(new_db(indxtime,16));
        yu_palometa(jj,:)=nanmean(new_db(indxtime,17));
        iq_palometa(jj,:)=nanmean(new_db(indxtime,18));
        req_paiche(jj,:)=nanmean(new_db(indxtime,19));
        yu_paiche(jj,:)=nanmean(new_db(indxtime,20));
        iq_paiche(jj,:)=nanmean(new_db(indxtime,21));
        requ_Lisa(jj,:)=nanmean(new_db(indxtime,22));
        yu_Lisa(jj,:)=nanmean(new_db(indxtime,23));
        iq_Lisa(jj,:)=nanmean(new_db(indxtime,24));
        
        years(jj,1)=iy;
    end
%%  algunos plots 
plot(years,sed_requena,'x--'); hold on
plot(years,sed_chazuta,'o--'); hold on
plot(years,sed_tamshi,'d:');
title('Año Hidrologico Sedimentos'); ylabel('mg/L');
legend('Requena','Chazuta','Tamshiyacu');grid minor

%% plots biologicos
% pesca en Requena
figure
subplot(2,2,1)
plot(years,req_boquichico,'bx--'); hold on
plot(years,req_llambina,'ro--'); hold on
plot(years,req_paiche,'gd--'); hold on
plot(years,req_palometa,'ks:'); hold on
plot(years,requ_Lisa,'m.--'); hold on
grid on; title('Pesca Requena')
legend('Boquichico','Llambina','Paiche','Palometa','Lisa')

subplot(2,2,2)
plot(years,iq_Lisa,'m.--'); hold on
plot(years,iq_paiche,'gd--'); hold on
plot(years,iq_palometa,'ks:'); hold on
grid on; title('Pesca Iquitos')
legend('Lisa','Paiche','Palometa')

subplot(2,2,3)
plot(years,yu_Lisa,'m.--'); hold on
plot(years,yu_boquichico,'bx--'); hold on
plot(years,yu_llambina,'ro--'); hold on
plot(years,yu_paiche,'gd--'); hold on
plot(years,yu_palometa,'ks:'); hold on
grid on; title('Pesca Yurimaguas')
legend('Lisa','Boquichico','Llambina','Paiche','Palometa')

%% plot MODIS LST
temp_prom=(temp_dia+temp_noche)./2;

plot(years,temp_dia,'r.--'); hold on
plot(years,temp_noche,'bx--'); hold on
plot(years,temp_prom,'ks:'); hold on
grid minor; title('MODIS LST promedio Anual');
legend('Temperatura Dia','Temperatura Noche','Temperatura Promedio');
        %disp(['Procesando año ',num2str(iy)])
%fechas=[datenum(iy,09,01) datenum(iy+1,08,01)];

%% save
save('DATABASE_yr_hidro.mat','years','sed_requena','sed_chazuta','sed_tamshi',...
    'req_boquichico','req_llambina','req_paiche','req_palometa','',...
    'requ_Lisa','iq_Lisa','iq_paiche','iq_palometa','yu_Lisa','yu_boquichico',...
    'yu_llambina','yu_paiche','yu_palometa','temp_dia','temp_noche','temp_prom');