####################### PCA CLIMPEZ #######################################
###########################################################################

rm(list = ls())

setwd('D:/trabajo/IGP/CLIM_PEZ/victoria_vera/')
dir()
library(readxl)
library(vegan)
library(ade4)

data1<-read_excel("clusters_casos.xlsx", sheet = "yr_hidrol-R2")
View(data1)
data_fisica<-data1[,2:11]
View(data_fisica)

row.names(data_fisica)<-c(2003:2015)

windows()
par(mfrow=c(3,3))

#plot(density.default(aa),main="depth");shapiro.test(data_pc[,1]) #pval >0.05
plot(density.default(scale(data_fisica[,1])),main="PPanualReq");shapiro.test(data_fisica$PPAnual.Requena) #pval >0.05 / normal
plot(density.default(scale(data_fisica[,2])),main="PPanualTam");shapiro.test(data_fisica$PPAnual.Tamshi) #pval >0.05 / normal 
plot(density.default(scale(data_fisica[,3])),main="PPanualSR");shapiro.test(data_fisica$PPAnual.SR) #pval >0.05 /normal
plot(density.default(scale(data_fisica[,4])),main="MUR2");shapiro.test(data_fisica$MUR2) #pval >0.05 /normal
plot(density.default(scale(data_fisica[,5])),main="SedimentosRequena");shapiro.test(data_fisica$SedimentosRequena) #pval >0.05 / normal
plot(density.default(scale(data_fisica[,6])),main="SedimentosTamshiyacu");shapiro.test(data_fisica$SedimentosTamshiyacu) #pval > 0.05 /normal
plot(density.default(scale(data_fisica[,7])),main="SedimentosChazuta");shapiro.test(data_fisica$SedimentosChazuta) #pval >0.05 /normal
plot(density.default(scale(data_fisica[,8])),main="CaudalRequena");shapiro.test(data_fisica$CaudalRequena) #pval < 0.05 / no es normal
plot(density.default(scale(data_fisica[,9])),main="CaudalTamshiyacu");shapiro.test(data_fisica$CaudalTamshiyacu) #pval < 0.05 / no es normal
plot(density.default(scale(data_fisica[,10])),main="CaudalSR");shapiro.test(data_fisica$CaudalSanRegis) #pval < 0.05

################################################################################
######################## Variables biologicas ##################################
################################################################################

data_bio<-data1[,12:26]
View(data_bio)
row.names(data_bio)<-c(2003:2015)

windows()
par(mfrow=c(4,4))

#plot(density.default(aa),main="depth");shapiro.test(data_pc[,1]) #pval >0.05
plot(density.default(scale(data_bio[,1])),main="Req-Boquichico");shapiro.test(data_bio$`R-Boquichico`) #pval >0.05 / normal
plot(density.default(scale(data_bio[,2])),main="Yu-Boquichico");shapiro.test(data_bio$`Yu-Boquichico`) #pval <0.05 / no normal 
plot(density.default(scale(data_bio[,3])),main="Iq-Boquichico");shapiro.test(data_bio$`Iq-Boquichico`) #pval <0.05 /no normal
plot(density.default(scale(data_bio[,4])),main="Yu-Llambina");shapiro.test(data_bio$`Yu-Llambina`) #pval >0.05 / normal
plot(density.default(scale(data_bio[,5])),main="Req-Llambina");shapiro.test(data_bio$`R-Llambina`) #pval >0.05 /normal
plot(density.default(scale(data_bio[,6])),main="Iq-Llambina");shapiro.test(data_bio$`Iq-Llambina`) #pval < 0.05 /no normal
plot(density.default(scale(data_bio[,7])),main="Req-Palometa");shapiro.test(data_bio$`R-Palometa`) #pval < 0.05 / no es normal
plot(density.default(scale(data_bio[,8])),main="Yu-Palometa");shapiro.test(data_bio$`Yu-Palometa`) #pval < 0.05 / no es normal
plot(density.default(scale(data_bio[,9])),main="Iq-Palometa");shapiro.test(data_bio$`Iq-Palometa`) #pval < 0.05 /no normal
plot(density.default(scale(data_bio[,10])),main="Req-Paiche");shapiro.test(data_bio$`R-Paiche`) #pval > 0.05 /  normal
plot(density.default(scale(data_bio[,11])),main="Yu-Paiche");shapiro.test(data_bio$`Yu-Paiche`) #pval > 0.05 /  normal
plot(density.default(scale(data_bio[,12])),main="Iq-Paiche");shapiro.test(data_bio$`Iq-Paiche`) #pval < 0.05 / no es normal
plot(density.default(scale(data_bio[,13])),main="Req-Lisa");shapiro.test(data_bio$`R-Lisa`) #pval > 0.05 /  normal
plot(density.default(scale(data_bio[,14])),main="Yu-Lisa");shapiro.test(data_bio$`Yu-Lisa`) #pval < 0.05 / no es normal
plot(density.default(scale(data_bio[,15])),main="Iq-Lisa");shapiro.test(data_bio$`Iq-Lisa`) #pval > 0.05 /  normal

