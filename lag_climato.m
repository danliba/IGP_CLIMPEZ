%% vamos a hacer LAGs con la estacionalidad del año modelo 
clear all; close all; clc;
cd D:\trabajo\IGP\CLIM_PEZ\Variables_ordenadas\mensual
%% 

fn1='CLIM_HIDRO_BD2.xlsx';
[status,sheets] = xlsfinfo(fn1);

%datafis=readtable(fn1,char(sheets(1)));
[numData1, textData1, raw1] = xlsread(fn1, char(sheets(1))); %fis
[numData2, textData2, raw2] = xlsread(fn1, char(sheets(3))); %pesca

meses=textData1(2:end,1);

T_fis=array2table(numData1);
columnNames=textData1(1,2:end);
T_fis.Properties.VariableNames=columnNames;
T_fis.Properties.RowNames=cellstr(string(meses));

T_pesca=array2table(numData2);
columnNames2=textData2(1,2:end);
T_pesca.Properties.VariableNames=columnNames2;
T_pesca.Properties.RowNames=cellstr(string(meses));
%% Ahora agrupamos por puerto para hacer los LAG

Tamshi=horzcat(T_fis(:,1),T_fis(:,4),T_fis(:,7));
Tamshi_pesca=T_pesca(:,1:5);

SanRegis=horzcat(T_fis(:,2),T_fis(:,5),T_fis(:,8));
SR_pesca=T_pesca(:,6:10);

Requena=horzcat(T_fis(:,3),T_fis(:,6),T_fis(:,9));
Requena_pesca=T_pesca(:,11:end);
%% creamos las fechas ficticias
startDate = datetime(2001, 9, 1);   % Start date: September 1, 2000
endDate = datetime(2004, 8, 1);    % End date: August 31, 2001

dates = startDate:calmonths(1):endDate;          % Create a sequence of dates

dates=dates';                       % Display the dates

pvalor=0.1; %cambiar aqui el pvalor
%% hacemos el LAG, dejamos inmovil las variables fisicas y movemos la pesca
%comenzamos con el caudal en Tamshiyacu
labels=Tamshi_pesca.Properties.VariableNames;
lala=Tamshi.Properties.VariableNames;
%C_Tamshi=table2array(Tamshi(:,1));

for ifloat=1:1:size(table2array(Tamshi),2)
for ii=1:1:size(table2array(Tamshi_pesca),2)
    TT2=timetable(dates,table2array(Tamshi_pesca(:,ii)));% esta es la que se mueve%pesca
    TT = timetable(dates,table2array(Tamshi(:,ifloat))); % este no se mueve
    disp([char(lala{ifloat}), ' vs ' ,char(cellstr(labels(ii)))])
    for ik=1:1:12
        TTlag = lag(TT,ik);
        %disp(TTlag)
        lag1=synchronize(TT2,TTlag);

        [R,P]=corrcoef(table2array(lag1),'Rows','complete','Alpha',pvalor);
        disp(['Lag + (',num2str(ik),') / ',num2str(R(2,1))])
        RR(ik,:)=R(2,1);
        PP(ik,:)=P(2,1);
    end
    R_pearson(:,ii)=RR;
    P_pearson(:,ii)=PP;

end
%%borramos los no significativos
P_pearson(P_pearson>=pvalor)=NaN;
masknan=~isnan(P_pearson);
R_p=R_pearson.*masknan;R_p(R_p==0)=NaN;


lab2={'Boquichico','Llambina','Palometa','Ractacara','Paiche'};
lags={'Lag +1','Lag +2','Lag +3','Lag +4','Lag +5','Lag +6','Lag +7','Lag +8',...
    'Lag +9','Lag +10','Lag +11','Lag +12'};

h=heatmap(round(R_p,2),'Colormap',parula); 
h.XDisplayLabels = lab2;
h.YDisplayLabels = lags; 
grid off
titname=string(['Año Modelo: ',lala{ifloat},' ', 'vs Pesca']);
title(titname);
figname=string(['Año Modelo_',lala{ifloat},'_05_', 'vs_Pesca','.png']);
pause(0.5)
%print(figname, '-dpng', '-r500');
clf

Rpearson{ifloat}=R_p;
end

%caudal%rain%sedimentos
%separamos por cada LAG
LAG1=cat(1,Rpearson{1,1}(1,:),Rpearson{1,2}(1,:), Rpearson{1,3}(1,:));
LAG2=cat(1,Rpearson{1,1}(2,:),Rpearson{1,2}(2,:), Rpearson{1,3}(2,:));
LAG3=cat(1,Rpearson{1,1}(3,:),Rpearson{1,2}(3,:), Rpearson{1,3}(3,:));
LAG4=cat(1,Rpearson{1,1}(4,:),Rpearson{1,2}(4,:), Rpearson{1,3}(4,:));
LAG5=cat(1,Rpearson{1,1}(5,:),Rpearson{1,2}(5,:), Rpearson{1,3}(5,:));
LAG6=cat(1,Rpearson{1,1}(6,:),Rpearson{1,2}(6,:), Rpearson{1,3}(6,:));
%% SAN REGIS

