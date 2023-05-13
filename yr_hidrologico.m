%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% Promedio Anual Hidrológico %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;
%%
cd D:\trabajo\IGP\CLIM_PEZ\Dra_Jaramillos
%%
[data,raw,j]=xlsread('promedios_caudales_correcto_requena_yurimaguas.xlsx','prom_mensual_caudales');

time=data(:,1)+693960;
[yr,mo,da,hr,min,sec]=datevec(time);
time=datenum(yr,mo,da,hr,min,sec);
data(:,1)=time;

%% creamos el promedio anual hidrologico
% año va del 09/yr al 08/yr+1
%el año empieza en 1984/09 al 1985/08 --> 1984
%1985/09 al 1986/08 --> 1985

puertos=[j(1,2:end)];

jj=0;
    for iy=1984:1:2019
        jj=jj+1;
        fechas=[datenum(iy,09,01) datenum(iy+1,08,01)];

        indxtime=find(time>=fechas(1)&time<=fechas(2));
        disp(['Procesando año ',num2str(yr(indxtime(1)))])
        
        borja(jj,:)=nanmean(data(indxtime,2));
        Chazuta(jj,:)=nanmean(data(indxtime,3));
        San_Regis(jj,:)=nanmean(data(indxtime,4));
        Requena(jj,:)=nanmean(data(indxtime,5));
        tamshiyacu(jj,:)=nanmean(data(indxtime,6));
        Bellavista_M(jj,:)=nanmean(data(indxtime,7));
        years(jj,1)=iy;
    end

borja(borja==0)=NaN;
Chazuta(Chazuta==0)=NaN;
San_Regis(San_Regis==0)=NaN;
Requena(Requena==0)=NaN;
tamshiyacu(tamshiyacu==0)=NaN;
Bellavista_M(Bellavista_M==0)=NaN;

%% plot
figure
P=get(gcf,'position');
P(3)=P(3)*4;
P(4)=P(4)*1;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

plot(years,borja,'.--');
hold on
plot(years,Chazuta,'^--');
hold on
plot(years,San_Regis,'d--');
hold on
plot(years,Requena,'.:');
hold on
plot(years,tamshiyacu,'o--');
hold on
plot(years,Bellavista_M,'s--');
grid on
set(gca,'xtick',[1984:1:2019],'xticklabel',[1984:2019],'xlim',[1984 2019],'Fontsize',8);
ylabel('Caudal m^3/s'); xlabel('Año Hidrologico');
title('Promedio Anual Caudal (Año Hidrologico)','Fontsize',12);
legend(puertos);

%% exportar datos

T=table(years,borja,Chazuta,San_Regis,Requena,tamshiyacu,Bellavista_M);
my_file=['promedio_ano_hidrologico.xlsx'];
writetable(T,my_file,'Sheet',1);
%% correlation 
TT=table2array(T(:,2:end));
[R,P]=corrcoef(TT,'Rows','complete');
corrplot(T(:,2:end));

%% precipitacion
clear all; close all; clc;
%% 
cd D:\trabajo\IGP\CLIM_PEZ\Dra_Jaramillos\datos2
%% datos
[data,raw,j]=xlsread('base_Datos_rain.xlsx','bd_req');

%% ordenamos la data
datos=data(:,2:end);

iter=0;
for iy=1964:1:2021
    iter=iter+1;
    jj=0;
    for ii=1:1:size(datos,2)
        jj=jj+1;
        pp(jj,:)=cat(2,iy,ii,datos(iter,ii));
    end
    PPm{iter,:}=pp;
end

%% covertimos
PPrain=cell2mat(PPm);

Tmensual=table(PPrain(:,1),PPrain(:,2),PPrain(:,3));
 my_file=['promedio_ano_hidrologico.xlsx'];
writetable(Tmensual,my_file,'Sheet',2);
%% ahora calculamos el año hidrologico PPm
time=datenum(PPrain(:,1),PPrain(:,2),1);

jj=0;
    for iy=1964:1:2022
        jj=jj+1;
        fechas=[datenum(iy,09,01) datenum(iy+1,08,01)];

        indxtime=find(time>=fechas(1)&time<=fechas(2));
        disp(['Procesando año ',num2str(iy)])
        
        PPanual(jj,:)=nanmean(PPrain(indxtime,3));

        years(jj,1)=iy;
    end
    
 Train=table(years,PPanual);
 my_file=['promedio_ano_hidrologico.xlsx'];
writetable(Train,my_file,'Sheet',3);

%% Tamshiyacu 
clear all; close all; clc;
%% 
cd D:\trabajo\IGP\CLIM_PEZ\Dra_Jaramillos\datos2
%% datos
[data,raw,j]=xlsread('base_Datos_rain.xlsx','bd_Tamshi');

datos=data(:,2:end);
%% 
iter=0;
for iy=1971:1:2022
    iter=iter+1;
    jj=0;
    for ii=1:1:size(datos,2)
        jj=jj+1;
        pp(jj,:)=cat(2,iy,ii,datos(iter,ii));
    end
    PPm{iter,:}=pp;
end

%% covertimos 
PPrain=cell2mat(PPm);

Tmensual=table(PPrain(:,1),PPrain(:,2),PPrain(:,3));
 my_file=['promedio_ano_hidrologico.xlsx'];
writetable(Tmensual,my_file,'Sheet',4);

%% ahora calculamos el año hidrologico PPm
time=datenum(PPrain(:,1),PPrain(:,2),1);

jj=0;
    for iy=1971:1:2021
        jj=jj+1;
        fechas=[datenum(iy,09,01) datenum(iy+1,08,01)];

        indxtime=find(time>=fechas(1)&time<=fechas(2));
        disp(['Procesando año ',num2str(iy)])
        
        PPanual(jj,:)=nanmean(PPrain(indxtime,3));

        years(jj,1)=iy;
    end
    
 Train=table(years,PPanual);
 my_file=['promedio_ano_hidrologico.xlsx'];
writetable(Train,my_file,'Sheet',5);


%% %% San Regis
clear all; close all; clc;
%% 
cd D:\trabajo\IGP\CLIM_PEZ\Dra_Jaramillos\datos2
%% datos
[data,raw,j]=xlsread('base_Datos_rain.xlsx','bd_SanRegis');

datos=data(:,2:end);
%% 
iter=0;
for iy=1963:1:2021
    iter=iter+1;
    jj=0;
    for ii=1:1:size(datos,2)
        jj=jj+1;
        pp(jj,:)=cat(2,iy,ii,datos(iter,ii));
    end
    PPm{iter,:}=pp;
end

%% covertimos 
PPrain=cell2mat(PPm);
PPrain(PPrain==0)=NaN;

Tmensual=table(PPrain(:,1),PPrain(:,2),PPrain(:,3));
 my_file=['promedio_ano_hidrologico.xlsx'];
writetable(Tmensual,my_file,'Sheet',6);

%% ahora calculamos el año hidrologico PPm
time=datenum(PPrain(:,1),PPrain(:,2),1);

jj=0;
    for iy=1963:1:2021
        jj=jj+1;
        fechas=[datenum(iy,09,01) datenum(iy+1,08,01)];

        indxtime=find(time>=fechas(1)&time<=fechas(2));
        disp(['Procesando año ',num2str(iy)])
        
        PPanual(jj,:)=nanmean(PPrain(indxtime,3));

        years(jj,1)=iy;
    end
    
 Train=table(years,PPanual);
 my_file=['promedio_ano_hidrologico.xlsx'];
writetable(Train,my_file,'Sheet',8);

