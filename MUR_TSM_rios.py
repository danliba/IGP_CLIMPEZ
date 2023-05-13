# -*- coding: utf-8 -*-
"""
Created on Tue Jan 17 17:06:12 2023
Modified on Mon Apr 24 21:12:12 2023

@author: glecca 
@modified by: Danliba
"""
#create the dates

from datetime import date, timedelta

start_dt = date(2016, 1, 1)
end_dt = date(2016, 12, 31)

# difference between current and previous date
delta = timedelta(days=1)

# store the dates between two dates in a list
dates = []

while start_dt <= end_dt:
    # add current date to list by converting  it to iso format
    dates.append(start_dt.isoformat())
    # increment start date by timedelta
    start_dt += delta
#%%

from erddapClient import ERDDAP_Server
import urllib.request
from erddapClient import ERDDAP_Griddap

remoteServer = ERDDAP_Server('https://coastwatch.pfeg.noaa.gov/erddap')

#%% buscar producto
searchRequest = remoteServer.search(searchFor="mur")

#%%


remote = ERDDAP_Griddap('https://coastwatch.pfeg.noaa.gov/erddap', 'jplMURSST41')

# para ver el metadato
print(remote)

#%% main
remote.clearQuery()
remote.setResultVariables('analysed_sst')

for ii in range(0,len(dates),1):

    remote.setSubset(time=dates[ii],
                      latitude=slice(-6, -3),
                      longitude=slice(-73.5,-69.5))
    url=remote.getURL('nc')
    
    fnout=dates[ii]+'.nc'
    urllib.request.urlretrieve(url, fnout)
    print(fnout+' OK---Downloaded')


#%% explorar archivos descargados
# import netCDF4 as nc
# import numpy as np
# file=nc.Dataset('16.01norte_tsm.nc')
#
# sst=np.array(file.variables['analysed_sst'][:])
# sst2=np.squeeze(sst,axis=0)
#
# lon=file.variables['longitude'][:]
# lon=np.array(lon)
# lat=file.variables['latitude'][:]
# lat=np.array(lat)
#
# import matplotlib.pyplot as plt
#
# plt.figure(1)
# plt.pcolor(sst2)
# plt.colorbar()
# # ======== cambios en la figura
# plt.figure(2)
# plt.pcolor(lon,lat,sst2,cmap=plt.cm.jet,vmin=17,vmax=24)
# plt.colorbar()
