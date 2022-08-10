Develop a standardized approach to rasterization for FAIB data
processing.

### Method 1: GDB to TIF using sf::gdal\_utils

Using only R-4.1.3 Package: sf

No GDAL or Python installed.

Workstation config: 32GB RAM

Rasterize VRI from GDB Previously impossible on 32 GB machine using R.

sf::gdal\_utils relies on backed C++ gdal rasterize function.  
This relieves the memory load from R.

Reads:
D:/data/data\_projects/AR2022/vri/VEG\_COMP\_LYR\_R1\_POLY\_2021.gdb

Note that the supplied file is extracted from:
<https://catalogue.data.gov.bc.ca/dataset/vri-2020-forest-vegetation-composite-layer-1-l1->

Publication date: 2021-02-08

Start: 2022-08-10 09:01:07

    library(sf)

    ## Linking to GEOS 3.9.1, GDAL 3.2.1, PROJ 7.2.1; sf_use_s2() is TRUE

    library(terra)

    ## terra 1.5.21

    # read gdb file

    src <- 'D:/data/data_projects/AR2022/vri/VEG_COMP_LYR_R1_POLY_2021.gdb'
    dest <- paste0(substr(getwd(),1,1),':/data/data_projects/VRI_Rasterization/method1.tif')


    gdal_utils("rasterize",src,dest,options = 
                 c('-tr','100',' 100',
                    '-te','159587.5 ','173787.5 ','1881187.5 ','1748187.5',
                    '-ot', 'UInt32 ',
                    '-l', 'VEG_COMP_LYR_R1_POLY',
                    '-a', 'FEATURE_ID' ,
                    '-a_srs','EPSG:3005',
                    '-a_nodata', '0',
                    '-co','COMPRESS=LZW'),
                    '-overwrite')

    ## Warning in CPL_gdalrasterize(source, destination, options, oo, doo, overwrite, :
    ## GDAL Message 1: organizePolygons() received a polygon with more than 100 parts.
    ## The processing may be really slow. You can skip the processing by setting
    ## METHOD=SKIP, or only make it analyze counter-clock wise parts by setting
    ## METHOD=ONLY_CCW if you can assume that the outline of holes is counter-clock
    ## wise defined

End Method 1 GDB -&gt; Tif: 2022-08-10 09:04:47

## Method 2: PostgreSQL to TIF using sf::gdal\_utils

    src <- "PG:dbname='msyt' user='postgres'"
    spatial_table <- 'msyt_2022.veg_comp_spatial'
    dest <- paste0(substr(getwd(),1,1),':/data/data_projects/VRI_Rasterization/method2.tif')


    gdal_utils("rasterize",src,dest,options = 
                 c('-tr','100',' 100',
                    '-te','159587.5 ','173787.5 ','1881187.5 ','1748187.5',
                    '-ot', 'UInt32 ',
                    '-l', spatial_table,
                    '-a', 'FEATURE_ID' ,
                    '-a_srs','EPSG:3005',
                    '-a_nodata', '0',
                    '-co','COMPRESS=LZW'),
                    '-overwrite')

End Method 2 PostgreSQL -&gt; Tif: 2022-08-10 09:08:29

## Method 3: gdal\_rasterize GDB

Requires installation of GDAL and resetting of ENV

    src <- 'D:/data/data_projects/AR2022/vri/VEG_COMP_LYR_R1_POLY_2021.gdb'
    dest <- paste0(substr(getwd(),1,1),':/data/data_projects/VRI_Rasterization/method3.tif')


    cmd <- paste0(c('-tr','100',' 100',
                    '-te','159587.5 ','173787.5 ','1881187.5 ','1748187.5',
                    '-ot', 'UInt32 ',
                    '-l', 'VEG_COMP_LYR_R1_POLY',
                    '-a', 'FEATURE_ID' ,
                    '-a_srs','EPSG:3005',
                    '-a_nodata', '0',
                    '-co','COMPRESS=LZW',src,dest))

    gdal_rasterize <- 'C:/Program Files/GDAL/gdal_rasterize.exe'

    system2(gdal_rasterize,args=cmd,wait=TRUE,stderr = TRUE)

    ## [1] "Warning 1: organizePolygons() received a polygon with more than 100 parts. The processing may be really slow.  You can skip the processing by setting METHOD=SKIP, or only make it analyze counter-clock wise parts by setting METHOD=ONLY_CCW if you can assume that the outline of holes is counter-clock wise defined"

End Method 3 gdal\_rasterize GDB: 2022-08-10 09:11:42

## Method 4: gdal\_rasterize PostgreSQL

Requires installation of GDAL and resetting of ENV

    src <- shQuote("PG:dbname='msyt' user='postgres'")
    spatial_table <- 'msyt_2022.veg_comp_spatial'
    dest <- paste0(substr(getwd(),1,1),':/data/data_projects/VRI_Rasterization/method4.tif')

    cmd <- paste0(c('-tr','100',' 100',
                    '-te','159587.5 ','173787.5 ','1881187.5 ','1748187.5',
                    '-ot', 'UInt32 ',
                    '-l', spatial_table,
                    '-a', 'FEATURE_ID' ,
                    '-a_srs','EPSG:3005',
                    '-a_nodata', '0',
                    '-co','COMPRESS=LZW',src,dest))

    # point to the EXE
    gdal_rasterize <- 'C:/Program Files/GDAL/gdal_rasterize.exe'

    system2(gdal_rasterize,args=cmd,wait=TRUE,stderr = TRUE)

    ## character(0)

End Method 4 gdal\_rasterize PostgreSQL: 2022-08-10 09:15:09

    #Simple database connectivity functions
    getSpatialQuery<-function(sql){
      conn<-DBI::dbConnect(dbDriver("PostgreSQL"),
                           dbname='msyt', 
                           user='postgres' ,
                           )
      
      on.exit(dbDisconnect(conn))
      st_read(conn, query = sql)
    }

    #Get dummy layer for projection (too lazy to write it) 
    lyr<-getSpatialQuery(paste("SELECT geom FROM public.gcbp_carib_polygon"))

    #Make an empty provincial raster aligned with hectares BC
    ProvRast <- raster(
      nrows = 15744, ncols = 17216, xmn = 159587.5, xmx = 1881187.5, ymn = 173787.5, ymx = 1748187.5, 
      crs = st_crs(lyr)$proj4string, resolution = c(100, 100), vals = 0
    )

    layer<-getSpatialQuery("SELECT feature_id, shape FROM public.veg_comp_lyr_r1_poly2021")

    layer.ras <-fasterize::fasterize(sf= layer, raster = ProvRast , field = "feature_id")
    rm(layer)
    gc()

    writeRaster(layer.ras, file="vri2021_id.tif", format="GTiff", overwrite=TRUE)

End: 2022-08-10 09:15:09