labels=SR_pesca.Properties.VariableNames;
lala=SanRegis.Properties.VariableNames;
%C_Tamshi=table2array(Tamshi(:,1));

for ifloat=1:1:size(table2array(SanRegis),2)
for ii=1:1:size(table2array(SR_pesca),2)
    TT2=timetable(dates,table2array(SR_pesca(:,ii)));% esta es la que se mueve%pesca
    TT = timetable(dates,table2array(SanRegis(:,ifloat))); % este no se mueve
    disp([char(lala{ifloat}), ' vs ' ,char(cellstr(labels(ii)))])
    for ik=1:1:12
        TTlag = lag(TT,ik);
        %disp(TTlag)
        lag1=synchronize(TT2,TTlag);

        [R,P]=corrcoef(table2array(lag1),'Rows','complete','Alpha',pvalor);
        disp(['Lag + (',num2str(ik),') / ',num2str(R(2,1))])
        RR(ik,:)=R(2,1);
        PP(ik,:)=P(2,1);
    end
    R_pearson(:,ii)=RR;
    P_pearson(:,ii)=PP;

end
%%borramos los no significativos
P_pearson(P_pearson>=pvalor)=NaN;
masknan=~isnan(P_pearson);
R_p=R_pearson.*masknan;R_p(R_p==0)=NaN;


lab2={'Boquichico','Llambina','Palometa','Ractacara','Paiche'};
lags={'Lag +1','Lag +2','Lag +3','Lag +4','Lag +5','Lag +6','Lag +7','Lag +8',...
    'Lag +9','Lag +10','Lag +11','Lag +12'};

h=heatmap(round(R_p,2),'Colormap',parula); 
h.XDisplayLabels = lab2;
h.YDisplayLabels = lags; 
grid off
titname=string(['Año Modelo: ',lala{ifloat},' ', 'vs Pesca']);
title(titname);
figname=string(['Año Modelo_',lala{ifloat},'_05_', 'vs_Pesca','.png']);
%print(figname, '-dpng', '-r500');
pause(0.5)
Rpearson{ifloat}=R_p;
clf
end

LAG1=cat(1,LAG1,Rpearson{1,1}(1,:),Rpearson{1,2}(1,:), Rpearson{1,3}(1,:));
LAG2=cat(1,LAG2,Rpearson{1,1}(2,:),Rpearson{1,2}(2,:), Rpearson{1,3}(2,:));
LAG3=cat(1,LAG3,Rpearson{1,1}(3,:),Rpearson{1,2}(3,:), Rpearson{1,3}(3,:));
LAG4=cat(1,LAG4,Rpearson{1,1}(4,:),Rpearson{1,2}(4,:), Rpearson{1,3}(4,:));
LAG5=cat(1,LAG5,Rpearson{1,1}(5,:),Rpearson{1,2}(5,:), Rpearson{1,3}(5,:));
LAG6=cat(1,LAG6,Rpearson{1,1}(6,:),Rpearson{1,2}(6,:), Rpearson{1,3}(6,:));

%% %% SAN REGIS

labels=Requena_pesca.Properties.VariableNames;
lala=Requena.Properties.VariableNames;
%C_Tamshi=table2array(Tamshi(:,1));

for ifloat=1:1:size(table2array(Requena),2)
for ii=1:1:size(table2array(Requena_pesca),2)
    TT2=timetable(dates,table2array(Requena_pesca(:,ii)));% esta es la que se mueve%pesca
    TT = timetable(dates,table2array(Requena(:,ifloat))); % este no se mueve
    disp([char(lala{ifloat}), ' vs ' ,char(cellstr(labels(ii)))])
    for ik=1:1:12
        TTlag = lag(TT,ik);
        disp(TTlag)
        lag1=synchronize(TT2,TTlag);

        [R,P]=corrcoef(table2array(lag1),'Rows','complete','Alpha',pvalor);
        disp(['Lag + (',num2str(ik),') / ',num2str(R(2,1))])
        RR(ik,:)=R(2,1);
        PP(ik,:)=P(2,1);
    end
    R_pearson(:,ii)=RR;
    P_pearson(:,ii)=PP;

end
%%borramos los no significativos >pvalor
P_pearson(P_pearson>=pvalor)=NaN;
masknan=~isnan(P_pearson);
R_p=R_pearson.*masknan;R_p(R_p==0)=NaN;


