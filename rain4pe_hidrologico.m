
clear all; close all; clc;
%%
cd D:\trabajo\IGP\CLIM_PEZ\rain4pe
%% Temperatura
% save to D:\trabajo\IGP\CLIM_PEZ\Variables_ordenadas
%% datos
[data,raw,j]=xlsread('rain4pe.xlsx','Hoja1');
%% separamos el tiempo y las variables

time=data(:,1)+693960 ;
[yr,mo,da,hr]=datevec(double(time));

%% all data hidrological year
yrst=1981;
yren=2015;

jj=0;
    for iy=yrst+1:1:yren
        jj=jj+1;
        fechas=[datenum(iy-1,09,01) datenum(iy,08,01)];

        indxtime=find(time>=fechas(1)&time<=fechas(2));
        disp(['Procesando año ',num2str(iy)])
        
        tamshi_all(jj,:)=nanmean(data(indxtime,2));
        san_regis_all(jj,:)=nanmean(data(indxtime,3));
        requena_all(jj,:)=nanmean(data(indxtime,4));
        chazuta_all(jj,:)=nanmean(data(indxtime,5));
        
        years_all(jj,1)=iy;
    end

%% select only the period Im interested in
% En-2003 a Dic-2015
% En-2002 a Dic-2015
time_window=[datenum(2002,01,01) datenum(2015,12,30)];

indxtime_wd=find(time>=time_window(1)&time<=time_window(2));

new_db=data(indxtime_wd,2:end);
new_time=time(indxtime_wd);
%% now we defined the new database from 2003-2015, lets start finding the hidrological year
% hidrological year defined as September 2002 to August 2003 --> 2003 year
yrst=2002;
yren=2015;

jj=0;
    for iy=yrst+1:1:yren
        jj=jj+1;
        fechas=[datenum(iy-1,09,01) datenum(iy,08,01)];

        indxtime=find(new_time>=fechas(1)&new_time<=fechas(2));
        disp(['Procesando año ',num2str(iy)])
        
        tamshi(jj,:)=nanmean(new_db(indxtime,1));
        san_regis(jj,:)=nanmean(new_db(indxtime,2));
        requena(jj,:)=nanmean(new_db(indxtime,3));
        chazuta(jj,:)=nanmean(new_db(indxtime,4));
        
        years(jj,1)=iy;
    end
%% some plots all time data
labels={'Tamshiyacu','San Regis','Requena','Chazuta'};

figure
P=get(gcf,'position');
P(3)=P(3)*4;
P(4)=P(4)*1;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

plot(years_all,tamshi_all,'.--');
hold on
plot(years_all,san_regis_all,'^--');
hold on
plot(years_all,requena_all,'d--');
hold on
plot(years_all,chazuta_all,'.:');
grid on
set(gca,'xtick',[1982:1:2015],'xticklabel',[1982:2015],'xlim',[1982 2015],'Fontsize',8);
ylabel('Rain mm'); xlabel('Año Hidrologico');
title('Promedio Anual Precipitacion (Año Hidrologico)','Fontsize',12);
legend(labels);

%% exportamos los años hidrologicos del 2003-2015

T=table(years,tamshi,san_regis,requena,chazuta);
my_file=['rain4pe_promedio_ano_hidrologico.xlsx'];
writetable(T,my_file,'Sheet',1);
%% save as mat

save('rain4pe_puertos_yr_hidrological.mat','years','tamshi','chazuta',...
    'requena','san_regis');