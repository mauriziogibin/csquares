
convert.ICES.lat.lon.full <- function(ices) {
# split the ICES rectangle in to the number part and the letter part
# the number part relates to latitude, the letter part relates to longitude 

		part1 <- substr(ices,1,2)
		part2 <- substr(ices,3,4)
		
# get two look up tables, with latlabels and values and 
# lon labels and values
		latlabels <- 01:99
		latvalues <- seq(36,85,0.5)+0.25
		lonlabels <- c(paste("A",0:3,sep=""),paste("B",0:9,sep=""),paste("C",0:9,sep=""),paste("D",0:9,sep=""),
		               paste("E",0:9,sep=""),paste("F",0:9,sep=""),paste("G",0:9,sep=""),paste("H",0:9,sep=""),
		               paste("I",0:9,sep=""),paste("J",0:9,sep=""),paste("K",0:9,sep=""),paste("L",0:9,sep=""),
		               paste("M",0:9,sep=""),paste("N",0:9,sep=""),paste("O",0:9,sep=""),paste("P",0:9,sep=""),
		               paste("Q",0:9,sep=""),paste("R",0:9,sep=""),paste("S",0:9,sep=""),paste("T",0:9,sep=""),
		               paste("U",0:9,sep=""),paste("V",0:9,sep=""),paste("W",0:9,sep=""))
		lonvalues <- (-44:179)+0.5

		
# use the latlabels to work out the lat values for each row of the vector 
		indx <- match(part1,latlabels)
		lat <- latvalues[indx]
 # use the lonlabels to work out the lon values for each row of the vector 
		indx <- match(part2,lonlabels)
		lon <- lonvalues[indx]
return(data.frame(lat,lon))
}





