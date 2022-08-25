Develop a standardized approach to rasterization for FAIB data
processing.

### Method 1: GDB to TIF using sf::gdal\_utils

Using only R-4.1.3 Package: sf

No GDAL or Python installed.

Workstation config: 32GB RAM

Rasterize VRI from GDB Previously impossible on 32 GB machine using R.

sf::gdal\_utils relies on backed C++ gdal rasterize function.  
This relieves the memory load from R.

Links to: GEOS 3.9.1, GDAL 3.2.1, PROJ 7.2.1; sf\_use\_s2() is TRUE

Reads:
D:/data/data\_projects/AR2022/vri/VEG\_COMP\_LYR\_R1\_POLY\_2021.gdb

Note that the supplied file is extracted from:

catalogue.data.gov.bc.ca/dataset

search for : veg\_comp\_lyr\_r1\_poly

Publication date: 2021-02-08 (which is wrong by the way), which should
actually be 2022

Start: 2022-08-25 15:45:47

## Raster Standards

### Spatial Extent

<table>
<thead>
<tr class="header">
<th style="text-align: left;">Extent</th>
<th style="text-align: left;">Value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">xmin</td>
<td style="text-align: left;">273287.5</td>
</tr>
<tr class="even">
<td style="text-align: left;">xmax</td>
<td style="text-align: left;">1870587.5</td>
</tr>
<tr class="odd">
<td style="text-align: left;">ymin</td>
<td style="text-align: left;">367787.5</td>
</tr>
<tr class="even">
<td style="text-align: left;">ymax &lt;- 1735787.5</td>
<td style="text-align: left;"></td>
</tr>
</tbody>
</table>

### No Data Value

Value = 0

### Output Data Type

Int32

IN the GDAL documentation, the list of supported integer data types
includes:

-   Int16 (short)
-   Int32 (long)

Since the max value for Int32 is 2,147,483,647 this should be adequate
to allow for future feature\_ids.

    library(sf)

    ## Linking to GEOS 3.9.1, GDAL 3.2.1, PROJ 7.2.1; sf_use_s2() is TRUE

    library(terra)

    ## terra 1.5.21

    library(RPostgreSQL)

    ## Loading required package: DBI

    library(raster)

    ## Loading required package: sp

    library(tidyverse)

    ## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --

    ## v ggplot2 3.3.5     v purrr   0.3.4
    ## v tibble  3.1.6     v dplyr   1.0.8
    ## v tidyr   1.2.0     v stringr 1.4.0
    ## v readr   2.1.2     v forcats 0.5.1

    ## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    ## x ggplot2::arrow() masks terra::arrow()
    ## x tidyr::extract() masks raster::extract(), terra::extract()
    ## x dplyr::filter()  masks stats::filter()
    ## x dplyr::lag()     masks stats::lag()
    ## x dplyr::select()  masks raster::select()
    ## x dplyr::src()     masks terra::src()

    # read gdb file

    src <- 'D:/data/data_projects/AR2022/vri/VEG_COMP_LYR_R1_POLY_2021.gdb'
    dest <- paste0(substr(getwd(),1,1),':/data/data_projects/VRI_Rasterization/method1.tif')

    #SpatExtent : 273287.5, 1870587.5, 367787.5, 1735787.5 (xmin, xmax, ymin, ymax)


    # standardize extents
    xmin <- 273287.5
    xmax <- 1870587.5
    ymin <- 367787.5
    ymax <- 1735787.5

    nodata <- 0

    dataType <- 'Int32'


    gdal_utils("rasterize",src,dest,options = 
                 c('-tr','100',' 100',
                    '-te',xmin,ymin,xmax,ymax,
                    '-ot', dataType,
                    '-l', 'VEG_COMP_LYR_R1_POLY',
                    '-a', 'FEATURE_ID' ,
                    '-a_srs','EPSG:3005',
                    '-a_nodata', nodata,
                    '-co','COMPRESS=LZW'),
                    '-overwrite')

    ## Warning in CPL_gdalrasterize(source, destination, options, oo, doo, overwrite, :
    ## GDAL Message 1: organizePolygons() received a polygon with more than 100 parts.
    ## The processing may be really slow. You can skip the processing by setting
    ## METHOD=SKIP, or only make it analyze counter-clock wise parts by setting
    ## METHOD=ONLY_CCW if you can assume that the outline of holes is counter-clock
    ## wise defined

    # update for NA
    r1 <- terra::rast(dest)
    r1[is.na(r1)]  <- 0
    terra::writeRaster(r1, dest, datatype='INT4U', overwrite=TRUE)

End Method 1 GDB -&gt; Tif: 2022-08-25 15:49:33

## Method 2: PostgreSQL to TIF using sf::gdal\_utils

