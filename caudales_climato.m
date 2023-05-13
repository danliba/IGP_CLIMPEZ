clear all; close all; clc;
%%
cd D:\trabajo\IGP\CLIM_PEZ\Dra_Jaramillos
%%
[data,raw,j]=xlsread('Caudales.xlsx','data');

time=data(:,1)+693960;
[yr,mo,da,hr,min,sec]=datevec(time);
time=datenum(yr,mo,da,hr,min,sec);
%% climatologia mensual
puertos=[j(1,2:end)];

iter=1;

for k=1:1:length(j(1,2:end))
    iter=iter+1;
    disp(char(puertos(k)))
    for iclim=1:1:12
        indx_clim=find(mo==iclim);
        disp(['Creating clim month ',num2str(iclim)])

        clim_temp=nanmean(data(indx_clim,iter));
        %anom_temp=
        clim_req(iclim,1)=clim_temp;
    end    
figure   
plot(clim_req,'o-'); title(['Climatologia Mensual Puerto ', puertos(k)]); grid minor;
%print(['climato-',char(puertos(k))],'-dpng','-r500');
%close all

my_field=strcat('caudal_',char(puertos(k)));
climato.(my_field) = clim_req;
end
%% promedios anuales
puertos=[j(1,2:end)];
anos=[yr(1):1:yr(end)]';
iter=1;
for k=1:1:length(j(1,2:end))
jj=0;
disp(['Puerto ',char(puertos(k))])
iter=iter+1;
    for iy=yr(1):1:max(yr)
        jj=jj+1;
        indx_ano=find(yr==iy);
        disp(['Creating yearly average ',num2str(iy)])
        data_temp=data(indx_ano,iter);
        
        yr_temp=nanmean(data(indx_ano,iter));
        yr_avg(jj,1)=yr_temp;
        
        time_avg=time(indx_ano);
        [yr_av,mo_av,da_av]=datevec(time_avg);
        %disp(length(data_temp))
%         plot([1:length(data_temp)],data_temp,':');
%         hold on
        
    end
    
figure
plot(anos,yr_avg,'o-'); title(['Promedio Anual ',puertos(k)]); grid minor;
%print(['prom_anual-',char(puertos(k))],'-dpng','-r500');
%close all
data_cat=cat(2,anos,yr_avg);
my_field=strcat('caudal_',char(puertos(k)));
prom_anual.(my_field) = data_cat;
end


%% ploteos todos los datos 
puertos=[j(1,2:end)];
anos=[1985:1:2020];
iter=1;
for k=1:1:length(j(1,2:end))
jj=0;
disp(['Puerto ',char(puertos(k))])
iter=iter+1;
figure
    for iy=1985:1:2020
        jj=jj+1;
        indx_ano=find(yr==iy);
        disp(['Creating yearly average ',num2str(iy)])
        data_temp=data(indx_ano,iter);
        all_data(:,jj)=data_temp(1:365);
        %disp(length(data_temp))
        
        plot([1:365],data_temp(1:365),':');
        hold on
        
    end
    prom_all=nanmean(all_data,2)';
    rm=movmean(prom_all,20);
    aa=plot([1:365],prom_all,'linewidth',2,'Color','k');
    hold on
    bb=plot([1:365],rm,'linewidth',2,'Color','r'); title(['Datos diarios Puerto ',char(puertos(k))]);
    xlim([0 365]);xlabel('Dias');
    legend([aa,bb],'Promedio Diario','Media movil 20 dias')
    print(['prom_diario-',char(puertos(k))],'-dpng','-r500');
    close all
end


%% save table
T=table(climato.caudal_Borja,climato.caudal_Chazuta,climato.caudal_San_Regis,...
    climato.caudal_Lagarto,climato.caudal_Requena,...
    climato.caudal_Tamshiyacu,climato.caudal_Bellavista_Mazan);

my_file=['climato_data.xlsx'];
writetable(T,my_file,'Sheet',1);

