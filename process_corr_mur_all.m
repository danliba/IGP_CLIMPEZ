cd D:\trabajo\IGP\CLIM_PEZ\temp_agua_oceancolor\MUR\cuted
%% 
load('MUR_amazonas.mat');
%%

figure
P=get(gcf,'position');
P(3)=P(3)*4;
P(4)=P(4)*1;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');
%Temp de Dia vs Reanalysis
%plot(time(1:194),TAm.TEMPdia,':','Color',[0.4940 0.1840 0.5560],'Linewidth',1.5); hold on
plot(time2,sst_MUR);hold on
plot(time2(1:194),TAm.Tam_RA_Tp,':o');hold on;
plot(time2(1:194),TAm.Req_RA_Tp,'--d');hold on;
plot(time2(1:194),TAm.SR_RA_Tp,':^r');
datetick('x');
grid on
legend('T MUR','T Tamshi','T Requ','T San Regis');
title('Temperatura Agua Dia vs Reanalysis Aire');

%% 
indxfecha=find(time>=time2(1)&time<=time2(end));
newtime=time(indxfecha);

%% Temp promedio Reanlysis 
MUR_temp=cat(2,TAm(indxfecha,:),table(sst_MUR));

mur=table2array(MUR_temp);
% T=array2table(MUR_temp);
% 
% T.Properties.VariableNames{1} = 'Tam';
% T.Properties.VariableNames{2} = 'Req';
% T.Properties.VariableNames{3} = 'SR';
% T.Properties.VariableNames{4} = 'MUR';

corrplot(MUR_temp)
%% 
labels=MUR_temp.Properties.VariableNames;

%%
[R,P]=corrcoef(mur,'Rows','complete');
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

%% save
save('Data_Base_sst.mat','newtime','MUR_temp','mur');
