Using only R-4.1.3 Package: sf

No GDAL or Python installed.

Workstation config: 32GB RAM

Rasterize VRI from GDB  
Previously impossible on 32 GB machine using R.

sf::gdal\_utils relies on backed C++ gdal rasterize function.  
This relieves the memory load from R.

Add the gr\_skey as a sequence key.

## Rasterize GDB

Reads: VEG\_COMP\_LYR\_R1\_POLY\_2020.gdb  
Produces: vri\_2021\_init.tif

Not initially masked for Water and Land

Produces: vri\_2021\_init.tif  
Naming follows the FAIB AR standard for year.

Note that the supplied file is extracted from:
<https://catalogue.data.gov.bc.ca/dataset/vri-2020-forest-vegetation-composite-layer-1-l1->

Publication date: 2021-02-08

Start: 2022-05-09 07:19:11

    library(sf)

    ## Linking to GEOS 3.9.1, GDAL 3.2.1, PROJ 7.2.1; sf_use_s2() is TRUE

    library(terra)

    ## terra 1.5.21

    drive <- substr(getwd(),1,1)

    # read gdb file

    src <- paste0(drive,':/data/data_projects/vri_gdb/VEG_COMP_LYR_R1_POLY_2020.gdb')
    dest <- paste0(drive,':/data/data_projects/vri_gdb/vri_2021_init.tif')


    gdal_utils("rasterize",src,dest,options = 
                 c('-tr','100',' 100',
                    '-te','159587.5 ','173787.5 ','1881187.5 ','1748187.5',
                    '-ot', 'UInt32 ',
                    '-l', 'VEG_COMP_LYR_R1_POLY',
                    '-a', 'FEATURE_ID' ,
                    '-a_srs','EPSG:3005',
                    '-a_nodata', '-99',
                    '-co','COMPRESS=LZW'),
                    '-overwrite')

    ## Warning in CPL_gdalrasterize(source, destination, options, oo, doo, overwrite, :
    ## GDAL Message 1: organizePolygons() received a polygon with more than 100 parts.
    ## The processing may be really slow. You can skip the processing by setting
    ## METHOD=SKIP, or only make it analyze counter-clock wise parts by setting
    ## METHOD=ONLY_CCW if you can assume that the outline of holes is counter-clock
    ## wise defined

End GDB -&gt; Tif: 2022-05-09 07:22:38

## Mask for Water

Produces: vri\_2021\_fid.tif

Note: mask was supplied by Mike Fowler (FAIB)

    # read the tif
    f3 <- paste0(substr(getwd(),1,1),':/data/data_projects/vri_gdb/vri_2021_init.tif')
    base_raster <- rast(f3)

    # force the CRS 
    crs(base_raster) <- 'epsg:3005'

    # land / water mask supplied by Mike F.
    f4 <- paste0(substr(getwd(),1,1),':/data/data_projects/base_maps/land_water.tif')
    mask_raster <- rast(f4)

    # this mask is a 0/1 of land water
    # there are values of 0 between Vancouver Island and the mainland.
    # these need to be set to NA to be used as a land mask
    # set values in mask to NA where 0
    mask_raster[mask_raster==0] <- NA

    # force the CRS
    crs(mask_raster ) <- 'epsg:3005'


    # set no data to 0 in the base tif
    # this will include water and any isolated nodata values inside land
    base_raster[is.na(base_raster)] <- 0

    # apply the land mask
    # filter out the water
    base_raster_masked <- mask(base_raster,mask_raster)

    # filter out any zeros
    # set to NA
    base_raster_masked[base_raster_masked==0] <- NA

    # write to final tif

    fName <- paste0(substr(getwd(),1,1),':/data/data_projects/vri_gdb/vri_2021_fid.tif')
    writeRaster(base_raster_masked, fName, datatype='INT4U',overwrite=TRUE)

## Raster Brick

Add a sequence key to the original data.

Produces: vri\_2021\_fid\_gr\_skey.tif

Create a 2 band GeoTiff with:

-   feature\_id
-   gr\_skey

<!-- -->

    # set up for gr_skey
    row <- 15744
    col <- 17216
    max_no <- row * col

    # create a second raster
    base_copy <- base_raster_masked

    # set values to sequence
    base_copy[] <- 1:max_no

    # apply the mask
    base_copy <- mask(base_copy,mask_raster)

    # check that there are no zeros
    # take a copy
    r3 <- base_copy

    # where values are greater than 0 set to 1
    r3[r3 >0] <- 1

    # check the frequency
    # should all be 1's
    freq(r3)

    ##      layer value    count
    ## [1,]     1     1 94799052

    # reset the layer names
    names(base_raster_masked) <- 'feature_id'
    names(base_copy) <- 'gr_skey'

    # create list of rasters
    lst <- list(base_raster_masked,base_copy)

    # create a stack of these rasters from list
    raster_stack <-rast(lst)

    # write this to a tiff
    fName <- paste0(substr(getwd(),1,1),':/data/data_projects/vri_gdb/vri_2021_fid_gr_skey.tif')
    writeRaster(raster_stack, fName, datatype='INT4U', overwrite=TRUE)

End: 2022-05-09 07:25:13