boxplot(data_bio)

### Ahora el PCA####

rm(list = ls())
setwd('D:/trabajo/IGP/CLIM_PEZ/victoria_vera/')
dir()
library(readxl)
library(vegan)
library(ade4)

data0<-read_excel("clusters_casos.xlsx", sheet = "PCA")
View(data0)
data1<-data0[,4:12]
View(data1)

row.names(data1)<-data0$Yr_st
# as the variables have high diversity ranges we will now standardize the data
data2<-scale(data1)
boxplot(data2, horizontal=F)

#all scaled

######### STEP 2&3 - Computation of the covariance matrix and spectral decomposition#########
library(ade4)
# pcaBA<-dudi.pca(BA3) 
# This option requires to provide interactively an answer
# about the number of kept axes
# Another option :
pcaIGP<-dudi.pca(data2,scannf=FALSE,nf=3)
pcaIGP$eig

eigpercent<-pcaIGP$eig/sum(pcaIGP$eig)*100;eigpercent
barplot(eigpercent,names.arg=c("F1","F2","F3","F4","F5","F6","F7","F8","F9","F10"))
# The three first factorial axes explain approximately 72% of the 
# total variance associated with the dataset. 
# This means that we can reduce the analysis to this 3 factorial axes

#graphical representations of the PCA
par(mfrow=c(1,2)) 
s.corcircle(pcaIGP$co, xax=1, yax=2,clabel=0.8) # Variable space in the F1-F2 plan
s.label(pcaIGP$li, xax=1, yax=2,clabel=0.5) # Observation space in the F1-F2 plan


################################################################################
################# Physical Variables ###########################################
################################################################################

data_fisica<-data1[,1:5]
View(data_fisica)

row.names(data_fisica)<-data0$Yr_st
# as the variables have high diversity ranges we will now standardize the data
data_fis2<-scale(data_fisica)
boxplot(data_fis2, horizontal=F)

#all scaled

######### STEP 2&3 - Computation of the covariance matrix and spectral decomposition#########
library(ade4)
# pcaBA<-dudi.pca(BA3) 
# This option requires to provide interactively an answer
# about the number of kept axes
# Another option :
pcaIGP_fis<-dudi.pca(data_fis2,scannf=FALSE,nf=3)
pcaIGP_fis$eig

eigpercent<-pcaIGP_fis$eig/sum(pcaIGP_fis$eig)*100;eigpercent
barplot(eigpercent,names.arg=c("F1","F2","F3","F4","F5"))
# The three first factorial axes explain approximately 72% of the 
# total variance associated with the dataset. 
# This means that we can reduce the analysis to this 3 factorial axes

#graphical representations of the PCA
par(mfrow=c(1,2)) 
s.corcircle(pcaIGP_fis$co, xax=1, yax=2,clabel=0.8) # Variable space in the F1-F2 plan
s.label(pcaIGP_fis$li, xax=1, yax=2,clabel=0.5) # Observation space in the F1-F2 plan


################################################################################
################# Biological Variables ###########################################
################################################################################

data_bio<-data1[,6:10]
View(data_bio)

row.names(data_bio)<-data0$Yr_st
# as the variables have high diversity ranges we will now standardize the data
data_bio2<-scale(data_bio)
boxplot(data_bio2, horizontal=F)

#all scaled

######### STEP 2&3 - Computation of the covariance matrix and spectral decomposition#########
library(ade4)
# pcaBA<-dudi.pca(BA3) 
# This option requires to provide interactively an answer
# about the number of kept axes
# Another option :
pcaIGP_bio<-dudi.pca(data_bio2,scannf=FALSE,nf=3)
pcaIGP_bio$eig

eigpercent<-pcaIGP_bio$eig/sum(pcaIGP_bio$eig)*100;eigpercent
barplot(eigpercent,names.arg=c("F1","F2","F3","F4","F5"))
# The three first factorial axes explain approximately 72% of the 
# total variance associated with the dataset. 
# This means that we can reduce the analysis to this 3 factorial axes

#graphical representations of the PCA
par(mfrow=c(1,2)) 
s.corcircle(pcaIGP_bio$co, xax=1, yax=2,clabel=0.8) # Variable space in the F1-F2 plan
s.label(pcaIGP_bio$li, xax=1, yax=2,clabel=0.5) # Observation space in the F1-F2 plan
