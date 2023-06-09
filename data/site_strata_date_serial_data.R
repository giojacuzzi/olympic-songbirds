## Read date, site, strata, serial table from file
## Metadata:
# SurveyID        Identifier for the ARU deployment (i.e., period of time when an ARU was set in a site)
# SiteID          Identifier for the location
# DataYear        Year data were collected
# DeployNo        This is for finding a deployment datasheets (if needed), which were scanned in batches corresponding to batches of units deployment in a ~2-week period
# StationName     Unique identifier for the location
# StationName_AGG If a location was shifted between 2021 and 2022, name of the station/location the data are intended to represent (i.e., aggregate to)
# SurveyType      Acoustic or habitat survey
# SerialNo        ARU serial number
# SurveyDate      Date that audio data was downloaded for, in 1-hour files (Minis or SM4) or 5.5 hour files (SM2)
# DataHours       Number of hours in that day with audio data
# UnitType        Songmeter Minis (SMA), Songmeter SM4 (S4A), and Songmeter SM2 (SM2). The large majority of data were collected using Minis, the others were used only as needed to for round out deployments.
# Strata          Habitat type of the station
# UTM_E           Station Easting
# UTM_N           Station Northing

source('global.R')
library(xlsx)

get_site_strata_date_serial_data = function() {
  
  file = 'data/ARUdates-site-strata_v2.xlsx'
  
  message('Reading ', file)
  data = read.xlsx(file, sheetName = 'ARUdates-site-strata')
  
  cols_to_factor = c('SurveyID', 'SiteID', 'DataYear', 'DeployNo', 'StationName', 'StationName_AGG', 'SurveyType', 'SerialNo', 'UnitType', 'Strata')
  data[cols_to_factor] = lapply(data[cols_to_factor], factor)
  data$SurveyDate = as.Date(data$SurveyDate) #as.POSIXct(data$SurveyDate, tz=tz, format='%d/%m/%Y')
  
  return(data)
}

## Additional info:
# Sample rate was 32 kHz (or it was supposed to be!) on everything
# Gain settings were 16 dB for SM2 and SM4s and 18 dB for Minis
# (according to Wildlife Acoustics those are equivalent gain settings
# across the different units).
# Everything was channel left, although there was one deployment where some
# got recorded in stereo by accident (no mic, though, so it's empty audio).