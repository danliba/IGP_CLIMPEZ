%% plot all climato juntos
label={'Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Set','Oct','Nov','Dic'};

figure
P=get(gcf,'position');
P(3)=P(3)*2;
P(4)=P(4)*1;
set(gcf,'position',P);
set(gcf,'PaperPositionMode','auto');

plot([1:12],climato.caudal_Borja,'ro:');
hold on
plot([1:12],climato.caudal_Chazuta,'bo:');
hold on
plot([1:12],climato.caudal_Requena,'md:');
hold on
plot([1:12],climato.caudal_San_Regis,'k^:');
hold on
plot([1:12],climato.caudal_Tamshiyacu,'r^--');
hold on
plot([1:12],climato.caudal_Bellavista_Mazan,'ko--');

legend('Borja','Chazuta','Requena','San Regis','Tamshiyacu','Bellavista Maz');
title('Climatologia mensual'); ylabel('Caudal [m^3/s]');
grid on
set(gca,'xtick',[1:1:12],'xticklabel',label);
