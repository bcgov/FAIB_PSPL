## Create a grid to full extent of Province

Fill with sequence values starting with 1 at top left corner.

-   xmin = 159587.5  
-   xmax = 1881187.5  
-   ymin = 173787.5  
-   ymax = 1748187.5

Number rows: 15744  
Number Columns: 17216

Total Cells: 271,048,704

EPSG:3005

## Note that GDAL is not installed

Using packages sf and terra only  
Running:  
R 4.1.3  
RStudio RStudio 2022.02.1+461

Start: 2022-05-09 07:01:02

    library(sf)
    library(terra)


    row <- 15744
    col <- 17216

    max_no <- row * col


    ProvRast <- rast(nrows = row, ncols = col, 
                    xmin = 159587.5, xmax = 1881187.5, 
                    ymin = 173787.5, ymax = 1748187.5, 
                    crs='epsg:3005',
                    resolution = c(100, 100), 
                    vals = seq(1,max_no,1) )

    ProvRast[]<-1:max_no

    fName <- paste0(substr(getwd(),1,1),':/data/data_projects/prov_raster.tif')
    writeRaster(ProvRast, fName, overwrite=TRUE)

Note that the Provincial Raster can be assigned values in 2 ways:

-   In the Spatraster define: vals = seq(1,max\_no,1)
-   Create the raster then assinge the values
    -   ProvRast\[\] 1:max\_no

End: 2022-05-09 07:01:23
