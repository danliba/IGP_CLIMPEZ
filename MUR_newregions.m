clear all; close all; clc
cd D:\trabajo\IGP\CLIM_PEZ\temp_agua_oceancolor\MUR\new_location

%% 
fn='2003-01-03.nc';

lon=double(ncread(fn,'longitude'));
lat=double(ncread(fn,'latitude'));
sst=double(ncread(fn,'analysed_sst'));
time=double(ncread(fn,'time'))./86400;

[yr,mo,da,hr]=datevec(double(time)+datenum(1970,1,1,0,0,0));


SR=[-73.906769,-4.513389];
TA=[-73.160656,-4.003975];
RE=[-73.851883,-5.077042];
BM=[-73.073369,-3.482239];

time=datenum(yr,mo,da);
%% 

pcolor(lon,lat,sst');shading flat;
%pcolor(lon(indxlon),lat(indxlat),sstis2(indxlon,indxlat,ii)');shading flat;

hold on
S=plot(SR(1),SR(2),'bd');hold on; T=plot(TA(1),TA(2),'k^');hold on; R=plot(RE(1),RE(2),'ro');
hold on; B=plot(BM(1),BM(2),'g*'); colormap jet
legend([S,T,R,B],{'San Regis','Tamshi','Requena','Be Mazan'},'Location','northwest');
%caxis([20 25]);
grid on
title(datestr(time(1)));
colorbar;


%% 