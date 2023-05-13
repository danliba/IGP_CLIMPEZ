## calculo de climatologias con excel caudales

rm(list = ls())

setwd('D:/trabajo/IGP/CLIM_PEZ/Dra_Jaramillos/')
dir()
library(readxl)
library(vegan)
library(ade4)
library(xlsx)
library(rJava)

data1<-read_excel("Caudales.xlsx", sheet = "data")
View(data1)
tDate=as.POSIXct(data1$Date)
View(tDate)

year=as.integer(format(tDate,format="%Y"))
month=as.integer(format(tDate,format="%m"))
day=as.integer(format(tDate,format="%d"))

areMissingIndx=is.na(data1$Requena)
# But we can also convert them to 0/1 and sum them
totalMissingCount=sum(areMissingIndx)
# Compute some percentiles for this month, 
# median and 95% confidence interval for instance
#Percentiles=quantile(data1$`PP mensual Cuenca`,c(0.025,0.5,0.975),na.rm=TRUE)

tmpdata=data.frame(year=year,
                   month=month, day=day,
                   missingCount=totalMissingCount,
                   meanPPm=data1$Requena)

xaxis=ISOdate(tmpdata$year,tmpdata$month,tmpdata$day)
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
                   
                   