%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% Promedio Temperatura Anual Hidrológico %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;
%%
cd D:\trabajo\IGP\CLIM_PEZ\Dra_Jaramillos\datos2
%% Temperatura

clear all; close all; clc;
%% 
cd D:\trabajo\IGP\CLIM_PEZ\Dra_Jaramillos\datos2
%% datos
[data,raw,j]=xlsread('base_Datos_Temp.xlsx','bd_req');

%% ordenamos la data
datos=data(2:end,2:end);

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
TSA=cell2mat(PPm);

Tmensual=table(TSA(:,1),TSA(:,2),TSA(:,3));
 my_file=['promedio_ano_hidrologico_TSA.xlsx'];
writetable(Tmensual,my_file,'Sheet',1);
%% ahora calculamos el año hidrologico PPm
time=datenum(TSA(:,1),TSA(:,2),1);

jj=0;
    for iy=1964:1:2022
        jj=jj+1;
        fechas=[datenum(iy,09,01) datenum(iy+1,08,01)];

        indxtime=find(time>=fechas(1)&time<=fechas(2));
        disp(['Procesando año ',num2str(iy)])
        
        PPanual(jj,:)=nanmean(TSA(indxtime,3));

        years(jj,1)=iy;
    end
    
 Train=table(years,PPanual);
 my_file=['promedio_ano_hidrologico_TSA.xlsx'];
writetable(Train,my_file,'Sheet',2);

%% %% Tamshiyacu 
clear all; close all; clc;
%% 
cd D:\trabajo\IGP\CLIM_PEZ\Dra_Jaramillos\datos2
%% datos
[data,raw,j]=xlsread('base_Datos_Temp.xlsx','bd_tamshi');

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
 my_file=['promedio_ano_hidrologico_TSA.xlsx'];
writetable(Tmensual,my_file,'Sheet',3);

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
 my_file=['promedio_ano_hidrologico_TSA.xlsx'];
writetable(Train,my_file,'Sheet',4);

%% %% San Regis
clear all; close all; clc;
%% 
cd D:\trabajo\IGP\CLIM_PEZ\Dra_Jaramillos\datos2
%% datos
[data,raw,j]=xlsread('base_Datos_Temp.xlsx','bd_SR');

datos=data(:,2:end);
%% 
iter=0;
for iy=2014:1:2021
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
 my_file=['promedio_ano_hidrologico_TSA.xlsx'];
writetable(Tmensual,my_file,'Sheet',5);

%% ahora calculamos el año hidrologico PPm
time=datenum(PPrain(:,1),PPrain(:,2),1);

jj=0;
    for iy=2014:1:2021
        jj=jj+1;
        fechas=[datenum(iy,09,01) datenum(iy+1,08,01)];

        indxtime=find(time>=fechas(1)&time<=fechas(2));
        disp(['Procesando año ',num2str(iy)])
        
        PPanual(jj,:)=nanmean(PPrain(indxtime,3));

        years(jj,1)=iy;
    end
    
 Train=table(years,PPanual);
 my_file=['promedio_ano_hidrologico_TSA.xlsx'];
writetable(Train,my_file,'Sheet',6);

%% Ahora con los datos que paso Jonathan_ TEMP superficial del Aire

clear all; close all; clc;
%% 
cd D:\trabajo\IGP\CLIM_PEZ\Dra_Jaramillos\datos2
%% datos
[data,raw,j]=xlsread('base_Datos_Temp.xlsx','TemAire_mensual');

datos=data(:,2:end);
%% tiempo
time=data(:,1)+693960;
[yr,mo,da,hr,min,sec]=datevec(time);
time=datenum(yr,mo,da,hr,min,sec);
data(:,1)=time;

%% ahora calculamos el año hidrologico PPm
%time=datenum(PPrain(:,1),PPrain(:,2),1);

jj=0;
    for iy=yr(1):1:yr(end)-1
        jj=jj+1;
        fechas=[datenum(iy,09,01) datenum(iy+1,08,01)];

        indxtime=find(time>=fechas(1)&time<=fechas(2));
        disp(['Procesando año ',num2str(iy)])
        
        Tamshi(jj,:)=nanmean(datos(indxtime,1));
        SanRegis(jj,:)=nanmean(datos(indxtime,2));
        Requena(jj,:)=nanmean(datos(indxtime,3));
        
        years(jj,1)=iy;
    end
    
 Train=table(years,Tamshi,SanRegis,Requena);
 my_file=['promedio_ano_hidrologico_TSA.xlsx'];
writetable(Train,my_file,'Sheet',7);







