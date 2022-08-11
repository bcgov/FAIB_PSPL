library(raster)

ProvRast<-raster(nrows=15744, ncols=17216, xmn=159587.5, xmx=1881187.5,
                 ymn=173787.5, ymx=1748187.5, 
                 crs="+proj=aea +lat_1=50 +lat_2=58.5 +lat_0=45 +lon_0=-126 +x_0=1000000 +y_0=0 +datum=NAD83 +units=m +no_defs +ellps=GRS80 +towgs84=0,0,0",
                 resolution = c(100,100), vals = NA)

test2<-ProvRast
test2[100]<-17840065

freq(test2)

test2[!is.na(test2[])]

writeRaster(test2, file="c:/data/test2.tif", overwrite=TRUE)


test<-raster('C:/data/test2.tif')
test[!is.na(test[])]

freq(test)
