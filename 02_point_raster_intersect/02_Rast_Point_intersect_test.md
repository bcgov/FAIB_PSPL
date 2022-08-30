## VRI raster intersect with PSPL points

Use a test SHP file with a small subset of points

Start: 2022-08-30 14:28:40

## Test using a small shape file of points from PSPL

    library(sf)

    ## Linking to GEOS 3.9.1, GDAL 3.2.1, PROJ 7.2.1; sf_use_s2() is TRUE

    library(terra)

    ## terra 1.5.21

    library(RPostgreSQL)

    ## Loading required package: DBI

    library(tidyverse)

    ## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --

    ## v ggplot2 3.3.5     v purrr   0.3.4
    ## v tibble  3.1.6     v dplyr   1.0.8
    ## v tidyr   1.2.0     v stringr 1.4.0
    ## v readr   2.1.2     v forcats 0.5.1

    ## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    ## x ggplot2::arrow() masks terra::arrow()
    ## x tidyr::extract() masks terra::extract()
    ## x dplyr::filter()  masks stats::filter()
    ## x dplyr::lag()     masks stats::lag()
    ## x dplyr::src()     masks terra::src()

    # set up for load to PostgreSQL
    schema <- 'msyt_2022'
    opt <- paste0("-c search_path=",schema)
    user_name <- 'postgres'
    database <- 'msyt'
    con <- dbConnect('PostgreSQL',dbname=database,user=user_name,options=opt)


    # read Provincial fid tif
    fn1 <- paste0(substr(getwd(),1,1),':/data/data_projects/AR2022/PSPL/vri_raster.tif')
    raster_fid <- rast(fn1)


    # test file
    shp_name <- 'd:/data/data_projects/AR2022/PSPL/gdb_data/test.shp'

## process the shape

-   Read the shape
-   join to the point attribute data
-   crop the PROV raster at the extent of each GDB + 51m
-   extract feature id from the raster using extract at the x,y location
    of the point
-   write to CSV

<!-- -->

    rast_intersect <- function(r,pf,n){
      
      # r = PROV raster of fid
      # pf = PSPL point set
      # n = counter

      # read the point file
      point_set <- vect(pf)
      
      # point_set <- vect(shp_name)
      # r <- raster_fid
      # n <- 1
      
      # lower case the names
      # had to add ID to replace OBJECTID due to SHP format spec.
      names(point_set) <- c("id","id_tag","at_si","ba_si","bg_si","bl_si","cw_si","dr_si","ep_si","fd_si","hm_si","hw_si","lt_si","lw_si","pa_si","pl_si","pw_si","py_si","sb_si","se_si","ss_si","sw_si","sx_si","yc_si","bapid","pem_spp","bgc_label","tsa_number")
      
      # number points in pspl
      n_points <- nrow(point_set)

      # add id to point data
      point_set$id <- seq(1:nrow(point_set))

      #crop raster to point extent + 51

      # define extent from p add 1 m all around
      e <- ext(point_set)
      e[1] <- e[1] - 51
      e[2] <- e[2] + 51
      e[3] <- e[3] - 51
      e[4] <- e[4] + 51

      # crop the raster using the extent
      rc <- crop(r,e)
      
      
      
      # extract the raster data at the x,y from the points
      # at the x,y location of the point, get the raster based feature_id
      # in an array of which the array location matches the array location of the point data
      
      x <- terra::extract(rc,point_set)

      # drop the geometry by changing to data frame
      point_set <- as.data.frame(point_set)


      # join raster data feature_id
      point_set$feature_id <- x[,"feature_id"]

      
      # note that this works for CSV
      # export to PostgreSQL will keep as double
      # unless field.types are specified
      # but this has to be a named vector
      # handle the conversion in SQL
      
      point_set[, 3:24] <- round(point_set[, 3:24], digits = 1)

      
      # add a table number to allow tracking
      point_set$tab_no <- n
      

      # export to csv, append if exists
      fn3 <- paste0(substr(getwd(),1,1),':/Data/data_projects/AR2022/PSPL/csv',n,'.csv')
      data.table::fwrite(point_set,fn3,sep=',',append=FALSE)
      
      # load to PostgreSQL
      #if (n ==1) {
      #  dbWriteTable(con,'pspl_raw',p,row.names=FALSE,overwrite=TRUE)
      #} else {
      #  dbWriteTable(con,'pspl_raw',p,row.names=FALSE,overwrite=FALSE,append = TRUE)
      #}
      
      
      rows_out <- nrow(point_set)
      
      fo <- data.frame('num_points' = n_points,'rows_out' = rows_out, 'n' = n)
      
      return(fo)

    }

    # initialize the counter
    n <- 1

    # create reporting data frame
    report <- data.frame('num_points' = '','rows_out' = '', 'n' = '')



    ## test single

    a1 <- rast_intersect(raster_fid,shp_name,1)

    report <- rbind(report,a1)

    library(kableExtra)

    ## 
    ## Attaching package: 'kableExtra'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     group_rows

    kable(report,format="markdown") %>%
    kable_styling(bootstrap_options = c("striped"),full_width=F,font_size=13,position = 'left')

    ## Warning in kable_styling(., bootstrap_options = c("striped"), full_width = F, :
    ## Please specify format in kable. kableExtra can customize either HTML or LaTeX
    ## outputs. See https://haozhu233.github.io/kableExtra/ for details.

<table>
<thead>
<tr class="header">
<th style="text-align: left;">num_points</th>
<th style="text-align: left;">rows_out</th>
<th style="text-align: left;">n</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">44</td>
<td style="text-align: left;">44</td>
<td style="text-align: left;">1</td>
</tr>
</tbody>
</table>

Table 1. PSPL Summary

End: 2022-08-30 14:28:44
