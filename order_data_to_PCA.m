%% IGP trabajo reordenamos la matriz de los datos

[data,raw,jj]=xlsread('datos_reordenar.xlsx ','Hoja1');
%% tiempo
iter=0;
for ii=2:1:length(raw(2:end,1))+1
    iter=iter+1;
    year(iter,1)=str2num(raw{ii,1});
end

ppmensual=data(:,1);%PP mensual
tempDia=data(:,2);%tempdia
tempNoche=data(:,3);%tempNoche


Requena=cat(2,year,ppmensual,tempDia,tempNoche,data(:,4),data(:,8),data(:,10),...
    data(:,14),data(:,16),data(:,19),data(:,22));

Tam_Iqui=cat(2,year,ppmensual,tempDia,tempNoche,data(:,6),data(:,7),data(:,12),...
    data(:,15),data(:,18),data(:,21),data(:,24)); %Tamshiyacu-Iquitos

Yu_chiz=cat(2,year,ppmensual,tempDia,tempNoche,data(:,5),data(:,9),...
    data(:,11),data(:,13),data(:,17),data(:,20),data(:,23));
%no hay sedimentos en yurimaguas, pero si en chazuta%Yurimaguas-Chizuta

%%%%%%%%%%%%Precipitacion%%temp%%
%requena
%tamshiyacu
%yurimaguas
    iter=0;
for ij=1:1:length(year)
    T=table(cat(1,Requena(ij,:),Tam_Iqui(ij,:),Yu_chiz(ij,:)));
    my_file=['Entry_data.xlsx'];
    iter=iter+1;
    writetable(T,my_file,'Sheet',iter);
    disp('data writen')
end
%% otra forma de PCA

for ik=1:1:length(year)
    TT{ik,1}=cat(1,Requena(ik,:),Tam_Iqui(ik,:),Yu_chiz(ik,:));
end

data_TT=table(cell2mat(TT));
writetable(data_TT,'TOTAL_PCA.xlsx','Sheet',1);


