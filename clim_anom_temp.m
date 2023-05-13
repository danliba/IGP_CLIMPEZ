%% let's find all the correlations
clear all;close all; clc
load('Data_Base_sst.mat');

%% Lags 

[yr,mo,da,hr]=datevec(double(newtime));

%% climato indx
for ii=1:1:12
    indxclim(:,ii)=find(mo==ii);
end

%% climatologias
%B = num2cell(mur,1);

temp_dia=mur(:,1); temp_noche=mur(:,2); temp_prom=mur(:,3);
tam_tp=mur(:,4); tam_tmax=mur(:,5); tam_tmin=mur(:,6);
req_tp=mur(:,7); req_tmax=mur(:,8); reqtmin=mur(:,9);
sr_tp=mur(:,10); sr_tmax=mur(:,11); sr_tmin=mur(:,12);
tam_RA_tp=mur(:,13); req_RA_tp=mur(:,14); sr_RA_tp=mur(:,15);
sst_mur=mur(:,16);

for ij=1:1:12
    Temp_dia_clim(ij,:)=nanmean(temp_dia(indxclim(:,ij)));
    temp_noche_clim(ij,:)=nanmean(temp_noche(indxclim(:,ij)));
    temp_prom_clim(ij,:)=nanmean(temp_prom(indxclim(:,ij)));
    tam_tp_clim(ij,:)=nanmean(tam_tp(indxclim(:,ij)));
    tam_tmax_clim(ij,:)=nanmean(tam_tmax(indxclim(:,ij)));
    tam_tmin_clim(ij,:)=nanmean(tam_tmin(indxclim(:,ij)));
    req_tp_clim(ij,:)=nanmean(req_tp(indxclim(:,ij)));
    
    req_tmax_clim(ij,:)=nanmean(req_tmax(indxclim(:,ij)));
    reqtmin_clim(ij,:)=nanmean(reqtmin(indxclim(:,ij)));
    
    sr_tp_clim(ij,:)=nanmean(sr_tp(indxclim(:,ij)));
    sr_tmax_clim(ij,:)=nanmean(sr_tmax(indxclim(:,ij)));
    sr_tmin_clim(ij,:)=nanmean(sr_tmin(indxclim(:,ij)));
    
    tam_RA_tp_clim(ij,:)=nanmean(tam_RA_tp(indxclim(:,ij)));
    req_RA_tp_clim(ij,:)=nanmean(req_RA_tp(indxclim(:,ij)));
    sr_RA_tp_clim(ij,:)=nanmean(sr_RA_tp(indxclim(:,ij)));
    sst_mur_clim(ij,:)=nanmean(sst_mur(indxclim(:,ij)));

end

%% anomalias

yrst=yr(1);
yren=yr(end);
most=1;
moen=12;
moen0=moen;
iter=0;

for iy=yrst:1:yren
    if iy>yrst
        most=1;
    end
    
    if iy==yren
        moen=moen0;
        
    else
        moen=12;
    end
    
    for im=most:1:moen
        iter=iter+1;

            indx01=find(yr==iy&mo==im);
            temp1=temp_dia(indx01);
            temp2=temp_noche(indx01);
            temp3=temp_prom(indx01);
            temp4=tam_tp(indx01);
            temp5=tam_tmax(indx01);
            temp6=tam_tmin(indx01);
            temp7=req_tp(indx01);
            temp8=req_tmax(indx01);
            temp9=reqtmin(indx01);
            temp10=sr_tp(indx01);
            temp11=sr_tmax(indx01);
            temp12=sr_tmin(indx01);
            temp13=tam_RA_tp(indx01);
            temp14=req_RA_tp(indx01);
            temp15=sr_RA_tp(indx01);
            temp16=sst_mur(indx01);
            
            temp_dia_anom(iter,:)=temp1-Temp_dia_clim(im);
            temp_noche_anom(iter,:)=temp2-temp_noche_clim(im);
            temp_prom_anom(iter,:)=temp3-temp_prom_clim(im);
            tam_tp_anom(iter,:)=temp4-tam_tp_clim(im);
            tam_tmax_anom(iter,:)=temp5-tam_tmax_clim(im);
            tam_tmin_anom(iter,:)=temp6-tam_tmin_clim(im);
            req_tp_anom(iter,:)=temp7-req_tp_clim(im);
            req_max_anom(iter,:)=temp8-req_tmax_clim(im);
            reqtmin_anom(iter,:)=temp9-reqtmin_clim(im);
            sr_tp_anom(iter,:)=temp10-sr_tp_clim(im);
            sr_tmax_anom(iter,:)=temp11-sr_tmax_clim(im);
            sr_tmin_anom(iter,:)=temp12-sr_tmin_clim(im);
            tam_RA_tp_anom(iter,:)=temp13-tam_RA_tp_clim(im);
            req_RA_tp_anom(iter,:)=temp14-req_RA_tp_clim(im);
            sr_RA_tp_anom(iter,:)=temp15-sr_RA_tp_clim(im);
            sst_mur_anom(iter,:)=temp16-sst_mur_clim(im);
         end  
    
end

%sr_tp=mur(:,10); sr_tmax=mur(:,11); sr_tmin=mur(:,12);

%% cat the anomalies


anom_total=cat(2,temp_dia_anom,temp_noche_anom,temp_prom_anom,tam_tp_anom,tam_tmax_anom,...
    tam_tmin_anom,req_tp_anom,req_max_anom,reqtmin_anom,sr_tp_anom,sr_tmax_anom,...
    sr_tmin_anom,tam_RA_tp_anom,req_RA_tp_anom,sr_RA_tp_anom,sst_mur_anom);


%% 
Tanom=array2table(anom_total);
Tanom.Properties.VariableNames=MUR_temp.Properties.VariableNames;
labels=MUR_temp.Properties.VariableNames;
%% 
[R,P]=corrcoef(anom_total,'Rows','complete');
%corrplot(TAm);

isupper = logical(triu(ones(size(R)),1));
R(isupper) = NaN;

P(P>0.1)=NaN;
PP=~isnan(P);
RR=R.*PP;
RR(RR==0)=NaN;
%% 
h = heatmap(RR,'MissingDataColor','w','Colormap',cool);
h.XDisplayLabels = labels;  
h.YDisplayLabels = labels; 
grid off
 
%% sin pvalue significativo
h = heatmap(R,'MissingDataColor','w','Colormap',jet);
h.XDisplayLabels = labels;
h.YDisplayLabels = labels; 
grid off

%% save anomalies
save('Anomalias_temp.mat','newtime','Tanom','anom_total')
