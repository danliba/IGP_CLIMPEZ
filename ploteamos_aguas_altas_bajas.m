%% vamos a plotear aguas bajas y aguas altas 
clear all; close all; clc;
cd D:\trabajo\IGP\CLIM_PEZ\Variables_ordenadas\mensual
%% 
fn1='aguas_altas_bajas_plot.xlsx';
[status,sheets] = xlsfinfo(fn1);

[numData1, textData1, raw1] = xlsread(fn1, char(sheets(1)),'A1:K15'); %IQUITOS
[numData2, textData2, raw2] = xlsread(fn1, char(sheets(2)),'A1:K15'); %NAUTA
[numData3, textData3, raw3] = xlsread(fn1, char(sheets(3)),'A1:K15'); %REQUENA

%% PLOTEAMOS
%floods: 2009, 2012
%droughts: 2005, 2010, 2015 due to el NIÑO
%IQUITOS
species={'Boquichico','Llambina','Palometa','Ractacara','Paiche','Total'};
arr= ones(52, 1); 
arr(arr==1)=10000;

index0=[2,4,6,8,10];%aguas altas
index1=index0+1; %aguas bajas
altas=sum(numData1(:,index0),2,'omitnan'); bajas=sum(numData1(:,index1),2,'omitnan');
numData1(:,12:13)=cat(2,altas,bajas);

index0=[2,4,6,8,10,12];

figure
jj=0;
for ij=1:1:6
    jj=jj+1;

subplot(3,2,ij)
plot(numData1(:,1),numData1(:,index0(jj)),'r-s'); 
hold on
plot(numData1(:,1),numData1(:,index0(jj)+1),'b-^');
hold on
bar(2005,arr, 'FaceColor', [0.9 0.9 0.9], 'EdgeColor', 'none','FaceAlpha', 0.5);
hold on
bar(2010,arr, 'FaceColor', [0.9 0.9 0.9], 'EdgeColor', 'none','FaceAlpha', 0.5);
hold on
bar(2009,arr, 'FaceColor', [0.6 0.8 1], 'EdgeColor', 'none', 'FaceAlpha', 0.2);
hold on
bar(2012,arr, 'FaceColor', [0.6 0.8 1], 'EdgeColor', 'none', 'FaceAlpha', 0.2);
set(gca,'xtick',[2002:1:2015],'xticklabel',[2002:1:2015],'xlim',[2002 2015]);
disp(index0(jj))
%maximo valor
maxi=max(max(numData1(:,index0(jj):index0(jj)+1)));
title(species(ij))
ylim([0 maxi]);
grid on
legend('Aguas Altas','Aguas Bajas')
end

%% PLOTEAMOS NAUTA
%floods: 2009, 2012
%droughts: 2005, 2010, 2015 due to el NIÑO
%IQUITOS
species={'Boquichico','Llambina','Palometa','Ractacara','Paiche','Total'};
arr= ones(52, 1); 
arr(arr==1)=10000;

index0=[2,4,6,8,10];%aguas altas
index1=index0+1; %aguas bajas
altas=sum(numData2(:,index0),2,'omitnan'); bajas=sum(numData2(:,index1),2,'omitnan');
numData2(:,12:13)=cat(2,altas,bajas);

index0=[2,4,6,8,10,12];

figure
jj=0;
for ij=1:1:6
    jj=jj+1;

subplot(3,2,ij)
plot(numData2(:,1),numData2(:,index0(jj)),'r-s'); 
hold on
plot(numData2(:,1),numData2(:,index0(jj)+1),'b-^');
hold on
bar(2005,arr, 'FaceColor', [0.9 0.9 0.9], 'EdgeColor', 'none','FaceAlpha', 0.5);
hold on
bar(2010,arr, 'FaceColor', [0.9 0.9 0.9], 'EdgeColor', 'none','FaceAlpha', 0.5);
hold on
bar(2009,arr, 'FaceColor', [0.6 0.8 1], 'EdgeColor', 'none', 'FaceAlpha', 0.2);
hold on
bar(2012,arr, 'FaceColor', [0.6 0.8 1], 'EdgeColor', 'none', 'FaceAlpha', 0.2);
set(gca,'xtick',[2002:1:2015],'xticklabel',[2002:1:2015],'xlim',[2002 2015]);
disp(index0(jj))
%maximo valor
maxi=max(max(numData2(:,index0(jj):index0(jj)+1)));
title(species(ij))
ylim([0 maxi]);
grid on
legend('Aguas Altas','Aguas Bajas')
end

%% %% PLOTEAMOS REQUENA
%floods: 2009, 2012
%droughts: 2005, 2010, 2015 due to el NIÑO
%IQUITOS
species={'Boquichico','Llambina','Palometa','Ractacara','Paiche','Total'};
arr= ones(52, 1); 
arr(arr==1)=10000;

index0=[2,4,6,8,10];%aguas altas
index1=index0+1; %aguas bajas
altas=sum(numData3(:,index0),2,'omitnan'); bajas=sum(numData3(:,index1),2,'omitnan');
numData3(:,12:13)=cat(2,altas,bajas);

index0=[2,4,6,8,10,12];

figure
jj=0;
for ij=1:1:6
    jj=jj+1;

subplot(3,2,ij)
plot(numData3(:,1),numData3(:,index0(jj)),'r-s'); 
hold on
plot(numData3(:,1),numData3(:,index0(jj)+1),'b-^');
hold on
bar(2005,arr, 'FaceColor', [0.9 0.9 0.9], 'EdgeColor', 'none','FaceAlpha', 0.5);
hold on
bar(2010,arr, 'FaceColor', [0.9 0.9 0.9], 'EdgeColor', 'none','FaceAlpha', 0.5);
hold on
bar(2009,arr, 'FaceColor', [0.6 0.8 1], 'EdgeColor', 'none', 'FaceAlpha', 0.2);
hold on
bar(2012,arr, 'FaceColor', [0.6 0.8 1], 'EdgeColor', 'none', 'FaceAlpha', 0.2);
set(gca,'xtick',[2002:1:2015],'xticklabel',[2002:1:2015],'xlim',[2002 2015]);
disp(index0(jj))
%maximo valor
maxi=max(max(numData3(:,index0(jj):index0(jj)+1)));
title(species(ij))
ylim([0 maxi]);
grid on
legend('Aguas Altas','Aguas Bajas')
end