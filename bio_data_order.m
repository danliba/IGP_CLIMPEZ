%% Ordenar data de pesca amazonas
clear all; close all; clc;
%% wd
cd D:\trabajo\IGP\CLIM_PEZ\Estadistica_Mensual_DIREPRO_2000_2020-20230310T225135Z-001\Estadistica_Mensual_DIREPRO_2000_2020\2002
%% data
path01='D:\trabajo\IGP\CLIM_PEZ\Estadistica_Mensual_DIREPRO_2000_2020-20230310T225135Z-001\Estadistica_Mensual_DIREPRO_2000_2020\2002';
hdir=dir(fullfile(path01,'EST*.xlsx'));
%%
for ifloat=1:1:size(hdir,1)
    fname=hdir(ifloat).name;
disp(ifloat)
[data,raw,j]=xlsread(fname,'EXTRAC. N°1');

    for kk=1:1:length(j)
        b = cellfun(@isnan,j(kk,2),'UniformOutput',false);
        bb(kk,1)=double(b{1,1}(1));
    end

    indx_extract=find(bb==0);
    aj=j(indx_extract,:);

%% encontramos la fecha
    mo=month(char(fname(13:15)),"mmmm");
    yr=str2num(path01(end-3:end));
    time=datenum(yr,mo,1);
    disp(datestr(time))
%% encontremos total y especies
for ii=2:1:length(aj)
    aa=strcmp(aj{ii,1},'TOTAL');
    aa2=strcmp(aj{ii,1},'ESPECIES');
    aa3=strcmp(aj{ii,1},'OTROS');
    aa4=strcmp(aj{ii,1},'PAÑA');
    
    if aa==1
    indx_b{ii,1}=ii;
    end
    
    if aa2==1
    indx_b{ii,1}=ii;
    end
    
    if aa3==1
    indx_b{ii,1}=ii;
    end
    
    if aa4==1
    indx_b{ii,1}=ii;
    end  
    
end

indx_break=cell2mat(indx_b);
%% borramos total y especies
aj(indx_break,:)=[];
%% ahora hacemos una tabla por cada puerto

puertos=[aj(1,2:end-1)];
especies0=[aj(2:end,1)];

for ik=1:1:length(especies0)
    especies_name=split(cellstr([aj(ik+1,1)])," ");
    
    ab=strcmp(especies_name{1,1},'ZUNGARO');
    if ab==1
       especies(ik,:)=especies_name(2,1);
    else
    especies(ik,:)=especies_name(1,1);
    end
end

datos=aj(2:end,2:end);
datos=cell2mat(datos);
ii=1;
%for ii=1:1:length(puertos)
    for k=1:1:length(especies)
        data_cat=cat(2,time,datos(k,ii));
        %data_2=cell2mat(data_cat);
        my_field=char(especies{k});
        nombre=char(puertos(ii));
        %disp([nombre,' ', char(especies{k})])
        IQUITOS.(my_field)= data_cat;
    end
    T=struct2table(IQUITOS);
    disp(T)
    
    A(:,:,ifloat)=cell2mat(struct2cell(IQUITOS));
    %now we sort from january to last month
    %C=sort(A,3);
end
%end
    B=squeeze(A(1,1,:));
   [C,Indx]=sort(B);
    D=A(:,:,Indx);
%% tabla

save('Bio2002','D','especies');


%T=struct2table(esp);