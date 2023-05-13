cd D:\trabajo\IGP\CLIM_PEZ\Dra_Jaramillos\datos2
%% Temperatura
%% datos
[data,raw,j]=xlsread('datos_ordenamos_TempAire.xlsx','anual_Rean');

%% table
labels=j(1,2:end);
TRE=array2table(data(:,2:end));

for ii=1:1:length(labels)
    TRE.Properties.VariableNames{ii} = char(labels(ii));
end

%%
corrplot(TRE)

%% %% Temperatura 2
%% datos
[data2,raw2,j2]=xlsread('datos_ordenamos_TempAire.xlsx','anual_atm');

%% table
labels2=j2(1,2:end);
TAm=array2table(data2(:,2:end));

for ii=1:1:length(labels)
    TAm.Properties.VariableNames{ii} = char(labels(ii));
end

%%
corrplot(TAm)

