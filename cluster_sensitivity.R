##############################################################
####################### CLIMPEZ ############################
##############################################################

rm(list = ls())

setwd('D:/trabajo/IGP/CLIM_PEZ/avances_semanales/sensibilidad_clusters')
dir()
library(readxl)
library(vegan)
library(ade4)

data1<-read_excel("clusters_sensibilidad.xlsx", sheet = "Cluster1A")
View(data1)

data_fisica<-data1[1:14,2:8]
View(data_fisica)

boxplot(data_fisica)
#Primero con todos los datos fisicos del 2003 al 2015 promedio anual
row.names(data_fisica)<-c(2003:2016)

# here we reduce the distance
datalt<-log(data_fisica+1)
#we reduce the distance between points
#distort the distances
View(datalt)
plot(datalt)  

#step 4
#Calculate the matrix of association using the coefficient
#matdist<-as.dist(datalt)

matdist<-vegdist(datalt,method='euclidian',na.rm = TRUE)

#Step 5: Apply clustering method and genearte the dendrogram
# group average clustering method
#View(matdist)

LS<-hclust(matdist,method = 'single')
LC<-hclust(matdist,method='complete')
GA<-hclust(matdist,method='average')

par(mfrow=c(1,3))
plot(LS,ylab='Euclidian Method',
     xlab='stations',main='Single linkage')
abline(b=0,a=0.65,col='red')

plot(LC,ylab='Euclidian Method',
     xlab='stations',main='Complete linkage')
abline(b=0,a=0.65,col='red')

plot(GA,ylab='Euclidian Method',
     xlab='stations',main='Cluster 1A : GAP method')
abline(b=0,a=1.3,col='red')

groupe<-cutree(GA,4);groupe

########## CLuster 1B ###########

data2<-read_excel("clusters_sensibilidad.xlsx", sheet = "Cluster1B")
View(data2)

data_fisica2<-data2[1:14,2:8]
View(data_fisica2)

boxplot(data_fisica2)
#Primero con todos los datos fisicos del 2003 al 2015 promedio anual
row.names(data_fisica2)<-c(2003:2016)

# here we reduce the distance
datalt2<-log(data_fisica2+1)
#we reduce the distance between points
#distort the distances
View(datalt2)
plot(datalt2)  

#step 4
#Calculate the matrix of association using the coefficient
#matdist<-as.dist(datalt)

matdist2<-vegdist(datalt2,method='euclidian',na.rm = TRUE)

#Step 5: Apply clustering method and genearte the dendrogram
# group average clustering method
#View(matdist)

LS2<-hclust(matdist2,method = 'single')
LC2<-hclust(matdist2,method='complete')
GA2<-hclust(matdist2,method='average')

par(mfrow=c(1,3))
plot(LS2,ylab='Euclidian Method',
     xlab='stations',main='Single linkage')
abline(b=0,a=0.65,col='red')

plot(LC2,ylab='Euclidian Method',
     xlab='stations',main='Complete linkage')
abline(b=0,a=0.65,col='red')

plot(GA2,ylab='Euclidian Method',
     xlab='stations',main='Cluster 1B : GAP method')
abline(b=0,a=1.3,col='red')

groupe2<-cutree(GA2,3);groupe2

### 2 clusters
par(mfrow=c(1,2))

plot(GA,ylab='Euclidian Method',
     xlab='stations',main='Cluster 1A : GAP method')
abline(b=0,a=1.3,col='red')

plot(GA2,ylab='Euclidian Method',
     xlab='stations',main='Cluster 1B : GAP method')
abline(b=0,a=1.3,col='red')

###############################################################################
####################lets try one more time ####################################
###############################################################################
datfis<-data_fisica[-c(4)]

View(datfis)

boxplot(datfis)
#Primero con todos los datos fisicos del 2003 al 2015 promedio anual
row.names(datfis)<-c(2003:2016)

# here we reduce the distance
datalt3<-log(datfis+1)
#we reduce the distance between points
#distort the distances
View(datalt3)
plot(datalt3)  

#step 4
#Calculate the matrix of association using the coefficient
#matdist<-as.dist(datalt)

matdist3<-vegdist(datalt3,method='euclidian',na.rm = TRUE)

#Step 5: Apply clustering method and genearte the dendrogram
# group average clustering method
#View(matdist)

LS3<-hclust(matdist3,method = 'single')
LC3<-hclust(matdist3,method='complete')
GA3<-hclust(matdist3,method='average')

par(mfrow=c(1,3))
plot(LS3,ylab='Euclidian Method',
     xlab='stations',main='Single linkage')
abline(b=0,a=0.65,col='red')

plot(LC3,ylab='Euclidian Method',
     xlab='stations',main='Complete linkage')
abline(b=0,a=0.65,col='red')

plot(GA3,ylab='Euclidian Method',
     xlab='stations',main='Cluster 1A : GAP method')
abline(b=0,a=1.3,col='red')

groupe<-cutree(GA3,4);groupe

#######################

datfis2<-data_fisica2[-c(4)]

View(datfis2)

boxplot(datfis2)
#Primero con todos los datos fisicos del 2003 al 2015 promedio anual
row.names(datfis2)<-c(2003:2016)

# here we reduce the distance
datalt4<-log(datfis2+1)
#we reduce the distance between points
#distort the distances
View(datalt4)
plot(datalt4)  

#step 4
#Calculate the matrix of association using the coefficient
#matdist<-as.dist(datalt)

matdist4<-vegdist(datalt4,method='euclidian',na.rm = TRUE)

#Step 5: Apply clustering method and genearte the dendrogram
# group average clustering method
#View(matdist)

LS4<-hclust(matdist4,method = 'single')
LC4<-hclust(matdist4,method='complete')
GA4<-hclust(matdist4,method='average')

par(mfrow=c(1,3))
plot(LS4,ylab='Euclidian Method',
     xlab='stations',main='Single linkage')
abline(b=0,a=0.65,col='red')

plot(LC4,ylab='Euclidian Method',
     xlab='stations',main='Complete linkage')
abline(b=0,a=0.65,col='red')

plot(GA4,ylab='Euclidian Method',
     xlab='stations',main='Cluster 1B : GAP method')
abline(b=0,a=1.3,col='red')

groupe4<-cutree(GA4,4);groupe4

### 
par(mfrow=c(1,2))

plot(GA3,ylab='Euclidian Method',
     xlab='stations',main='Cluster 1A : GAP method')
abline(b=0,a=1.3,col='red')

plot(GA4,ylab='Euclidian Method',
     xlab='stations',main='Cluster 1B : GAP method')
abline(b=0,a=1.3,col='red')
