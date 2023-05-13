############################################################################
################# PCA y Normalidad mensual #################################

rm(list = ls())

setwd('D:/trabajo/IGP/CLIM_PEZ/avances_semanales/avance_2')

dir()
library(readxl)
library(vegan)
library(ade4)

data1<-read_excel("clusters_data.xlsx", sheet = "escenario1_2003_2015_T2")
View(data1)
data_fisica<-data1[,1:10]
View(data_fisica)

#data_fisica[,1]<-NULL

#data_fisica$TempNoche<-NULL
#row.names(data_fisica)<-data1$tiempo

#borramos las filas sin datos
library("tidyr")
data_fisica2 <- data_fisica %>% drop_na()
View(data_fisica2)
data_tiempo2<-data_fisica2$tiempo
data_fisica2[,1]<-NULL
row.names(data_fisica2)<-data_tiempo2


windows()
par(mfrow=c(3,3))

#plot(density.default(aa),main="depth");shapiro.test(data_pc[,1]) #pval >0.05
plot(density.default(scale(data_fisica2[,1])),main="PPmensualCuenca");shapiro.test(data_fisica2$PPmensualCuenca) #pval >0.05 / normal
plot(density.default(scale(data_fisica2)),main="TempDia");shapiro.test(data_fisica2$TempDía) #pval >0.05 / normal 
plot(density.default(scale(data_fisica2[,3])),main="TempNoche");shapiro.test(data_fisica2$TempNoche) #pval >0.05 /normal
plot(density.default(scale(data_fisica2[,4])),main="SedimentosRequena");shapiro.test(data_fisica2$SedimentosRequena) #pval >0.05 / normal
plot(density.default(scale(data_fisica2[,5])),main="SedimentosChazuta");shapiro.test(data_fisica2$SedimentosChazuta) #pval >0.05 /normal
plot(density.default(scale(data_fisica2[,6])),main="SedimentosTamshiyacu");shapiro.test(data_fisica2$SedimentosTamshiyacu) #pval > 0.05 /normal
plot(density.default(scale(data_fisica2[,7])),main="CaudalTamshiyacu");shapiro.test(data_fisica2$CaudalTamshiyacu) #pval < 0.05 / no es normal
plot(density.default(scale(data_fisica2[,8])),main="CaudalRequena");shapiro.test(data_fisica2$CaudalRequena) #pval < 0.05 / no es normal
plot(density.default(scale(data_fisica2[,9])),main="CaudalChazuta");shapiro.test(data_fisica2$CaudalChazuta) #pval < 0.05


################################################################################
######################## Variables biologicas ##################################
################################################################################

data_bio<-cbind(data1[,1],data1[,11:25])

View(data_bio)
row.names(data_bio)<-data1$tiempo

data_bio2<- data_bio %>% drop_na()
View(data_bio2)
data_tiempob2<-data_bio2$tiempo
data_bio2[,1]<-NULL
row.names(data_bio2)<-data_tiempob2



windows()
par(mfrow=c(4,4))

#plot(density.default(aa),main="depth");shapiro.test(data_pc[,1]) #pval >0.05
plot(density.default(scale(data_bio2[,1])),main="Req-Boquichico");shapiro.test(data_bio$`R-Boquichico`) #pval >0.05 / normal
plot(density.default(scale(data_bio2[,2])),main="Yu-Boquichico");shapiro.test(data_bio$`Yu-Boquichico`) #pval <0.05 / no normal 
plot(density.default(scale(data_bio2[,3])),main="Iq-Boquichico");shapiro.test(data_bio$`Iq-Boquichico`) #pval <0.05 /no normal
plot(density.default(scale(data_bio2[,4])),main="Yu-Llambina");shapiro.test(data_bio$`Yu-Llambina`) #pval >0.05 / normal
plot(density.default(scale(data_bio2[,5])),main="Req-Llambina");shapiro.test(data_bio$`R-Llambina`) #pval >0.05 /normal
plot(density.default(scale(data_bio2[,6])),main="Iq-Llambina");shapiro.test(data_bio$`Iq-Llambina`) #pval < 0.05 /no normal
plot(density.default(scale(data_bio2[,7])),main="Req-Palometa");shapiro.test(data_bio$`R-Palometa`) #pval < 0.05 / no es normal
plot(density.default(scale(data_bio2[,8])),main="Yu-Palometa");shapiro.test(data_bio$`Yu-Palometa`) #pval < 0.05 / no es normal
plot(density.default(scale(data_bio2[,9])),main="Iq-Palometa");shapiro.test(data_bio$`Iq-Palometa`) #pval < 0.05 /no normal
plot(density.default(scale(data_bio2[,10])),main="Req-Paiche");shapiro.test(data_bio$`R-Paiche`) #pval > 0.05 /  normal
plot(density.default(scale(data_bio2[1:18,11])),main="Yu-Paiche");shapiro.test(data_bio$`Yu-Paiche`) #pval > 0.05 /  normal
plot(density.default(scale(data_bio2[,12])),main="Iq-Paiche");shapiro.test(data_bio$`Iq-Paiche`) #pval < 0.05 / no es normal
plot(density.default(scale(data_bio2[,13])),main="Req-Lisa");shapiro.test(data_bio$`R-Lisa`) #pval > 0.05 /  normal
plot(density.default(scale(data_bio2[,14])),main="Yu-Lisa");shapiro.test(data_bio$`Yu-Lisa`) #pval < 0.05 / no es normal
plot(density.default(scale(data_bio2[,15])),main="Iq-Lisa");shapiro.test(data_bio$`Iq-Lisa`) #pval > 0.05 /  normal

par(mfrow=c(1,1))
boxplot(data_bio2)
############################## PCA ###############################################




