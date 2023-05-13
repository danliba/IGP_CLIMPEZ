##########Cluster 2 #######################

################################################################################
############## CLuster with PCA rearrange time-station data ####################
################################################################################

rm(list = ls())

setwd('D:/trabajo/IGP/CLIM_PEZ/victoria_vera/')
dir()
library(readxl)
library(vegan)
library(ade4)

data1<-read_excel("TOTAL_PCA.xlsx", sheet = "Clust")
View(data1)

data_fisica<-data1[,2:6]
View(data_fisica)

boxplot(data_fisica)
#Primero con todos los datos fisicos del 2003 al 2015 promedio anual
row.names(data_fisica)<-data1$Yr_st

# here we reduce the distance
datalt<-log(data_fisica+1)
#we reduce the distance between points
#distort the distances
View(datalt)
plot(datalt)  

#step 4
#Calculate the matrix of association using the coefficient
#matdist<-as.dist(datalt)

matdist<-vegdist(datalt,method='euclidian')

#Step 5: Apply clustering method and genearte the dendrogram
# group average clustering method
#View(matdist)

LS<-hclust(matdist,method = 'single')
LC<-hclust(matdist,method='complete')
GA<-hclust(matdist,method='average')

#par(mfrow=c(1,3))
#plot(LS,ylab='Euclidian Method',
#     xlab='stations',main='Single linkage')
#abline(b=0,a=0.65,col='red')

#plot(LC,ylab='Euclidian Method',
#     xlab='stations',main='Complete linkage')
#abline(b=0,a=0.65,col='red')

windows()
plot(GA,ylab='Euclidian Method',
     xlab='stations',main='Group Average linkage')
abline(b=0,a=0.65,col='red')

groupe<-cutree(GA,3);groupe
