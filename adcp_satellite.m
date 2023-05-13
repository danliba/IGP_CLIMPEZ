clear all; close all, clc
%%
cd D:\trabajo\IGP\CLIM_PEZ\ADCP_temp
%% 
[data,raw,j]=xlsread('Temp_Tamshi_ADCP_2002-2018.xlsx','database');

yr=raw(2:end,1); mo=data(:,1);
year=str2num(cell2mat(yr));
time=datenum(year,mo,1);
%%  load MUR
load('MUR_3_amazonas.mat');
%% database
%temp_prom=nanmean(data(:,3),data(:,4));

plot(time,data(:,2),'o--'); hold on;
plot(time,data(:,3),'b.--');hold on;
plot(time,data(:,4),'m^:'); hold on;
plot(time,data(:,5),'ks:');hold on;
plot(time,sst_MUR_reg1);hold on;
plot(time,sst_MUR_reg2);hold on;
plot(time,sst_MUR_reg3);hold on;
grid minor;
datetick('x');
legend('ADCP TºC','MODIS DIA','MODIS Noche','MODIS Prom','MUR R1','MUR R2','MUR R3')

%% creamos una tabla para hacer las correlaciones
new_db=cat(2,data(:,2),data(:,3),data(:,4),data(:,5),sst_MUR_reg1,sst_MUR_reg2,sst_MUR_reg3);
T=array2table(new_db);
T.Properties.VariableNames{1} = 'ADCP';
T.Properties.VariableNames{2} = 'TDIA';
T.Properties.VariableNames{3} = 'TNOCHE';
T.Properties.VariableNames{4} = 'TProm';
T.Properties.VariableNames{5} = 'MUR1';
T.Properties.VariableNames{6} = 'MUR2';
T.Properties.VariableNames{7} = 'MUR3';
%% 
[R,P]=corrplot(T);
%% 
labels=T.Properties.VariableNames;

%%
%[R,P]=corrcoef(new_db,'Rows','complete');
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
grid on
%% sin pvalue significativo
h = heatmap(R,'MissingDataColor','w','Colormap',jet);
h.XDisplayLabels = labels;
h.YDisplayLabels = labels; 
grid off

%% base de datos de las temperaturas
temperaturas=cat(2,time,data(:,2),data(:,3),data(:,4),data(:,5),...
    sst_MUR_reg1,sst_MUR_reg2,sst_MUR_reg3);
T_temperaturas=array2table(temperaturas);

T_temperaturas.Properties.VariableNames{1} = 'time';
T_temperaturas.Properties.VariableNames{2} = 'ADCP';
T_temperaturas.Properties.VariableNames{3} = 'TDIA';
T_temperaturas.Properties.VariableNames{4} = 'TNOCHE';
T_temperaturas.Properties.VariableNames{5} = 'TProm';
T_temperaturas.Properties.VariableNames{6} = 'MUR1';
T_temperaturas.Properties.VariableNames{7} = 'MUR2';
T_temperaturas.Properties.VariableNames{8} = 'MUR3';

save('temperature_amazonas_adcp_Modis_MUR.mat','T_temperaturas');
