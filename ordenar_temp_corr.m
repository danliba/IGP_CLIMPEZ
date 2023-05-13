clear all; close all; clc;
%%
cd D:\trabajo\IGP\CLIM_PEZ\Dra_Jaramillos\datos2
%% Temperatura
%% datos
[data,raw,j]=xlsread('temp_aire_to_temp_agua_simulation.xlsx','simulacion3');
%% table
labels=j(1,2:end);
TAm=array2table(data(1:194,2:end));

for ii=1:1:length(labels)
    TAm.Properties.VariableNames{ii} = char(labels(ii));
    
end
%% 
[R,P]=corrcoef(data(1:194,2:end),'Rows','complete');
%corrplot(TAm);

isupper = logical(triu(ones(size(R)),1));
R(isupper) = NaN;

P(P>0.1)=NaN;
PP=~isnan(P);
RR=R.*PP;
RR(RR==0)=NaN;
%% 
h = heatmap(RR,'MissingDataColor','w','Colormap',cool);
h.XDisplayLabels = labels;  
h.YDisplayLabels = labels; 
grid off
%% sin pvalue significativo
h = heatmap(R,'MissingDataColor','w','Colormap',jet);
h.XDisplayLabels = labels;
h.YDisplayLabels = labels; 
grid off

%% corr plot de Reanalisis vs temp agua
Rea_T=cat(2,TAm(:,1:3),TAm(:,13:end));

Rea_T.Properties.VariableNames{1} = 'TDia';
Rea_T.Properties.VariableNames{2} = 'TNoche';
Rea_T.Properties.VariableNames{3} = 'TProm';
Rea_T.Properties.VariableNames{4} = 'TamRAProm';
Rea_T.Properties.VariableNames{5} = 'ReqRAProm';
Rea_T.Properties.VariableNames{6} = 'SRegRAProm';

corrplot(Rea_T)

%% cor plot Reanalisis vs Temp atmosferica
Rea_vs_Temp=cat(2,TAm(1:194,4),TAm(1:194,7),TAm(1:194,10),...
    TAm(1:194,13:end));

Rea_vs_Temp.Properties.VariableNames{1} = 'TamTP';
Rea_vs_Temp.Properties.VariableNames{2} = 'ReqTP';
Rea_vs_Temp.Properties.VariableNames{3} = 'SRTP';
Rea_vs_Temp.Properties.VariableNames{4} = 'TamRA';
Rea_vs_Temp.Properties.VariableNames{5} = 'ReqRA';
Rea_vs_Temp.Properties.VariableNames{6} = 'SRegRA';

corrplot(Rea_vs_Temp)

%% %% cor plot Temp atmosferica vs Temp agua
Atm_Tamshi=TAm(1:194,1:6);

Atm_Tamshi.Properties.VariableNames{1} = 'Tdia';
Atm_Tamshi.Properties.VariableNames{2} = 'Tnoche';
Atm_Tamshi.Properties.VariableNames{3} = 'TProm';
Atm_Tamshi.Properties.VariableNames{4} = 'TaTP';
Atm_Tamshi.Properties.VariableNames{5} = 'TaMax';
Atm_Tamshi.Properties.VariableNames{6} = 'TaMin';

corrplot(Atm_Tamshi)

%% %% cor plot Temp atmosferica vs Temp agua
Atm_SanRegis=cat(2,TAm(1:194,1:3),TAm(1:194,10:12));

Atm_SanRegis.Properties.VariableNames{1} = 'Tdia';
Atm_SanRegis.Properties.VariableNames{2} = 'Tnoche';
Atm_SanRegis.Properties.VariableNames{3} = 'TProm';
Atm_SanRegis.Properties.VariableNames{4} = 'SRTP';
Atm_SanRegis.Properties.VariableNames{5} = 'SRMax';
Atm_SanRegis.Properties.VariableNames{6} = 'SRMin';

corrplot(Atm_SanRegis)
%% %% cor plot Temp atmosferica vs Temp agua
atm_Requena=cat(2,TAm(1:194,1:3),TAm(1:194,7:9));

atm_Requena.Properties.VariableNames{1} = 'Tdia';
atm_Requena.Properties.VariableNames{2} = 'Tnoche';
atm_Requena.Properties.VariableNames{3} = 'TProm';
atm_Requena.Properties.VariableNames{4} = 'RqTP';
atm_Requena.Properties.VariableNames{5} = 'RqMax';
atm_Requena.Properties.VariableNames{6} = 'RqMin';

corrplot(atm_Requena)
%%
[R2,P2]=corrcoef(Rea_vs_Temp.ReqTP,Rea_vs_Temp.ReqRA,'Rows','complete','Alpha',0.1);

%% Tiempo
time=data(:,1)+693960;
[yr,mo,da,hr,min,sec]=datevec(time);
time=datenum(yr,mo,da,hr,min,sec);
%% Ploteo
figure
P=get(gcf,'position');
P(3)=P(3)*4;
P(4)=P(4)*1;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');
%Temp de Dia vs Reanalysis
plot(time(1:194),TAm.TEMPdia,':','Color',[0.4940 0.1840 0.5560],'Linewidth',1.5); hold on
plot(time(1:194),TAm.Tam_RA_Tp,':o');hold on;
plot(time(1:194),TAm.Req_RA_Tp,'--d');hold on;
plot(time(1:194),TAm.SR_RA_Tp,':^r');
datetick('x');
grid on
legend('T agua Dia','T Tamshi','T Requ','T San Regis');
title('Temperatura Agua Dia vs Reanalysis Aire');
%print('Temperatura Agua Dia vs Reanalysis Aire','-dpng','-r500');

figure
P=get(gcf,'position');
P(3)=P(3)*4;
P(4)=P(4)*1;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

%Temp noche vs reanalysis
plot(time(1:194),TAm.TEMPnoche,':','Linewidth',1.2);hold on
plot(time(1:194),TAm.Tam_RA_Tp,':o');hold on;
plot(time(1:194),TAm.Req_RA_Tp,'--d');hold on;
plot(time(1:194),TAm.SR_RA_Tp,':^');
datetick('x');
grid on
legend('T agua Noche','T Tamshi','T Requ','T San Regis');
title('Temperatura Agua Noche vs Reanalysis Aire');
%print('Temperatura Agua Noche vs Reanalysis Aire','-dpng','-r500');


figure
P=get(gcf,'position');
P(3)=P(3)*4;
P(4)=P(4)*1;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');
%Temp prom vs reanalysis
plot(time(1:194),TAm.TempProm,':','Linewidth',1.2); hold on;
plot(time(1:194),TAm.Tam_RA_Tp,':o');hold on;
plot(time(1:194),TAm.Req_RA_Tp,'--d');hold on;
plot(time(1:194),TAm.SR_RA_Tp,':^');
datetick('x');
grid on
legend('T agua Prom','T Tamshi','T Requ','T San Regis');
title('Temperatura Agua Prom vs Reanalysis Aire');
%print('Temperatura Agua Prom vs Reanalysis Aire','-dpng','-r500');
%%  save



