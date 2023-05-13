clear all; close all; clc;
%%
cd D:\trabajo\IGP\CLIM_PEZ\Dra_Jaramillos\datos2

%% datos
[data_max,raw_max,j_max]=xlsread('CO_Tamshiyacu_D.xlsx','max_bd');
[data_min,raw_min,j_min]=xlsread('CO_Tamshiyacu_D.xlsx','min_bd');

%% 
datos_min=data_min(1:end,2:end);
datos_max=data_max(1:end,2:end);

%%
iter=0;
for iy=1971:1:2021
    iter=iter+1;
    jj=0;
    for ii=1:1:size(datos_min,2)
        jj=jj+1;
        %pp(jj,:)=cat(2,iy,ii,datos_p(iter,ii));
        tmin(jj,:)=cat(2,iy,ii,datos_min(iter,ii));
        tmax(jj,:)=cat(2,iy,ii,datos_max(iter,ii));
    end
    %PPm{iter,:}=pp;
    TTmin{iter,:}=tmin;
    TTmax{iter,:}=tmax;
end
%% 
%TAp=cell2mat(PPm);
TAmin=cell2mat(TTmin);
TAmax=cell2mat(TTmax);

TAm=table(TAmax(:,1),TAmax(:,2),TAmax(:,3),TAmin(:,3));
TAm.Properties.VariableNames{3} = 'max';
TAm.Properties.VariableNames{4} = 'min';
%TAm.Properties.VariableNames{5} = 'max';

 my_file=['datos_ordenamos_TempAire.xlsx'];
writetable(TAm,my_file,'Sheet',1);

%% Requena
clear all; close all; clc;
%% datos
[data_max,raw_max,j_max]=xlsread('CO Requena D.xlsx','bd_max');
[data_min,raw_min,j_min]=xlsread('CO Requena D.xlsx','bd_min');

%% 
datos_min=data_min(1:end,2:end);
datos_max=data_max(1:end,2:end);

%%
iter=0;
for iy=data_max(1,1):1:2021
    iter=iter+1;
    jj=0;
    for ii=1:1:size(datos_min,2)
        jj=jj+1;
        %pp(jj,:)=cat(2,iy,ii,datos_p(iter,ii));
        tmin(jj,:)=cat(2,iy,ii,datos_min(iter,ii));
        tmax(jj,:)=cat(2,iy,ii,datos_max(iter,ii));
    end
    %PPm{iter,:}=pp;
    TTmin{iter,:}=tmin;
    TTmax{iter,:}=tmax;
end
%% 
%TAp=cell2mat(PPm);
TAmin=cell2mat(TTmin);
TAmax=cell2mat(TTmax);

TAm=table(TAmax(:,1),TAmax(:,2),TAmax(:,3),TAmin(:,3));
TAm.Properties.VariableNames{3} = 'max';
TAm.Properties.VariableNames{4} = 'min';
%TAm.Properties.VariableNames{5} = 'max';

 my_file=['datos_ordenamos_TempAire.xlsx'];
writetable(TAm,my_file,'Sheet',2);

%% San Regis
clear all; close all; clc;
%% datos
[data_max,raw_max,j_max]=xlsread('PE San Regis D.xlsx','bd_max');
[data_min,raw_min,j_min]=xlsread('PE San Regis D.xlsx','bd_min');

%% 
datos_min=data_min(1:end,2:end);
datos_max=data_max(1:end,2:end);

%%
iter=0;
for iy=data_max(1,1):1:2021
    iter=iter+1;
    jj=0;
    for ii=1:1:size(datos_min,2)
        jj=jj+1;
        %pp(jj,:)=cat(2,iy,ii,datos_p(iter,ii));
        tmin(jj,:)=cat(2,iy,ii,datos_min(iter,ii));
        tmax(jj,:)=cat(2,iy,ii,datos_max(iter,ii));
    end
    %PPm{iter,:}=pp;
    TTmin{iter,:}=tmin;
    TTmax{iter,:}=tmax;
end
%% 
%TAp=cell2mat(PPm);
TAmin=cell2mat(TTmin);
TAmax=cell2mat(TTmax);

TAm=table(TAmax(:,1),TAmax(:,2),TAmax(:,3),TAmin(:,3));
TAm.Properties.VariableNames{3} = 'max';
TAm.Properties.VariableNames{4} = 'min';
%TAm.Properties.VariableNames{5} = 'max';

 my_file=['datos_ordenamos_TempAire.xlsx'];
writetable(TAm,my_file,'Sheet',3);
