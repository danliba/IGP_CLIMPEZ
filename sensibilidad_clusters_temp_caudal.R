##############################################################
####################### CLIMPEZ ############################
##############################################################
# Caudal vs Temperatura
################ Aguas Bajas ###################### Agua marina#
###############################################################
rm(list = ls())

setwd('D:/trabajo/IGP/CLIM_PEZ/avances_semanales/sensibilidad_clusters')
dir()
library(readxl)
#library(R.matlab)
library(vegan)
library(ade4)

#aguas altas con ADCP
data1<-read_excel("C1_B_Ago_Set_sed_caud_aguas_bajas.xlsx", sheet = 1)
View(data1)
data_ADCP<-data1[-c(1,6,7,8,10,11,12,13,14,15)]
data_MODIA<-data1[-c(1,6,7,8,9,11,12,13,14,15)]
data_MUR3<-data1[-c(1,6,7,8,9,10,11,12,13,14)]


View(data_ADCP)

par(mfrow=c(1,3))
boxplot(data_ADCP)
boxplot(data_MODIA)
boxplot(data_MUR3)
#Primero con todos los datos fisicos del 2003 al 2015 promedio anual
row.names(data_ADCP)<-c(2003:2016)
row.names(data_MODIA)<-c(2003:2016)
row.names(data_MUR3)<-c(2003:2016)
# here we reduce the distance

dataltADCP<-log(data_ADCP+1)
dataltMODIA<-log(data_MODIA+1)
dataltMUR3<-log(data_MUR3+1)

#we reduce the distance between points
#distort the distances
#View(datalt)

plot(dataltADCP)  
plot(dataltMODIA) 
plot(dataltMUR3) 

#step 4
#Calculate the matrix of association using the coefficient
#matdist<-as.dist(datalt)

matdistADCP<-vegdist(dataltADCP,method='euclidian',na.rm = TRUE)
matdistMODIA<-vegdist(dataltMODIA,method='euclidian',na.rm = TRUE)
matdistMUR3<-vegdist(dataltMUR3,method='euclidian',na.rm = TRUE)

#Step 5: Apply clustering method and genearte the dendrogram
# group average clustering method
#ACDP

LSADCP<-hclust(matdistADCP,method = 'single')
LCADCP<-hclust(matdistADCP,method='complete')
GAADCP<-hclust(matdistADCP,method='average')

par(mfrow=c(1,3))
plot(LSADCP,ylab='Euclidian Method',
     xlab='stations',main='Single linkage')
abline(b=0,a=0.65,col='red')

plot(LCADCP,ylab='Euclidian Method',
     xlab='stations',main='Complete linkage')
abline(b=0,a=0.65,col='red')

plot(GAADCP,ylab='Euclidian Method',
     xlab='stations',main='Cluster 1A : GAP method')
abline(b=0,a=1.3,col='red')

groupeADCP<-cutree(GAADCP,4);groupeADCP

#MODIS DIA
LSMODIA<-hclust(matdistMODIA,method = 'single')
LCMODIA<-hclust(matdistMODIA,method='complete')
GAMODIA<-hclust(matdistMODIA,method='average')

par(mfrow=c(1,3))
plot(LSMODIA,ylab='Euclidian Method',
     xlab='stations',main='Single linkage')
abline(b=0,a=0.65,col='red')

plot(LCMODIA,ylab='Euclidian Method',
     xlab='stations',main='Complete linkage')
abline(b=0,a=0.65,col='red')

plot(GAMODIA,ylab='Euclidian Method',
     xlab='stations',main='Cluster 1A : GAP method')
abline(b=0,a=1.3,col='red')

groupeMODIA<-cutree(GAMODIA,4);groupeMODIA

## MUR
LSMUR3<-hclust(matdistMUR3,method = 'single')
LCMUR3<-hclust(matdistMUR3,method='complete')
GAMUR3<-hclust(matdistMUR3,method='average')

par(mfrow=c(1,3))
plot(LSMUR3,ylab='Euclidian Method',
     xlab='stations',main='Single linkage')
abline(b=0,a=0.65,col='red')

plot(LCMUR3,ylab='Euclidian Method',
     xlab='stations',main='Complete linkage')
abline(b=0,a=0.65,col='red')

plot(GAMUR3,ylab='Euclidian Method',
     xlab='stations',main='Cluster 1A : GAP method')
abline(b=0,a=1.3,col='red')

groupeMUR3<-cutree(GAMUR3,4);groupeMUR3

###  3 clusters
par(mfrow=c(1,3))

plot(GAADCP,ylab='Euclidian Method',
     xlab='stations',main='Cluster ADCP: GAP method')
abline(b=0,a=0.4,col='red')

plot(GAMODIA,ylab='Euclidian Method',
     xlab='stations',main='Cluster MODIS dia: GAP method')
abline(b=0,a=0.4,col='red')

plot(GAMUR3,ylab='Euclidian Method',
     xlab='stations',main='Cluster MUR region 3 : GAP method')
abline(b=0,a=0.4,col='red')

