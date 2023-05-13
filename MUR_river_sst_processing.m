%% SST MUR monthly average
load('MUR_SST_newloc.mat')

%% 
[yr,mo,da,hr]=datevec(double(time)+datenum(1970,1,1,0,0,0));
timeis=datenum(yr,mo,da);

[Y,M] = meshgrid(2003:2016, 1:12);
time2 = datenum([Y(:), M(:), ones(numel(Y),1)]);

%[yr,mo,da,hr,min,sec]=datevec(time2);

for ii=1:1:length(time2)
    if ii==length(time2)
        indxtime=find(timeis>=time2(ii));
    else
    indxtime=find(timeis>=time2(ii) & timeis<time2(ii+1));
    end
    disp(length(indxtime))
    date=timeis(indxtime(end));
    disp(datestr(date))
    sstis(:,:,ii)=nanmean(sst(:,:,indxtime),3); 
end
%% junio -1 dia
% julio - 1 dia
% diciembre - 2 dias
for jj=1:1:12
indxmo=find(mo==jj);
disp(length(indxmo))
end

%%
SR=[-73.906769,-4.513389];
TA=[-73.160656,-4.003975];
RE=[-73.851883,-5.077042];
BM=[-73.073369,-3.482239];

sstis2=sstis-273.15;
%% plot
for ii=1:1:length(time2)
    pcolor(lon,lat,sstis2(:,:,ii)');shading flat;
    %pcolor(lon(indxlon),lat(indxlat),sstis2(indxlon,indxlat,ii)');shading flat;

    hold on
    S=plot(SR(1),SR(2),'bd');hold on; T=plot(TA(1),TA(2),'k^');hold on; R=plot(RE(1),RE(2),'ro');
    hold on; B=plot(BM(1),BM(2),'g*'); colormap jet
    legend([S,T,R,B],{'San Regis','Tamshi','Requena','Be Mazan'},'Location','northwest');
    %caxis([20 25]);
    grid on
    title(datestr(time2(ii)));
    colorbar;
    pause(0.5)
    clf
end

    %% region 1 seleccionada / 72º30’E – 72º00’E y 3º30’S – 3º15ºS

region1=[-72.5 -72 -3.46 -3.2];

indxlat1=find(lat>=region1(3)& lat<=region1(4));
indxlon1=find(lon>=region1(1)&lon<=region1(2));

pcolor(lon(indxlon1),lat(indxlat1),sstis2(indxlon1,indxlat1,ii)');shading flat;

%% region 2 /3º59’S - 4º00’S y 70º16’E – 70º08’E (Frente a Tamshiyacu)

region2=[-70.2 -70.13 -4 -3.98];

indxlat2=find(lat>=region2(3)& lat<=region2(4));
indxlon2=find(lon>=region2(1)&lon<=region2(2));

pcolor(lon(indxlon2),lat(indxlat2),sstis2(indxlon2,indxlat2,ii)');shading flat;

%% region cerca al Napo /  3.42S - 3.45S y 73º00'E - 72.96E

region3=[-73 -72.96 -3.45 -3.42];

indxlat3=find(lat>=region3(3)& lat<=region3(4));
indxlon3=find(lon>=region3(1)&lon<=region3(2));
figure
pcolor(lon(indxlon3),lat(indxlat3),sstis2(indxlon3,indxlat3,ii)');shading flat;

%% extraemos la temp
for ij=1:1:length(time2)
    sst_MUR_reg1(ij,:)=nanmean(nanmean(sstis2(indxlon1,indxlat1,ij)));
    sst_MUR_reg2(ij,:)=nanmean(nanmean(sstis2(indxlon2,indxlat2,ij)));
    sst_MUR_reg3(ij,:)=nanmean(nanmean(sstis2(indxlon3,indxlat3,ij)));    
end

plot(time2,sst_MUR_reg1,'x--'); grid minor;
hold on
plot(time2,sst_MUR_reg2,'o:'); %grid minor;
hold on
plot(time2,sst_MUR_reg3,'d--'); %grid minor;
datetick('x'); title('MUR Temperatura superficial Agua');

legend('Region 1','Region 2','Region 3');

save('MUR_3_amazonas.mat','time2','sst_MUR_reg1','sst_MUR_reg2','sst_MUR_reg3');