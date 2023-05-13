load('Anomalias_temp.mat');
load('Data_Base_sst.mat');
%% ahora si los lags
t = datetime(newtime,'ConvertFrom','datenum');
%% %%%%%%%%%%%%%%%%%%%%%%%% Datos Normales %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TEMP dia(aguas LST) vs  
%%ahora intentemos el lag de Tmax fijo vs T dia que se mueve con lag +1
%tamshi_lag=
Temp_atm=MUR_temp(:,4:end);
labels=Temp_atm.Properties.VariableNames;

Temp_agua=MUR_temp(:,1:3);

for ii=1:1:size(table2array(Temp_atm),2)
    %T dia 
    TT2=timetable(t,table2array(Temp_atm(:,ii)));
    TT = timetable(t,MUR_temp.TEMPdia);
    % 
    disp(['Temp Dia vs ',cellstr(labels(ii))])
    for ik=1:1:12
        TTlag = lag(TT,ik);

        lag1=synchronize(TT2,TTlag);

        [R,P]=corrcoef(table2array(lag1),'Rows','complete','Alpha',0.1);
        disp(['Lag + (',num2str(ik),') / ',num2str(R(2,1))])
        RR(ik,:)=R(2,1);
        PP(ik,:)=P(2,1);
    end
    R_pearson(:,ii)=RR;
    P_pearson(:,ii)=PP;
end

% rtable=array2table(R_pearson);
% rtable.Properties.VariableNames=labels;
%pcolor(R_pearson); shading flat; colormap jet; colorbar;
lags={'Lag +1','Lag +2','Lag +3','Lag +4','Lag +5','Lag +6','Lag +7','Lag +8',...
    'Lag +9','Lag +10','Lag +11','Lag +12'};
h=heatmap(R_pearson,'Colormap',jet); 
h.XDisplayLabels = labels;
h.YDisplayLabels = lags; 
grid off
title('Temperatura Dia (LST/MODIS) vs Temperatura Atmosferica');

%% %% TEMP Noche(aguas LST) vs  
%%ahora intentemos el lag de Tmax fijo vs T dia que se mueve con lag +1
%tamshi_lag=
Temp_atm=MUR_temp(:,4:end);
labels=Temp_atm.Properties.VariableNames;

Temp_agua=MUR_temp(:,1:3);

for ii=1:1:size(table2array(Temp_atm),2)
    %T dia 
    TT2=timetable(t,table2array(Temp_atm(:,ii)));
    TT = timetable(t,MUR_temp.TEMPnoche);
    % 
    disp(['Temp Noche vs ',cellstr(labels(ii))])
    for ik=1:1:12
        TTlag = lag(TT,ik);

        lag1=synchronize(TT2,TTlag);

        [R,P]=corrcoef(table2array(lag1),'Rows','complete');
        disp(['Lag + (',num2str(ik),') / ',num2str(R(2,1))])
        RR(ik,:)=R(2,1);
        PP(ik,:)=P(2,1);
    end
    R_pearson(:,ii)=RR;
    P_pearson(:,ii)=PP;
end

lags={'Lag +1','Lag +2','Lag +3','Lag +4','Lag +5','Lag +6','Lag +7','Lag +8',...
    'Lag +9','Lag +10','Lag +11','Lag +12'};
h=heatmap(R_pearson,'Colormap',jet); 
h.XDisplayLabels = labels;
h.YDisplayLabels = lags; 
grid off
title('Temperatura Noche (LST/MODIS) vs Temperatura Atmosferica');
%% %% TEMP Prom(aguas LST) vs  
%%ahora intentemos el lag de Tmax fijo vs T dia que se mueve con lag +1
%tamshi_lag=
Temp_atm=MUR_temp(:,4:end);
labels=Temp_atm.Properties.VariableNames;

Temp_agua=MUR_temp(:,1:3);

for ii=1:1:size(table2array(Temp_atm),2)
    %T dia 
    TT2=timetable(t,table2array(Temp_atm(:,ii)));
    TT = timetable(t,MUR_temp.TempProm);
    % 
    disp(['Temp Prom vs ',cellstr(labels(ii))])
    for ik=1:1:12
        TTlag = lag(TT,ik);

        lag1=synchronize(TT2,TTlag);

        [R,P]=corrcoef(table2array(lag1),'Rows','complete');
        disp(['Lag + (',num2str(ik),') / ',num2str(R(2,1))])
        RR(ik,:)=R(2,1);
        PP(ik,:)=P(2,1);
    end
    R_pearson(:,ii)=RR;
    P_pearson(:,ii)=PP;
end

lags={'Lag +1','Lag +2','Lag +3','Lag +4','Lag +5','Lag +6','Lag +7','Lag +8',...
    'Lag +9','Lag +10','Lag +11','Lag +12'};
