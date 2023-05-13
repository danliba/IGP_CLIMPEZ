###### Estacionalidad por variable y anomalia ##########
rm(list = ls())

setwd('D:/trabajo/IGP/CLIM_PEZ/victoria_vera/')
dir()
library(readxl)
library(vegan)
library(ade4)
library(xlsx)
library(rJava)

data1<-read_excel("datos_1.xlsx", sheet = "var_fis_Dat")
View(data1)
tDate=as.POSIXct(data1$tiempo)
View(tDate)

year=as.integer(format(tDate,format="%Y"))
month=as.integer(format(tDate,format="%m"))

areMissingIndx=is.na(data1$`PP mensual Cuenca`)
# But we can also convert them to 0/1 and sum them
totalMissingCount=sum(areMissingIndx)
# Compute some percentiles for this month, 
# median and 95% confidence interval for instance
Percentiles=quantile(data1$`PP mensual Cuenca`,c(0.025,0.5,0.975),na.rm=TRUE)

tmpdata=data.frame(year=year,
                   month=month,
                   missingCount=totalMissingCount,
                   meanPPm=data1$`PP mensual Cuenca`,
                   P025=Percentiles[1],
                   P50=Percentiles[2],
                   P975=Percentiles[3])


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanPPm,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanPPm,typ="b",lwd=2,col="blue",main='Climatologia Mensual PPCuenca')
grid()
# We can also plot the percentiles together with the mean
# Upper percentile
plot(scycle$Group.1,scycle$P975,typ="l",lwd=1,col="red",ylim=c(70,370),
     xlab="Month",ylab=expression("Temperature ("*~degree*C*")"))
