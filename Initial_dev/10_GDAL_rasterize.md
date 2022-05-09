## Old Methodology

Using gdal\_rasterize from a GDAL isntallation

Start: 2022-05-09 12:21:30

Version:

    # gdal_rasterize_version  
    system2('gdal_rasterize',args='--version',stdout = TRUE)

    ## [1] "GDAL 3.4.2, released 2022/03/08"

    #f_name <- 'D:/data/data_projects/base_maps/tsa13_vri.gdb'
    #f_out <- 'D:/data/data_projects/base_maps/tsa13_vri.tif'

    f_name <- 'D:/data/data_projects/vri_gdb/VEG_COMP_LYR_R1_POLY_2020.gdb'
    f_out <-  'D:/data/data_projects/vri_gdb/VEG_COMP_LYR_R1_POLY_2020.tif'




    cmd <- paste0(c('-tr','100 100',
                    '-te','159587.5 173787.5 1881187.5 1748187.5',
                    '-ot', 'UInt32 ',
                    '-l', 'VEG_COMP_LYR_R1_POLY',
                    '-a', 'FEATURE_ID' ,
                    '-a_srs','EPSG:3005',
                    '-a_nodata', '-99 ',
                    '-co', 'COMPRESS=LZW',
                      f_name,
                      f_out))



    system2('gdal_rasterize',args=cmd,wait=TRUE,stderr=TRUE)

    ## [1] "Warning 1: organizePolygons() received a polygon with more than 100 parts. The processing may be really slow.  You can skip the processing by setting METHOD=SKIP, or only make it analyze counter-clock wise parts by setting METHOD=ONLY_CCW if you can assume that the outline of holes is counter-clock wise defined"

End1 : 2022-05-09 12:24:44
