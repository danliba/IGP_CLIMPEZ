clear all; close all; clc;
%%
cd D:\trabajo\IGP\CLIM_PEZ\Dra_Jaramillos
%%
[data,raw,j]=xlsread('promedios_caudales_correcto.xlsx','prom_mensual_caudales');

time=data(:,1)+693960;
[yr,mo,da,hr,min,sec]=datevec(time);
time=datenum(yr,mo,da,hr,min,sec);
data(:,1)=time;
%% plot
iter=1;
puertos=[j(1,2:end)];

for kk=1:1:length(puertos)
    iter=iter+1;
    jj=0;
    disp(char(puertos(kk)))
    figure
    %subplot(2,4,kk)
    for iy=1985:1:2020
        jj=jj+1;
        indxtime=find(yr==iy);
        data_temp=data(indxtime,iter);
        all_data(:,jj)=data_temp;
        
        plot([1:12],data(indxtime,iter),'.:'); title(['Promedio Mensual ',char(puertos(kk))]);
        grid on
        xlabel('Meses'); ylabel('Caudal m^3/s');
        legend(num2str(iy));
        pause(1)
        hold on
    end
    aa=plot([1:12],nanmean(all_data,2)','linewidth',2,'Color','k');
    legend([aa],'Climatologia mensual');
    %print(['prom_mensual-',char(puertos(kk))],'-dpng','-r500');
end