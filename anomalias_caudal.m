clear all; close all; clc;
%%
cd D:\trabajo\IGP\CLIM_PEZ\Dra_Jaramillos
%%
[data,raw,j]=xlsread('promedios_caudales_correcto.xlsx','anomaly');

time=data(:,1)+693960;
[yr,mo,da,hr,min,sec]=datevec(time);
time=datenum(yr,mo,da,hr,min,sec);
data(:,1)=time;

%% we drop lagarto
data(:,5)=[];
j(:,5)=[];
%% 
puertos=[j(1,2:end)];
jj=1;
lab={'r.:','b.:','m.:','k.:','c.:','g.:','--'};
    figure
    P=get(gcf,'position');
    P(3)=P(3)*4;
    P(4)=P(4)*1;
    set(gcf,'position',P);
    set(gcf,'PaperPositionMode','auto');
for kk=1:1:length(puertos)
    jj=jj+1;
    plot(time,data(:,jj),char(lab(kk)));grid on; 
    datetick('x','keeplimits');xlim([time(1) time(end)]);
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName','Arial','fontsize',8)
    %title(['Anomalias mensuales ',char(puertos(kk))],'Fontsize',13);
    title('Anomalias Mensuales','Fontsize',13);
    ylabel('[m^3/s]');
    r=corr(time,data(:,jj),'rows','complete');
    disp(['Corr Pearson puerto ',char(puertos(kk)),' ',num2str(r)])
    hold on
    %print(['anom_mensual-',char(puertos(kk))],'-dpng','-r500');
end
legend(char(puertos));

%% create a table
for k=1:1:length(puertos)
    data_cat=data(:,k+1);
    my_field=char(puertos(k));
    anom.(my_field) = data_cat;
end

T=struct2table(anom);
%% corrcoef
[R,P]=corrcoef(data(:,2:end),'Rows','complete');
corrplot(T);
%corrcoef([data(:,2),data(:,3),data(:,4),data(:,5)],'Rows','complete')
%revisar data de Yurimaguas, no tiene sentido
