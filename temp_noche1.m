%% Reading temperature from MODIS for the river
%Setting work directory
cd D:\trabajo\IGP\CLIM_PEZ\temp_agua_oceancolor\requested_files_1\requested_files

%% lets read the nigth
fn='nigth_temp.nc';

lon=double(ncread(fn,'lon'));
lat=double(ncread(fn,'lat'));
temp=double(ncread(fn,'sst'));

[Y,M] = meshgrid(2003:2015, 1:12);
time = datenum([Y(:), M(:), ones(numel(Y),1)]);

[yr,mo,da,hr,min,sec]=datevec(time);

%% plot 
SR=[-73.906769,-4.513389];
TA=[-73.160656,-4.003975];
RE=[-73.851883,-5.077042];


for ii=1:1:length(time)
    pcolor(lon,lat,temp(:,:,ii)');shading interp;
    title(datestr(time(ii)))
    hold on
    plot(SR(1),SR(2),'bd');hold on; plot(TA(1),TA(2),'k^');hold on; plot(RE(1),RE(2),'ro');
    pause(1)
    clf
end