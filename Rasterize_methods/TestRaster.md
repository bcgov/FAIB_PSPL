    library(raster)

    ## Loading required package: sp

    library(terra)

    ## terra 1.5.21

    row <- 15744
    col <- 17216

    max_no <- row * col

    # terra
    ProvRast <- rast(nrows = row, ncols = col, 
                    xmin = 159587.5, xmax = 1881187.5, 
                    ymin = 173787.5, ymax = 1748187.5, 
                    crs='epsg:3005',
                    resolution = c(100, 100), 
                    vals = NA )
                    
    t1  <- ProvRast   
    t1[100]<-17840065
    freq(t1)                

    ##      layer    value count
    ## [1,]     1 17840065     1

Using terra object PsatRaster:  
Here we have set 1 SpatRaster element to 17840065

    # raster
    ProvRast2<-raster(nrows=15744, ncols=17216, xmn=159587.5, xmx=1881187.5,
                     ymn=173787.5, ymx=1748187.5, 
                     crs="+proj=aea +lat_1=50 +lat_2=58.5 +lat_0=45 +lon_0=-126 +x_0=1000000 +y_0=0 +datum=NAD83 +units=m +no_defs +ellps=GRS80 +towgs84=0,0,0",
                     resolution = c(100,100), vals = NA)



    t2<-ProvRast2
    t2[100]<-17840065
    freq(t2)

    ##         value     count
    ## [1,] 17840065         1
    ## [2,]       NA 271048703

Using a raster object:  
Again, we have set 1 RasterLayer element to 17840065

    writeRaster(t1, file="c:/data/test1.tif", overwrite=TRUE)
    writeRaster(t2, file="c:/data/test2.tif", overwrite=TRUE)


    test1<-rast('C:/data/test1.tif')
    test2<-raster('C:/data/test2.tif')

Write then read the Tif files

    freq(test1)

    ##      layer    value count
    ## [1,]     1 17840064     1

Here is the frequency of the Tif SpatRaster elements.

Note that 17840065 has changed to 17840064

    test1

    ## class       : SpatRaster 
    ## dimensions  : 15744, 17216, 1  (nrow, ncol, nlyr)
    ## resolution  : 100, 100  (x, y)
    ## extent      : 159587.5, 1881188, 173787.5, 1748188  (xmin, xmax, ymin, ymax)
    ## coord. ref. : NAD83 / BC Albers (EPSG:3005) 
    ## source      : test1.tif 
    ## name        :    lyr.1 
    ## min value   : 17840065 
    ## max value   : 17840065

But if we look at the SpatRaster itself we see:

Min max values of 17840065

    freq(test2)

    ##         value     count
    ## [1,] 17840064         1
    ## [2,]       NA 271048703

    test2

    ## class      : RasterLayer 
    ## dimensions : 15744, 17216, 271048704  (nrow, ncol, ncell)
    ## resolution : 100, 100  (x, y)
    ## extent     : 159587.5, 1881188, 173787.5, 1748188  (xmin, xmax, ymin, ymax)
    ## crs        : +proj=aea +lat_0=45 +lon_0=-126 +lat_1=50 +lat_2=58.5 +x_0=1000000 +y_0=0 +datum=NAD83 +units=m +no_defs 
    ## source     : test2.tif 
    ## names      : test2 
    ## values     : 17840065, 17840065  (min, max)

and the same happens for the RasterLayer when read from Tif

## Note

using freq() returns 17840064  
whereas the actual data within the raster is 17840065