lab2={'Boquichico','Llambina','Palometa','Ractacara','Paiche'};
lags={'Lag +1','Lag +2','Lag +3','Lag +4','Lag +5','Lag +6','Lag +7','Lag +8',...
    'Lag +9','Lag +10','Lag +11','Lag +12'};

h=heatmap(round(R_p,2),'Colormap',parula); 
h.XDisplayLabels = lab2;
h.YDisplayLabels = lags; 
grid off
titname=string(['Año Modelo: ',lala{ifloat},' ', 'vs Pesca']);
title(titname);
figname=string(['Año Modelo_',lala{ifloat},'_05_', 'vs_Pesca','.png']);
Rpearson{ifloat}=R_p;
pause(0.5)
%print(figname, '-dpng', '-r500');
clf
end

LAG1=cat(1,LAG1,Rpearson{1,1}(1,:),Rpearson{1,2}(1,:), Rpearson{1,3}(1,:));
LAG2=cat(1,LAG2,Rpearson{1,1}(2,:),Rpearson{1,2}(2,:), Rpearson{1,3}(2,:));
LAG3=cat(1,LAG3,Rpearson{1,1}(3,:),Rpearson{1,2}(3,:), Rpearson{1,3}(3,:));
LAG4=cat(1,LAG4,Rpearson{1,1}(4,:),Rpearson{1,2}(4,:), Rpearson{1,3}(4,:));
LAG5=cat(1,LAG5,Rpearson{1,1}(5,:),Rpearson{1,2}(5,:), Rpearson{1,3}(5,:));
LAG6=cat(1,LAG6,Rpearson{1,1}(6,:),Rpearson{1,2}(6,:), Rpearson{1,3}(6,:));

%% exportamos los LAG
TLAG1=array2table(LAG1);
TLAG2=array2table(LAG2);
TLAG3=array2table(LAG3);
TLAG4=array2table(LAG4);
TLAG5=array2table(LAG5);
TLAG6=array2table(LAG6);


%caudal%rain%sedimentos
TLAG1.Properties.VariableNames=lab2;
TLAG2.Properties.VariableNames=lab2;
TLAG3.Properties.VariableNames=lab2;
TLAG4.Properties.VariableNames=lab2;
TLAG5.Properties.VariableNames=lab2;
TLAG6.Properties.VariableNames=lab2;
% T_clim.Properties.RowNames=cellstr(string(meses));

%% AGRUPAR POR ESPECIE
ij=1;
TBoqui=array2table(cat(2,table2array(TLAG1(:,ij)),table2array(TLAG2(:,ij)),...
    table2array(TLAG3(:,ij)),table2array(TLAG4(:,ij)),table2array(TLAG5(:,ij)),...
    table2array(TLAG6(:,ij))));

ij=2;
TLlam=array2table(cat(2,table2array(TLAG1(:,ij)),table2array(TLAG2(:,ij)),...
    table2array(TLAG3(:,ij)),table2array(TLAG4(:,ij)),table2array(TLAG5(:,ij)),...
    table2array(TLAG6(:,ij))));

ij=3;
TPal=array2table(cat(2,table2array(TLAG1(:,ij)),table2array(TLAG2(:,ij)),...
    table2array(TLAG3(:,ij)),table2array(TLAG4(:,ij)),table2array(TLAG5(:,ij)),...
    table2array(TLAG6(:,ij))));
ij=4;
TRact=array2table(cat(2,table2array(TLAG1(:,ij)),table2array(TLAG2(:,ij)),...
    table2array(TLAG3(:,ij)),table2array(TLAG4(:,ij)),table2array(TLAG5(:,ij)),...
    table2array(TLAG6(:,ij))));
ij=5;
TPai=array2table(cat(2,table2array(TLAG1(:,ij)),table2array(TLAG2(:,ij)),...
    table2array(TLAG3(:,ij)),table2array(TLAG4(:,ij)),table2array(TLAG5(:,ij)),...
    table2array(TLAG6(:,ij))));
%% 
my_file=['LAG2_pez.xlsx'];
writetable(TBoqui,my_file,'Sheet',1);
writetable(TLlam,my_file,'Sheet',2);
writetable(TPal,my_file,'Sheet',3);
writetable(TRact,my_file,'Sheet',4);
writetable(TPai,my_file,'Sheet',5);

%%
% my_file=['LAGS.xlsx'];
% writetable(TLAG1,my_file,'Sheet',1);
% writetable(TLAG2,my_file,'Sheet',2);
% writetable(TLAG3,my_file,'Sheet',3);
% writetable(TLAG4,my_file,'Sheet',4);
% writetable(TLAG5,my_file,'Sheet',5);
% writetable(TLAG6,my_file,'Sheet',6);