Links to a local PostgreSQL database that used an Oracle Foreign data
wrapper to create a copy of idwprod1.veg\_comp\_lyr\_r1\_poly.
PostgreSQL table is called veg\_comp\_spatial and only contains
feature\_id and wkb\_geometry.

    src <- "PG:dbname='msyt' user='postgres'"
    spatial_table <- 'msyt_2022.veg_comp_spatial'
    dest <- paste0(substr(getwd(),1,1),':/data/data_projects/VRI_Rasterization/method2.tif')


    gdal_utils("rasterize",src,dest,options = 
                 c('-tr','100',' 100',
                    '-te',xmin,ymin,xmax,ymax,
                    '-ot', dataType,
                    '-l', spatial_table,
                    '-a', 'FEATURE_ID' ,
                    '-a_srs','EPSG:3005',
                    '-a_nodata', nodata,
                    '-co','COMPRESS=LZW'),
                    '-overwrite')


    # update for NA
    r1 <- terra::rast(dest)
    r1[is.na(r1)]  <- 0
    terra::writeRaster(r1, dest, datatype='INT4U', overwrite=TRUE)

End Method 2 PostgreSQL -&gt; Tif: 2022-08-25 15:53:17

## Method 3: gdal\_rasterize GDB

Uses an installed GDAL gdal\_rasterize.ex.  
GDAL 3.5.1, released 2022/06/30  
Requires installation of GDAL and resetting of ENV

    src <- 'D:/data/data_projects/AR2022/vri/VEG_COMP_LYR_R1_POLY_2021.gdb'
    dest <- paste0(substr(getwd(),1,1),':/data/data_projects/VRI_Rasterization/method3.tif')


    cmd <- paste0(c('-tr','100',' 100',
                    '-te',xmin,ymin,xmax,ymax,
                    '-ot', dataType,
                    '-l', 'VEG_COMP_LYR_R1_POLY',
                    '-a', 'FEATURE_ID' ,
                    '-a_srs','EPSG:3005',
                    '-a_nodata', nodata,
                    '-co','COMPRESS=LZW',src,dest))

    gdal_rasterize <- 'C:/Program Files/GDAL/gdal_rasterize.exe'

    system2(gdal_rasterize,args=cmd,wait=TRUE,stderr = TRUE)

    ## [1] "Warning 1: organizePolygons() received a polygon with more than 100 parts. The processing may be really slow.  You can skip the processing by setting METHOD=SKIP, or only make it analyze counter-clock wise parts by setting METHOD=ONLY_CCW if you can assume that the outline of holes is counter-clock wise defined"

    # update for NA
    r1 <- terra::rast(dest)
    r1[is.na(r1)]  <- 0
    terra::writeRaster(r1, dest, datatype='INT4U', overwrite=TRUE)

End Method 3 gdal\_rasterize GDB: 2022-08-25 15:56:53

## Method 4: gdal\_rasterize PostgreSQL

Uses gdal\_rasterize.exe (installed)  
Connects to local PostgreSQL database.

    src <- shQuote("PG:dbname='msyt' user='postgres'")
    spatial_table <- 'msyt_2022.veg_comp_spatial'
    dest <- paste0(substr(getwd(),1,1),':/data/data_projects/VRI_Rasterization/method4.tif')

    cmd <- paste0(c('-tr','100',' 100',
                    '-te',xmin,ymin,xmax,ymax,
                    '-ot', dataType,
                    '-l', spatial_table,
                    '-a', 'FEATURE_ID' ,
                    '-a_srs','EPSG:3005',
                    '-a_nodata', nodata,
                    '-co','COMPRESS=LZW',src,dest))

    # point to the EXE
    gdal_rasterize <- 'C:/Program Files/GDAL/gdal_rasterize.exe'

    system2(gdal_rasterize,args=cmd,wait=TRUE,stderr = TRUE)

    ## character(0)

    # update for NA
    r1 <- terra::rast(dest)
    r1[is.na(r1)]  <- 0
    terra::writeRaster(r1, dest, datatype='INT4U', overwrite=TRUE)

End Method 4 gdal\_rasterize PostgreSQL: 2022-08-25 16:00:41

## Method 5: fasterize

Included for information only.

The R package fasterize offers very fast rasterization. However, memory
requirements for the routine require over 50GB of RAM for the process to
run to completion.

    #Simple database connectivity functions
    getSpatialQuery<-function(sql){
      conn <- dbConnect("PostgreSQL",
                           dbname='msyt', 
                           user='postgres' ,
                           )
      
      on.exit(dbDisconnect(conn))
      st_read(conn, query = sql)
      
    }


    # Make an empty provincial raster aligned with hectares BC
    # create SpatRaster so crs can be set
    ProvRast <- rast(
      nrows = 15744, ncols = 17216, xmin = 159587.5, xmax = 1881187.5, ymin = 173787.5, ymax = 1748187.5, 
      crs = 'epsg:3005', resolution = c(100, 100), vals = 0
    )

    # convert to raster so that fasterize can be used
    ProvRast <- raster(ProvRast)

    layer<-getSpatialQuery("SELECT feature_id, wkb_geometry FROM msyt_2022.veg_comp_spatial")

    layer.ras <-fasterize::fasterize(sf= layer, raster = ProvRast , field = "feature_id")
    rm(layer)
    gc()

    tif_name <- 'D:/data/data_projects/VRI_Rasterization/tif_from_fasterize.tif'
    writeRaster(layer.ras, file=tif_name, format="GTiff", datatype='INT4U', overwrite=TRUE)

End: 2022-08-25 16:00:41