# Lowest values
lines(scycle$Group.1,scycle$P025,typ="l",lwd=1,col="red")
# the mean
lines(scycle$Group.1,scycle$meanPPm,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanPPm~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanPPm[indx]-scycle$meanPPm[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='red',ylim=range(c(-150,300)),main='Anomalia PP mensual Cuenca')
abline(h=c(0))
grid()

# So do trend analysis too
trend=lm(tmpdata$anomalies~xtimes)
anom_PPm<-tmpdata$anomalies
clim_PPm<-scycle$meanPPm

summary(trend)
print(paste("Decadal temperature trend:",trend$coefficients[2]*10,"C/decade"))

################################## Temp Dia ##################################
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`Temp Día`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual Temp Dia')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='red',main='Anomalia mensual Temp Dia')
abline(h=c(0))
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_tempDia<-tmpdata$anomalies
clim_tempDia<-scycle$meanTempD
################################## Temp Noche ##################################
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`Temp Noche`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual Temp Noche')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='black',main='Anomalia mensual Temp Noche')
abline(h=c(0),col='red')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_tempNoche<-tmpdata$anomalies
clim_tempNoche<-scycle$meanTempD
################################## Promedio Sedimentos Requena ##################################
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`Promedio Sedimentos Requena`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual Sedimentos Requena')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='brown',main='Anomalia mensual Sedimentos requena')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_sedimentos_Re<-tmpdata$anomalies
clim_sedimentos_Re<-scycle$meanTempD
################################## Promedio Sedimentos Chazuta ##################################
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`Promedio Sedimentos Chazuta`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual Sedimentos Chazuta')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='brown',main='Anomalia mensual Sedimentos Chazuta')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_sedimentos_Chaz<-tmpdata$anomalies
clim_sedimentos_Chaz<-scycle$meanTempD
################################## Promedio Sedimentos Tamshiyacu ##################################
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`Promedio Sedimentos Tamshiyacu`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual Sedimentos Tamshiyacu')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='brown',main='Anomalia mensual Sedimentos Tamshiyacu')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_sedimentos_Tam<-tmpdata$anomalies
clim_sedimentos_Tam<-scycle$meanTempD
################################## Promedio Caudal Tamshiyacu ##################################
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`Caudal Tamshiyacu`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual Caudal Tamshiyacu')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='brown',main='Anomalia mensual Caudal Tamshiyacu')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_caudal_Tam<-tmpdata$anomalies
clim_caudal_Tam<-scycle$meanTempD
################################ Caudal Requena ####################################
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`Caudal Requena`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual Caudal Requena')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='brown',main='Anomalia mensual Caudal Requena')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_caudal_req<-tmpdata$anomalies
clim_caudal_req<-scycle$meanTempD
####################### caud Yurimaguas #########################################
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`Caudal Yurimagua`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual Caudal Yurimagua')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='brown',main='Anomalia mensual Caudal Yurimagua')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_caudal_Yurimagua<-tmpdata$anomalies
clim_caudal_Yurimagua<-scycle$meanTempD
############################## R biquichico ###################################
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`R-Boquichico`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual R-Boquichico')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='purple',main='Anomalia mensual R-Boquichico')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_caudal_R_Boquichico<-tmpdata$anomalies

############################## YU biquichico ###################################
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`Yu-Boquichico`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual Yu-Boquichico')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='purple',main='Anomalia mensual Yu-Boquichico')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_caudal_Yu_Boquichico<-tmpdata$anomalies

############################## Iq Boquichico ###################################
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`Iq-Boquichico`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual Iq-Boquichico')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='purple',main='Anomalia mensual Iq-Boquichico')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_caudal_Iq_Boquichico<-tmpdata$anomalies

####################### R llambina ##########################################
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`R-Llambina`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual R-Llambina')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='orange',main='Anomalia mensual R-Llambina')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_caudal_R_llambina<-tmpdata$anomalies

####################### Yu llambina ##########################################
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`Yu-Llambina`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual Yu-Llambina')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='orange',main='Anomalia mensual Yu-Llambina')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_caudal_Yu_llambina<-tmpdata$anomalies

############################# Iq Llambina ######################################
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`Iq-Llambina`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual Iq-Llambina')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='orange',main='Anomalia mensual Iq-Llambina')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_caudal_Iq_llambina<-tmpdata$anomalies

################################ R Palometa #############################3
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`R-Palometa`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual R-Palometa')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='green',main='Anomalia mensual R-Palometa')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_caudal_R_palometa<-tmpdata$anomalies

##################### Yu Palometa ########################################3
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`Yu-Palometa`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual Yu-Palometa')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='green',main='Anomalia mensual Yu-Palometa')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_caudal_Yu_palometa<-tmpdata$anomalies

##################### Iq Palometa ##########################################33
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`Iq-Palometa`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual Iq-Palometa')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='green',main='Anomalia mensual Iq-Palometa')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_caudal_Iq_palometa<-tmpdata$anomalies

############################ R Paiche ######################################
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`R-Paiche`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual R-Paiche')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='grey',main='Anomalia mensual R-Paiche')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_caudal_R_paiche<-tmpdata$anomalies

################## Yu Paiche ##############################################3
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`Yu-Paiche`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual Yu-Paiche')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='grey',main='Anomalia mensual Yu-Paiche')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_caudal_Yu_paiche<-tmpdata$anomalies

###############################33 Iq Paiche #####################################
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`Iq-Paiche`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual Iq-Paiche')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='grey',main='Anomalia mensual Iq-Paiche')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_caudal_Iq_paiche<-tmpdata$anomalies

###############################33 R lisa #####################################
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`R-Lisa`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual R-Lisa')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='blue',main='Anomalia mensual R-Lisa')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_caudal_R_lisa<-tmpdata$anomalies

####################### Yu Lisa ##############################################
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`Yu-Lisa`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual Yu-Lisa')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='blue',main='Anomalia mensual Yu-Lisa')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_caudal_yu_lisa<-tmpdata$anomalies

###################### Iq Lisa ################################################
tmpdata=data.frame(year=year,
                   month=month,
                   meanTempD=data1$`Iq-Lisa`)


xaxis=ISOdate(tmpdata$year,tmpdata$month,rep(15,nrow(tmpdata)))
#plot(xaxis,tmpdata$missingCount)
# Very regular seasonal cycle
plot(xaxis,tmpdata$meanTempD,col="red",type="l")

scycle=aggregate(tmpdata,by=list(tmpdata$month),FUN=mean,na.rm=TRUE)

# Original data
dim(tmpdata)
dim(scycle)
names(scycle)
# This has been created when grouping the data (months in this case)
print(scycle$Group.1)
# Plot the regular seasonal cycle, this time it is very regular
plot(scycle$Group.1,scycle$meanTempD,typ="b",lwd=2,col="blue",main='Climatologia Mensual Iq-Lisa')
grid()
# We can also plot the percentiles together with the mea
# the mean
lines(scycle$Group.1,scycle$meanTempD,type="l",col="red",lwd=2)


# Create a "fake" axis (time) as year+(imonth-1)/12 (units in year)
xtimes=tmpdata$year+(tmpdata$month-1)/12.
trend=lm(tmpdata$meanTempD~xtimes)
summary(trend)
# This is not working properly, we are analyzing the trend in a signal with 
# a strong seasonal cycle
tmpdata=cbind(tmpdata,anomalies=rep(0,nrow(tmpdata)))
# For every month, get the value of meanSST[i]-monthlyMean
for(irow in 1:nrow(scycle)){
  imon=scycle$Group.1[irow]
  print(paste(irow,imon))
  indx=tmpdata$month==imon
  tmpdata$anomalies[indx]=tmpdata$meanTempD[indx]-scycle$meanTempD[irow]
}
# Things look a little bit different now
plot(xtimes,tmpdata$anomalies,typ="b",col='blue',main='Anomalia mensual Iq-Lisa')
abline(h=c(0),col='black')
grid()

trend=lm(tmpdata$anomalies~xtimes)
summary(trend)

anom_caudal_Iq_lisa<-tmpdata$anomalies

####### relaciones  anomalias ####################3

plot(anom_caudal_Tam,anom_caudal_Iq_Boquichico)
cor.test(anom_caudal_Tam,anom_caudal_Iq_Boquichico,method = "spearman",use = "complete.obs")

anomalias_mensuales<-cbind(year,month,anom_PPm,anom_tempDia,anom_tempNoche,anom_sedimentos_Re,anom_sedimentos_Chaz,
                           anom_sedimentos_Tam,anom_caudal_Tam,anom_caudal_req,anom_caudal_Yurimagua,anom_caudal_R_Boquichico,
                           anom_caudal_Yu_Boquichico,anom_caudal_Iq_Boquichico,anom_caudal_R_llambina,anom_caudal_Yu_llambina,
                           anom_caudal_Iq_llambina,anom_caudal_R_palometa,anom_caudal_Yu_palometa,anom_caudal_Iq_palometa,
                           anom_caudal_R_paiche,anom_caudal_Yu_paiche,anom_caudal_Iq_paiche,anom_caudal_R_lisa,anom_caudal_yu_lisa,
                           anom_caudal_Iq_lisa)

library(openxlsx)
write.xlsx(anomalias_mensuales,"Anom_mensuales")
#write.xlsx(x, file, sheetName = "Sheet1", 
#           col.names = TRUE, row.names = TRUE, append = FALSE)

climato_mensuales_caudal<-cbind(clim_caudal_Tam,clim_caudal_req,clim_caudal_Yurimagua)
write.csv(climato_mensuales_caudal,"climato_mensuales_caudal.csv")

View(climato_mensuales_caudal)
