##############################################################
####################### CLIMPEZ ############################
##############################################################

rm(list = ls())

setwd('D:/trabajo/IGP/CLIM_PEZ/victoria_vera/')
dir()
library(readxl)
library(vegan)
library(ade4)

data1<-read_excel("variables_1.xlsx", sheet = "only_complete_yr")
View(data1)

data_fisica<-data1[,2:10]
View(data_fisica)

boxplot(data_fisica)
#Primero con todos los datos fisicos del 2003 al 2015 promedio anual
row.names(data_fisica)<-c(2003:2015)

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

par(mfrow=c(1,3))
plot(LS,ylab='Euclidian Method',
     xlab='stations',main='Single linkage')
abline(b=0,a=0.65,col='red')

plot(LC,ylab='Euclidian Method',
     xlab='stations',main='Complete linkage')
abline(b=0,a=0.65,col='red')

plot(GA,ylab='Euclidian Method',
     xlab='stations',main='Group Average linkage')
abline(b=0,a=0.65,col='red')

groupe<-cutree(GA,3);groupe


################################################################################
################################## ESCENARIO I Biological ##################################
################################################################################

data_c_bio<-data1[,11:25]
View(data_c_bio)

par(mfrow=c(1,1))
boxplot(data_c_bio)
#Primero con todos los datos fisicos del 2003 al 2015 promedio anual
row.names(data_c_bio)<-c(2003:2015)

# here we reduce the distance
datalt_c_bio<-log(data_c_bio+1)
#we reduce the distance between points
#distort the distances
View(datalt_c_bio)
plot(datalt_c_bio)  

#step 4
#Calculate the matrix of association using the coefficient
#matdist<-as.dist(datalt)

matdist_c_bio<-vegdist(datalt_c_bio,method='bray')

#Step 5: Apply clustering method and genearte the dendrogram
# group average clustering method
#View(matdist)

LS<-hclust(matdist_c_bio,method = 'single')
LC<-hclust(matdist_c_bio,method='complete')
GA<-hclust(matdist_c_bio,method='average')

par(mfrow=c(1,3))
plot(LS,ylab='Bray Curtis Method',
     xlab='stations',main='Single linkage')
abline(b=0,a=0.1,col='red')

plot(LC,ylab='Bray Curtis Method',
     xlab='stations',main='Complete linkage')
abline(b=0,a=0.1,col='red')

plot(GA,ylab='Bray Curtis Method',
     xlab='stations',main='Group Average linkage')
abline(b=0,a=0.1,col='red')

groupe<-cutree(LS,4);groupe
############################################################################
##### other clusters just because 

data_bio_t<-t(data_c_bio)
View(data_bio_t)

par(mfrow=c(1,1))
boxplot(data_bio_t)
#Primero con todos los datos fisicos del 2003 al 2015 promedio anual
#row.names(data_c_bio)<-c(2003:2015)

# here we reduce the distance
datalt_bio_t<-log(data_bio_t+1)
#we reduce the distance between points
#distort the distances
View(datalt_bio_t)
plot(datalt_bio_t)  

#step 4
#Calculate the matrix of association using the coefficient
#matdist<-as.dist(datalt)

matdist_bio_t<-vegdist(datalt_bio_t,method='bray')

#Step 5: Apply clustering method and genearte the dendrogram
# group average clustering method
#View(matdist)

LS<-hclust(matdist_bio_t,method = 'single')
LC<-hclust(matdist_bio_t,method='complete')
GA<-hclust(matdist_bio_t,method='average')

par(mfrow=c(1,3))
plot(LS,ylab='Bray Curtis Method',
     xlab='stations',main='Single linkage')
abline(b=0,a=0.25,col='red')

plot(LC,ylab='Bray Curtis Method',
     xlab='stations',main='Complete linkage')
abline(b=0,a=0.25,col='red')

plot(GA,ylab='Bray Curtis Method',
     xlab='stations',main='Group Average linkage')
abline(b=0,a=0.25,col='red')

groupe<-cutree(GA,3);groupe

## most representative species
library(labdsv)
data7<-data_c_bio[,colSums(data_c_bio)!=0] #delete the columns with 0 values
indval(data7,groupe)->IV;IV

IV$relfrq#faithfulness 
IV$relabu #specificity
IV$indval #value of indval from 0 to 1

