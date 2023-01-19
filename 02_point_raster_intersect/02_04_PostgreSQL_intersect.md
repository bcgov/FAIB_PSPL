## VRI spatial intersect with PSPL points

Assumes veg\_comp\_spatial exists.  
assumes that the PSPL points have been loaded: unit 1.. unit n

### Technical Note:  
 unit point files can be created by either:

-  sf::gdal_utils,vectortranslate
 OR
 
- OGR2ogr

The tables produced are the same.  


Start: 2023-01-17 10:41:51

    year <- '2022'


    library(RPostgreSQL)

    ## Loading required package: DBI

    # set up for load to PostgreSQL
    # schema must include public for geom functions to work.
    schema <- paste0('msyt_',year,',public')
    opt <- paste0("-c search_path=",schema)
    user_name <- 'results'
    database <- 'msyt'




    # this is where the unzipped files are placed locally
    local_pspl_folder <- paste0(substr(getwd(),1,1),':/data/data_projects/AR2022/PSPL/gdb_data')

    # build list of the PSPL gdbs
    # list of gdb files to process
    f_list <- list.files(local_pspl_folder,full.names = TRUE)

    #number of files to process
    num_units = length(f_list)

    con <- dbConnect('PostgreSQL',dbname=database,user=user_name,options=opt)

    # pre delete 
    q1 <- 'drop table if exists pspl_fid_merged'
    dbExecute(con,q1)

    ## [1] 0

    q1 <- 'create table pspl_fid_merged 
    (
     feature_id integer,
     id_tag     text,
     at_si      real,
     ba_si      real,
     bg_si      real,
     bl_si      real,
     cw_si      real,
     dr_si      real,
     ep_si      real,
     fd_si      real,
     hm_si      real,
     hw_si      real,
     lt_si      real,
     lw_si      real,
     pa_si      real,
     pl_si      real,
     pw_si      real,
     py_si      real,
     sb_si      real,
     se_si      real,
     ss_si      real,
     sw_si      real,
     sx_si      real,
     yc_si      real,
     unit_no    integer
     )'
     
     
    dbExecute(con,q1)

    ## [1] 0

    dbDisconnect(con)

    ## [1] TRUE

## process each point table

Note that the intersection is using st\_contains(vri,point).

This may fail in what is expected to be a very small subset it the point
falls exactly on the vri polygon line.

There are examples where the PSPL point is OUTSIDE the VRI boundary.

Arrow, Arrowsmith as examples.

Ignore these and move on.

id\_tag = 01\_082F\_16203\_04799

End: 2023-01-17 12:42:08
