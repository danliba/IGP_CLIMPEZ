%% plot rain
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;
%%
cd D:\trabajo\IGP\CLIM_PEZ\Dra_Jaramillos\datos2
%%
[data,raw,j]=xlsread('base_Datos_rain.xlsx','prom_anual_hidrologico');

years=data(:,1);
puertos=[j(1,2:end)];

%% plot
labs={'.--','x--','s--'};

figure
P=get(gcf,'position');
P(3)=P(3)*4;
P(4)=P(4)*1;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');
for ii=1:1:length(puertos)
    plot(years,data(:,ii+1),char(labs(ii)))
    hold on
end
grid on
legend(puertos);
ylabel('Promedio Anual [mm]','Fontsize',10)
set(gca,'xtick',[1963:1:2021],'xticklabel',[1963:1:2021],'xlim',[1963 2021],'Fontsize',6);

%% correlation 
TT=data(:,2:end);
[R,P]=corrcoef(TT,'Rows','complete');
corrplot(TT);





