clear all; close all; clc;
%%
cd D:\trabajo\IGP\CLIM_PEZ\Dra_Jaramillos\datos2
%% Temperatura

clear all; close all; clc;
%% 
cd D:\trabajo\IGP\CLIM_PEZ\Dra_Jaramillos\datos2
%% datos
[data,raw,j]=xlsread('temp_aire_to_temp_agua_simulation.xlsx','bd_minmaxTamshi');

%% ordenamos la data
datos_p=data(1:end,2:13);
datos_min=data(1:end,16:27);
datos_max=data(1:end,30:end);
%%
iter=0;
for iy=1971:1:2021
    iter=iter+1;
    jj=0;
    for ii=1:1:size(datos_p,2)
        jj=jj+1;
        pp(jj,:)=cat(2,iy,ii,datos_p(iter,ii));
        tmin(jj,:)=cat(2,iy,ii,datos_min(iter,ii));
        tmax(jj,:)=cat(2,iy,ii,datos_max(iter,ii));
    end
    PPm{iter,:}=pp;
    TTmin{iter,:}=tmin;
    TTmax{iter,:}=tmax;
end
%% 
TAp=cell2mat(PPm);
TAmin=cell2mat(TTmin);
TAmax=cell2mat(TTmax);

TApm=table(TAp(:,1),TAp(:,2),TAp(:,3),TAmin(:,3),TAmax(:,3));
TApm.Properties.VariableNames{3} = 'prom';
TApm.Properties.VariableNames{4} = 'min';
TApm.Properties.VariableNames{5} = 'max';

 my_file=['datos_ordenamos_TempAire.xlsx'];
writetable(TApm,my_file,'Sheet',1);



