clear all; close all; clc
cd D:\trabajo\IGP\CLIM_PEZ\temp_agua_oceancolor\MUR\cuted

%% 
path01='D:\trabajo\IGP\CLIM_PEZ\temp_agua_oceancolor\MUR\cuted';
hdir=dir(fullfile(path01,'c*.nc'));

for imur=1:1:size(hdir,1)
    fn=hdir(imur).name;
    if imur==1
    lon=double(ncread(fn,'lon'));
    lat=double(ncread(fn,'lat'));
    end
    sst(:,:,imur)=double(ncread(fn,'analysed_sst'));

    time(imur,:)=double(ncread(fn,'time'))./86400;
    disp([fn,' done'])
end

[yr,mo,da,hr]=datevec(double(time)+datenum(1981,1,1,0,0,0));

%% 2991,  3083

plot(time);grid on;
%%
save('MUR_SST.mat','lat','lon','sst','time', '-v7.3')