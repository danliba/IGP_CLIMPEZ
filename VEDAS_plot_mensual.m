%% relacionamos las variables de la climatologia hidrologica
clear all; close all; clc;
cd D:\trabajo\IGP\CLIM_PEZ\Variables_ordenadas\mensual
%% 

fn1='Base_de_Datos.xlsx';
[status,sheets] = xlsfinfo(fn1);
[numData1, textData1, raw1] = xlsread(fn1, char(sheets(5))); %bd_fis
[numData2, textData2, raw2] = xlsread(fn1, char(sheets(4))); %pesca
%% 
time=numData1(:,1)+693960;
[yr,mo,da,hr,min,sec]=datevec(time);
time=datenum(yr,mo,da,hr,min,sec);

fecha=datestr(time);
T_fis=array2table(numData1(:,2:end));
columnNames=textData1(1,2:end);
T_fis.Properties.VariableNames=columnNames;
T_fis.Properties.RowNames=cellstr(string(fecha));

T_pesca=array2table(numData2(:,2:end));
columnNames2=textData2(1,2:end);
T_pesca.Properties.VariableNames=columnNames2;
T_pesca.Properties.RowNames=cellstr(string(fecha));

%% VEDAS
%Boquichico: Diciembre-marzo; octubre-diciembre
indxveda=find(mo<=3 | mo==12);
indxveda2=find(mo>=10& mo<=11);
%monew=mo(indxveda2);
arr= ones(52, 1); arr2=ones(length(indxveda2),1);
arr(arr==1)=1000; arr2(arr2==1)=1000;
%bar(indxveda,arr)
%% 
bar(indxveda,arr, 'FaceColor', [0.9 0.9 0.9], 'EdgeColor', 'none');
hold on
bar(indxveda2,arr2, 'FaceColor', [0.9 0.9 0.9], 'EdgeColor', 'none');
hold on
plot(table2array(T_pesca(:,ii),'.-'));
%% extraer fechas
extractedValues = time(1:5:end);
fechasi=datestr(extractedValues);
%% plots

figure
P=get(gcf,'position');
P(3)=P(3)*5;
P(4)=P(4)*1;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

ii=1;
%for ii=1:1:5
ax1= axes;
yyaxis right;
bar(indxveda,arr, 'FaceColor', [0.9 0.9 0.9], 'EdgeColor', 'none','FaceAlpha', 0.5);
hold on
bar(indxveda2,arr2, 'FaceColor', [0.9 0.9 0.9], 'EdgeColor', 'none','FaceAlpha', 0.5);
hold on
plot(table2array(T_pesca(:,ii),'.-'),LineWidth=1.5);
ylabel('Pesca [Tn]')
pause(0.1) 
ax1.XTickMode = 'manual'; 
ax1.YTickMode = 'manual'; 
ax1.YLim = [min(ax1.YTick), max(ax1.YTick)];  % see [4]
ax1.XLimMode = 'manual'; 
grid(ax1,'on')
ytick = ax1.YTick;  

yyaxis left;
plot(T_fis.("C-Tamshiyacu"),'x-');
ylabel('Caudal [m^3/s]')
set(gca,'xtick',[])
%grid on
% create 2nd, transparent axes
ax2 = axes('position', ax1.Position);
plot(ax2,T_fis.("R-Tamshiyacu"), 'k')             % see [3]
ax2.Color = 'none'; 
pause(0.1)  
grid(ax2, 'on')
% Horizontally scale the y axis to alight the grid (again, be careful!)
ax2.XLim = ax1.XLim; 
ax2.XTick = ax1.XTick; 
ax2.YLimMode = 'manual'; 
yl = ax2.YLim; 
ylabel('Precipitacion [mm]')
% horzontally offset y tick labels
ax2.YTickLabel = strcat(ax2.YTickLabel, {'              '}); 
ax2.YTick = linspace(yl(1), yl(2), length(ytick));      % see [2]

% create 3rd transparent axes
ax3 = axes('position', ax1.Position,'color','magenta');
plot(ax3, T_fis.("S-Tamshiyacu"), 'm^-','LineWidth',0.7); % Replace "SomeOtherData" with your actual data
ax3.Color = 'none';
pause(0.1);
grid(ax3, 'on');
ax3.XLim = ax1.XLim;
ax3.XTick = ax1.XTick;
ax3.YLimMode = 'manual';
yl = ax3.YLim;
ylabel('Sedimentos [mg/L]')
ax3.YTickLabel = strcat(ax3.YTickLabel, {'                                 '});
ax3.YTick = linspace(yl(1), yl(2), length(ytick));

title('Iquitos Boquichico');
%set(gca,'xtick',[1:1:12],'xticklabel',meses);
%xlim([1 12]);
legend('Sedimentos')

%pause(1)
% fsave=string([char(columnNames2(ii)),'.png']);
% print(fsave, '-dpng', '-r500');
%clf
%end
%datetick('x')
set(gca,'xtick',[1:5:length(time)],'xticklabel',fechasi(:,4:end));
%set(gca,'xtick',[0:1:length(time)],'xticklabel',fechasi);
%% 