h=heatmap(R_pearson,'Colormap',jet); 
h.XDisplayLabels = labels;
h.YDisplayLabels = lags; 
grid off
title('Temperatura Promedio (LST/MODIS) vs Temperatura Atmosferica');
%% %%%%%%%%%%%%%%%%%%%%%%%% Anomalias %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Anom TEMP dia(aguas LST) vs  Anom Puertos
%%ahora intentemos el lag de Tmax fijo vs T dia que se mueve con lag +1
%tamshi_lag=
Temp_atm=Tanom(:,4:end);
labels=Temp_atm.Properties.VariableNames;

Temp_agua=Tanom(:,1:3);

for ii=1:1:size(table2array(Temp_atm),2)
    %T dia 
    TT2=timetable(t,table2array(Temp_atm(:,ii)));
    TT = timetable(t,Tanom.TEMPdia);
    % 
    disp(['Anom Temp Dia vs ',cellstr(labels(ii))])
    for ik=1:1:12
        TTlag = lag(TT,ik);

        lag1=synchronize(TT2,TTlag);

        [R,P]=corrcoef(table2array(lag1),'Rows','complete');
        disp(['Lag + (',num2str(ik),') / ',num2str(R(2,1))])
        RR(ik,:)=R(2,1);
        PP(ik,:)=P(2,1);
    end
    R_pearson(:,ii)=RR;
    P_pearson(:,ii)=PP;
end

lags={'Lag +1','Lag +2','Lag +3','Lag +4','Lag +5','Lag +6','Lag +7','Lag +8',...
    'Lag +9','Lag +10','Lag +11','Lag +12'};
h=heatmap(R_pearson,'Colormap',jet); 
h.XDisplayLabels = labels;
h.YDisplayLabels = lags; 
grid off
title('Anomalia Temperatura Dia (LST/MODIS) vs Anomalia Temperatura Atmosferica');

%% Anom TEMP noche(aguas LST) vs  Anom Puertos
%%ahora intentemos el lag de Tmax fijo vs T dia que se mueve con lag +1
%tamshi_lag=
Temp_atm=Tanom(:,4:end);
labels=Temp_atm.Properties.VariableNames;

Temp_agua=Tanom(:,1:3);

for ii=1:1:size(table2array(Temp_atm),2)
    %T dia 
    TT2=timetable(t,table2array(Temp_atm(:,ii)));
    TT = timetable(t,Tanom.TEMPnoche);
    % 
    disp(['Anom Temp Noche vs ',cellstr(labels(ii))])
    for ik=1:1:12
        TTlag = lag(TT,ik);

        lag1=synchronize(TT2,TTlag);

        [R,P]=corrcoef(table2array(lag1),'Rows','complete');
        disp(['Lag + (',num2str(ik),') / ',num2str(R(2,1))])
        RR(ik,:)=R(2,1);
        PP(ik,:)=P(2,1);
    end
    R_pearson(:,ii)=RR;
    P_pearson(:,ii)=PP;
end

lags={'Lag +1','Lag +2','Lag +3','Lag +4','Lag +5','Lag +6','Lag +7','Lag +8',...
    'Lag +9','Lag +10','Lag +11','Lag +12'};
h=heatmap(R_pearson,'Colormap',jet); 
h.XDisplayLabels = labels;
h.YDisplayLabels = lags; 
grid off
title('Anomalia Temperatura Noche (LST/MODIS) vs Anomalia Temperatura Atmosferica');


%% Anom TEMP prom(aguas LST) vs  Anom Puertos
%%ahora intentemos el lag de Tmax fijo vs T dia que se mueve con lag +1
%tamshi_lag=
Temp_atm=Tanom(:,4:end);
labels=Temp_atm.Properties.VariableNames;

Temp_agua=Tanom(:,1:3);

for ii=1:1:size(table2array(Temp_atm),2)
    %T dia 
    TT2=timetable(t,table2array(Temp_atm(:,ii)));
    TT = timetable(t,Tanom.TempProm);
    % 
    disp(['Anom Temp Prom vs ',cellstr(labels(ii))])
    for ik=1:1:12
        TTlag = lag(TT,ik);

        lag1=synchronize(TT2,TTlag);

        [R,P]=corrcoef(table2array(lag1),'Rows','complete');
        disp(['Lag + (',num2str(ik),') / ',num2str(R(2,1))])
        RR(ik,:)=R(2,1);
        PP(ik,:)=P(2,1);        
    end
    R_pearson(:,ii)=RR;
    P_pearson(:,ii)=PP;
end

lags={'Lag +1','Lag +2','Lag +3','Lag +4','Lag +5','Lag +6','Lag +7','Lag +8',...
    'Lag +9','Lag +10','Lag +11','Lag +12'};
h=heatmap(R_pearson,'Colormap',jet); 
h.XDisplayLabels = labels;
h.YDisplayLabels = lags; 
grid off
title('Anomalia Temperatura Promedio (LST/MODIS) vs Anomalia Temperatura Atmosferica');