#GA<-hclust(matdist,method='average')
#plot(GA,ylab='Euclidian distance',
#     xlab='stations',main='Group Average linkage') #probar con cluster sin huecos

################# Escenario 2 ##############################################
############################################################################
######################## años del 2000 al 2017 sin incluir Caudal en chizuta
data2<-read_excel("variables_1.xlsx", sheet = "no_chizuta")
View(data2)

data_fisica2<-data2[,2:9]
View(data_fisica2)

boxplot(data_fisica2)
#Primero con todos los datos fisicos del 2003 al 2015 promedio anual
row.names(data_fisica2)<-c(2000:2017)

# here we reduce the distance
datalt2<-log(data_fisica2+1)
#we reduce the distance between points
#distort the distances
View(datalt2)
plot(datalt2)  


#step 4
#Calculate the matrix of association using the coefficient
#matdist<-as.dist(datalt)

matdist2<-vegdist(datalt2,method='euclidian')

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
     xlab='stations',main='Group Average linkage')
abline(b=0,a=0.65,col='red')

groupe<-cutree(LC2,4);groupe

################################################################################
############################## Completed Data ##################################
################################################################################

#Fisical
rm(list = ls())

setwd('D:/trabajo/IGP/CLIM_PEZ/victoria_vera/')
dir()
library(readxl)
library(vegan)
library(ade4)

data_c<-read_excel("variables_1.xlsx", sheet = "completed_data")
View(data_c)

data_c_fis<-data_c[,2:10]
View(data_c_fis)

boxplot(data_c_fis)
#Primero con todos los datos fisicos del 2003 al 2015 promedio anual
row.names(data_c_fis)<-c(2000:2019)

# here we reduce the distance
datalt_c_fis<-log(data_c_fis+1)
#we reduce the distance between points
#distort the distances
View(datalt_c_fis)
plot(datalt_c_fis)  

#step 4
#Calculate the matrix of association using the coefficient
#matdist<-as.dist(datalt)

matdist_c_fis<-vegdist(datalt_c_fis,method='euclidian')

#Step 5: Apply clustering method and genearte the dendrogram
# group average clustering method
#View(matdist)

LS<-hclust(matdist_c_fis,method = 'single')
LC<-hclust(matdist_c_fis,method='complete')
GA<-hclust(matdist_c_fis,method='average')

par(mfrow=c(1,3))
plot(LS,ylab='Euclidian Method',
     xlab='stations',main='Single linkage')
abline(b=0,a=0.65,col='red')

plot(LC,ylab='Euclidian Method',
     xlab='stations',main='Complete linkage')
abline(b=0,a=0.65,col='red')

plot(GA,ylab='Euclidian Method',
     xlab='stations',main='Group Average linkage')
abline(b=0,a=0.65,col='red')

groupe<-cutree(GA,4);groupe

################################################################################
################################## Biological ##################################
################################################################################

data_c_bio<-data_c[,11:25]
View(data_c_bio)

boxplot(data_c_bio)
#Primero con todos los datos fisicos del 2003 al 2015 promedio anual
row.names(data_c_bio)<-c(2000:2019)

# here we reduce the distance
datalt_c_bio<-log(data_c_bio+1)
#we reduce the distance between points
#distort the distances
View(datalt_c_bio)
plot(datalt_c_bio)  

#step 4
#Calculate the matrix of association using the coefficient
#matdist<-as.dist(datalt)

matdist_c_bio<-vegdist(datalt_c_bio,method='bray')

#Step 5: Apply clustering method and genearte the dendrogram
# group average clustering method
#View(matdist)

LS<-hclust(matdist_c_bio,method = 'single')
LC<-hclust(matdist_c_bio,method='complete')
GA<-hclust(matdist_c_bio,method='average')

par(mfrow=c(1,3))
plot(LS,ylab='Bray Curtis Method',
     xlab='stations',main='Single linkage')
abline(b=0,a=0.15,col='red')

plot(LC,ylab='Bray Curtis Method',
     xlab='stations',main='Complete linkage')
abline(b=0,a=0.15,col='red')

plot(GA,ylab='Bray Curtis Method',
     xlab='stations',main='Group Average linkage')
abline(b=0,a=0.15,col='red')

groupe<-cutree(GA,4);groupe



