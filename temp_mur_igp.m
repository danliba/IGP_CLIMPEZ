%%%
%seconds since 1981-01-01 00:00:00 UTC
%%
fn='m-200301.nc';
lon=double(ncread(fn,'lon'));
lat=double(ncread(fn,'lat'));
sst=double(ncread(fn,'analysed_sst'));

time=double(ncread(fn,'time'))./86400;
[yr,mo,da,hr]=datevec(double(time)+datenum(1981,1,1,0,0,0));

sst=sst-273.15;
sst2=nanmean(sst,3);
%% 
SR=[-73.906769,-4.513389];
TA=[-73.160656,-4.003975];
RE=[-73.851883,-5.077042];
BM=[-73.073369,-3.482239];
%% plot
for ii=1:1:length(time)
    pcolor(lon,lat,sst(:,:,ii)');shading flat;
    hold on
    S=plot(SR(1),SR(2),'bd');hold on; T=plot(TA(1),TA(2),'k^');hold on; R=plot(RE(1),RE(2),'ro');
    hold on; B=plot(BM(1),BM(2),'g*');
    %legend([S,T,R,B],'San Regis','Tamshi','Requena','Be Mazan');
    grid on
    title(datestr(datenum(yr(ii),mo(ii),da(ii))));
    colorbar;
    pause(0.5)
    clf
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% podaac-data-downloader -c MUR-JPL-L4-GLOB-v4.1 -d D:/trabajo/IGP/CLIM_PEZ/temp_agua_oceancolor -sd 2004-01-01T00:00:00Z -ed 2004-01-01T00:00:00Z -b="-79,-7,-70,-3" 
% 
% podaac-data-downloader -c MUR-JPL-L4-GLOB-v4.1 -d D:/trabajo/IGP/CLIM_PEZ/temp_agua_oceancolor -sd 2021-01-01T00:00:00Z -ed 2021-01-03T00:00:00Z -b="-90,-10,-70,-5" 
%
%cortar region [-75,-72,-3,-6]

%% %%%%% Reanalysis CMEMS
fn='temp_copernicus_reanalysis.nc';
lon=double(ncread(fn,'longitude'));
lat=double(ncread(fn,'latitude'));
sst=double(ncread(fn,'thetao'));

time=double(ncread(fn,'time'))./24;
[yr,mo,da,hr]=datevec(double(time)+datenum(1950,1,1,0,0,0));

sst2=permute(sst,[1 2 4 3]);
%sst2=nanmean(sst2,3);
%% 
SR=[-73.906769,-4.513389];
TA=[-73.160656,-4.003975];
RE=[-73.851883,-5.077042];
BM=[-73.073369,-3.482239];
%% plot
figure
for ii=1:1:length(time)
    pcolor(lon,lat,sst2(:,:,ii)');shading flat;
    hold on
    S=plot(SR(1),SR(2),'bd');hold on; T=plot(TA(1),TA(2),'k^');hold on; R=plot(RE(1),RE(2),'ro');
    hold on; B=plot(BM(1),BM(2),'g*');
    legend([S,T,R,B],'San Regis','Tamshi','Requena','Be Mazan');
    grid on
    title(datestr(datenum(yr(ii),mo(ii),da(ii))));
    pause(0.5)
    clf
end
