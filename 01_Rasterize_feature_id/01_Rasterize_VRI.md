Develop a standardized approach to rasterization for FAIB data
processing.

AR2022

Using only R-4.1.3 Package: sf

No GDAL or Python installed.

Workstation config: 32GB RAM

Rasterize VRI from PostgreSQL Previously impossible on 32 GB machine
using R.

sf::gdal\_utils relies on backed C++ gdal rasterize function.  
This relieves the memory load from R.

Links to: GEOS 3.9.1, GDAL 3.2.1, PROJ 7.2.1

Start: 2022-08-30 13:12:16

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
<td style="text-align: left;">ymax</td>
<td style="text-align: left;">1735787.5</td>
</tr>
</tbody>
</table>

### No Data Value

Value = 0

### Output Data Type

Int32

In the GDAL documentation, the list of supported integer data types
includes:

-   Int16 (short)
-   Int32 (long)

Since the max value for Int32 is 2,147,483,647 this should be adequate
to allow for future feature\_ids.

## Method: PostgreSQL to TIF using sf::gdal\_utils

Links to a local PostgreSQL database that used an Oracle Foreign data
wrapper to create a copy of idwprod1.veg\_comp\_lyr\_r1\_poly.
PostgreSQL table is called veg\_comp\_spatial and only contains
feature\_id and wkb\_geometry.

Define standard extent , noData Value and output dataType

    # standardize extents
    xmin <- 273287.5
    xmax <- 1870587.5
    ymin <- 367787.5
    ymax <- 1735787.5

    nodata <- 0

    dataType <- 'Int32'

Read PostgreSQL spatial table and export to Tif

Set the Tif layer name to be feature\_id

    src <- "PG:dbname='msyt' user='postgres'"
    spatial_table <- 'msyt_2022.veg_comp_spatial'
    dest <- paste0(substr(getwd(),1,1),':/data/data_projects/AR2022/PSPL/vri_raster.tif')


    sf::gdal_utils("rasterize",src,dest,options = 
                 c('-tr','100',' 100',
                    '-te',xmin,ymin,xmax,ymax,
                    '-ot', dataType,
                    '-l', spatial_table,
                    '-a', 'FEATURE_ID' ,
                    '-a_srs','EPSG:3005',
                    '-a_nodata', nodata,
                    '-co','COMPRESS=LZW'),
                    '-overwrite')

    ## Warning in CPL_gdalrasterize(source, destination, options, oo, doo, overwrite, :
    ## GDAL Error 4: Unable to open D:/data/data_projects/AR2022/PSPL/vri_raster.tif to
    ## obtain file list.

    # update for NA
    r1 <- terra::rast(dest)
    r1[is.na(r1)]  <- 0

    # name the layer: feature_id
    names(r1) <- 'feature_id'

    # overwrite to destination
    terra::writeRaster(r1, dest, datatype='INT4U', overwrite=TRUE)

Cross check the feature id

    library(tidyverse)

    ## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --

    ## v ggplot2 3.3.5     v purrr   0.3.4
    ## v tibble  3.1.6     v dplyr   1.0.8
    ## v tidyr   1.2.0     v stringr 1.4.0
    ## v readr   2.1.2     v forcats 0.5.1

    ## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

    library(data.table)

    ## 
    ## Attaching package: 'data.table'

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     between, first, last

    ## The following object is masked from 'package:purrr':
    ## 
    ##     transpose

    con <- RPostgreSQL::dbConnect('PostgreSQL',dbname='msyt')

    psql_fid <- DBI::dbGetQuery(con,'select feature_id from msyt_2022.veg_comp')

    RPostgreSQL::dbDisconnect(con)

    ## [1] TRUE

    # read the Tif that was written
    dest <- paste0(substr(getwd(),1,1),':/data/data_projects/AR2022/PSPL/vri_raster.tif')
    r1 <- terra::rast(dest)

    tif_fid <- as.data.table(terra::values(r1))

    tif_fid <- unique(tif_fid)
    names(tif_fid) <- 'feature_id'

    # tif values should only come from the VRI
    # if there are values in the TIF that aren't in the VRI spatial
    # there is a problem (like an integer value rounding as an example)
    tif_only <- tif_fid %>% subset(!feature_id %in% psql_fid$feature_id)

    # there will be raster values missing from TIF
    # this is an artifact of the rasertization process
    # and is expected
    psql_only <- psql_fid %>% subset(!feature_id %in% tif_fid$feature_id)

## Tif Values NOT found in VRI spatial

tif values should only come from the VRI  
if there are values in the TIF that aren’t in the VRI spatial  
there is a problem (like an integer value rounding as an example)

Only in Tif: 1 rows

    if (nrow(tif_only ==1)){
      kableExtra::kable(tif_only)
    }

<table>
<thead>
<tr>
<th style="text-align:right;">
feature\_id
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
0
</td>
</tr>
</tbody>
</table>

## VRI spatial features NOT found in Raster

there will be raster values missing from TIF  
this is an artifact of the rasertization process  
and is expected

In Postgresql, **NOT** in Tif 347744

PostgreSQL -&gt; Tif: 2022-08-30 13:16:24

End: 2022-08-30 13:16:24
