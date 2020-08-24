########################################################################################################
########################################################################################################
#
# S. HOLMES 2017-08-11
#
########################################################################################################
########################################################################################################
#
# Takes any ICES rectangle code or codes and:
# converts to lat and lon values (using function originaly written by liz Clarke)
# converts the lat and lon values to c-squares notation (using code supplied to GitHub by Martin Pastoors)
#
########################################################################################################

#SOURCED CODE
########################################################################################################

source("C:/Holmes/Work/Common_R_functions/ConversionFunctions/csquare.R")
source("C:/Holmes/Work/Common_R_functions/ConversionFunctions/convert.ICES.lat.lon.full.R")

########################################################################################################

#INROUTES AND OUTROUTES
########################################################################################################
MyDrive<-"C:"
wd<-file.path(MyDrive,'STECF','STECF_effort','2017','New_FDI','C-SQUARES','Test_Data'); setwd(wd)

########################################################################################################

# little test to show you can get multiple conversions at a time from csquare_encode
#lons <- c(-1.2,0.2)
#lats <- c(55.0,55.2)
#td <- csquare_encode(lats,lons,0.5)

#pre <- as.character(preices) ## doesn't work as converts to scientific E notation

#ices <- c("39E8","39E9")
#tll <- convert.ICES.lat.lon.full(ices)
#tdtll  <- csquare_encode(unlist(tll[1]),unlist(tll[2]),0.5)


#filename <- "Table_I_SPATIAL_EFFORT.csv"
filename <- "ICES_RECT_ONLY.csv"
df <- read.csv(file.path(filename),sep=",",header=T)

dfll <- convert.ICES.lat.lon.full(df$ICES.RECT)

dflon1 <- dfll$lon + 0.25
dflon2 <- dfll$lon - 0.25

#not needed
#dfcsll1 <- data.frame(lat=dfll$lat,lon=dflon1)
#dfcsll2 <- data.frame(lat=dfll$lat,lon=dflon2)
#dfcsquare1 <- csquare_encode(unlist(dfcsll1[1]),unlist(dfcsll1[2]),0.5)
#dfcsquare2 <- csquare_encode(unlist(dfcsll2[1]),unlist(dfcsll2[2]),0.5)

dfcsquare1 <- csquare_encode(dfll$lat,dflon1,0.5)
dfcsquare2 <- csquare_encode(dfll$lat,dflon2,0.5)

dfout <- df
dfout$CSQUARE1 <- dfcsquare1
dfout$CSQ1_lat <- dfll$lat
dfout$CSQ1_lon <- dflon1

dfout$CSQUARE2 <- dfcsquare2
dfout$CSQ2_lat <- dfll$lat
dfout$CSQ2_lon <- dflon2


outroute <- wd
fname.split <- unlist(strsplit(filename, "[.]"))
fname <- paste(fname.split[1],"plus_CSQUARES",sep="_")
write.table(dfout,paste(outroute,"/",fname,".csv",sep=""), append = FALSE, quote = TRUE, sep = ",",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE, qmethod = c("escape", "double"),
            fileEncoding = "")

