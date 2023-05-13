clear all; close all; clc;
%%
cd D:\trabajo\IGP\CLIM_PEZ\Dra_Jaramillos
%% climatologia import
[data,raw,j]=xlsread('promedios_caudales_correcto_requena_yurimaguas.xlsx',...
    'Climatologia_mensual');

%%
mes=data(:,1);
chazuta_caudal=data(:,3);
sregis_caudal=data(:,4);
req_caudal=data(:,6);
tamshi_caudal=data(:,7);

%% plots
puertos={'Tamshiyacu','San Regis','Requena','Chazuta'};
labels={'Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Set','Oct','Nov','Dic'};
figure
% P=get(gcf,'position');
% P(3)=P(3)*4;
% P(4)=P(4)*1;
% set(gcf,'position',P);
% set(gcf,'PaperPositionMode','auto');

plot(mes,tamshi_caudal,'.--');
hold on
plot(mes,sregis_caudal,'^--');
hold on
plot(mes,req_caudal,'d--');
hold on
plot(mes,chazuta_caudal,'.:');
grid on
set(gca,'xtick',[1:1:12],'xticklabel',labels,'xlim',[1 12],'Fontsize',8);
ylabel('Caudal [m^3/s]'); xlabel('Meses');
title('Climatologia mensual Caudal [m^3/s]','Fontsize',12);
legend(puertos);
