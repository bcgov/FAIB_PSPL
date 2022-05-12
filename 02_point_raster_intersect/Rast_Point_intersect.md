## test VRI raster intersect with PSPL points

Running on 8GB laptop

Start: 2022-05-11 16:59:51

    library(sf)

    ## Linking to GEOS 3.9.1, GDAL 3.2.1, PROJ 7.2.1; sf_use_s2() is TRUE

    library(terra)

    ## terra 1.5.21

    # read Provincial fid tif
    fn1 <- paste0(substr(getwd(),1,1),':/data/data_projects/base_data/vri_2021_fid_gr_skey.tif')
    r <- rast(fn1)

    # read Prince George PSPL point set
    fn2 <- paste0(substr(getwd(),1,1),':/Data/data_projects/PSPL_2021/data/Site_Prod_Kootenay_lake.gdb')
    p <- vect(fn2)

    n <- nrow(p)

    print(paste0('Read n rows: ',n))

    ## [1] "Read n rows: 1066597"

    Sys.time()

    ## [1] "2022-05-11 17:00:26 PDT"

    # add id to point data
    p$pspl_id <- seq(1:nrow(p))


    #crop raster to point extent + 1

    # define extent from p add 1 m all around
    e <- ext(p)
    e[1] <- e[1] - 1
    e[2] <- e[2] + 1
    e[3] <- e[3] - 1
    e[4] <- e[4] + 1

    # crop the raster using the extent
    rc <- crop(r,e)

    Sys.time()

    ## [1] "2022-05-11 17:00:29 PDT"

    # extract the raster data at the x,y of the points
    x <- extract(rc,p)

    # drop the geometry by changing to data frame
    ps_df <- as.data.frame(p)

    # join the raster to the point
    # this will bring all data from the raster
    #ps_df$r <- x[, -1]

    # join raster data feature_id
    ps_df$feature_id <- x[,"feature_id"]

    # join raster data gr_skey
    ps_df$gr_skey <- x[,"gr_skey"]

    n <- nrow(ps_df)

    print(paste0('joined n rows: ',n ))

    ## [1] "joined n rows: 1066597"

    Sys.time()

    ## [1] "2022-05-11 17:00:56 PDT"

    # where feature_id is valid
    ps_df$chk[!is.na(ps_df$feature_id)] <- 1

    s <- sum(ps_df$chk)

    print(paste0('num rows with valid feature_id: ', s))

    ## [1] "num rows with valid feature_id: 1066597"

    # export to csv, append if exists
    fn3 <- paste0(substr(getwd(),1,1),':/data/data_projects/base_data/pspl_out.csv')
    data.table::fwrite(ps_df,fn3,sep=',',append=TRUE)

End: 2022-05-11 17:00:56
