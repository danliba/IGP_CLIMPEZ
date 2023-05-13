clear all; close all; clc
cd D:\trabajo\IGP\CLIM_PEZ\temp_agua_oceancolor\MUR\new_location

%% 
path01='D:\trabajo\IGP\CLIM_PEZ\temp_agua_oceancolor\MUR\new_location';
hdir=dir(fullfile(path01,'*.nc'));

for imur=1:1:size(hdir,1)
    fn=hdir(imur).name;
    if imur==1
    lon=double(ncread(fn,'longitude'));
    lat=double(ncread(fn,'latitude'));
    end
    sst(:,:,imur)=double(ncread(fn,'analysed_sst'))+273.15;

    time(imur,:)=double(ncread(fn,'time'))./86400;
    disp([fn,' done'])
end

[yr,mo,da,hr]=datevec(double(time)+datenum(1970,1,1,0,0,0));

%% 2991,  3083

plot(time);grid on;
%%
save('MUR_SST_newloc.mat','lat','lon','sst','time', '-v7.3')