###Cluster CLIMPEZ 2003-2015 escenario####

rm(list = ls())

setwd('D:/trabajo/IGP/CLIM_PEZ/avances_semanales/avance_2/')

dir()
library(readxl)
library(vegan)
library(ade4)

data1<-read_excel("clusters_data.xlsx", sheet = "escenario1_2003_2015_T")
View(data1)

data_fisica<-data1[,2:11]
View(data_fisica)

#sacamos a yurimaguas
data_fisica$`Caudal Yurimagua`<-NULL
##
boxplot(data_fisica)
#Primero con todos los datos fisicos del 2003 al 2015 promedio anual
row.names(data_fisica)<-data1$tiempo

# here we reduce the distance
datalt<-log(data_fisica+1)
#we reduce the distance between points
#distort the distances
View(datalt)
plot(datalt)  

#step 4
#Calculate the matrix of association using the coefficient
#matdist<-as.dist(datalt)

matdist<-vegdist(datalt,method='euclidian',na.rm=TRUE)

#Step 5: Apply clustering method and genearte the dendrogram
# group average clustering method
#View(matdist)

LS<-hclust(matdist,method = 'single')
LC<-hclust(matdist,method='complete')
GA<-hclust(matdist,method='average')

par(mfrow=c(1,1))
#plot(LS,ylab='Euclidian Method',
#     xlab='stations',main='Single linkage')
#abline(b=0,a=0.65,col='red')

plot(LC,hang = -1, cex = 0.6,ylab='Euclidian Method',
     xlab='stations',main='Complete linkage')
abline(b=0,a=0.65,col='red')

plot(GA, cex = 0.6, ylab='Euclidian Method',
     xlab='stations',main='Group Average linkage Promedio Mensual Variables Fisicas')
abline(b=0,a=1.9,col='red')

groupe<-cutree(GA,12);groupe

#(sparcl)
#ColorDendrogram(GA, main = "Clusters from 216 samples",
#                branchlength = 0.20, labels = GA$labels, xlab = NULL,
#                sub = NULL, ylab = "", cex.main = NULL)
