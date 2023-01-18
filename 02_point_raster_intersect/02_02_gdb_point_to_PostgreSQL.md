## Import from GDB to PostgreSQL

Start: 2023-01-16 11:20:44

    year <- '2022'

    library(sf)

    ## Linking to GEOS 3.9.1, GDAL 3.2.1, PROJ 7.2.1; sf_use_s2() is TRUE

    library(RPostgreSQL)

    ## Loading required package: DBI

    # set up for load to PostgreSQL
    schema <- paste0('msyt_',year)
    opt <- paste0("-c search_path=",schema)
    user_name <- 'postgres'
    database <- 'msyt'
    con <- dbConnect('PostgreSQL',dbname=database,user=user_name,options=opt)


    # this is where the unzipped files are placed locally
    local_gdb_folder <- paste0(substr(getwd(),1,1),':/data/data_projects/AR2022/PSPL/gdb_data')

    # build list of the PSPL gdbs
    # list of gdb files to process
    f_list <- list.files(local_gdb_folder,full.names = TRUE)
    num_gdb = length(f_list)  #number of files to process

ogr2ogr -f “PostgreSQL” PG:“dbname=msyt”
Site\_Prod\_100\_Mile\_House.gdb Site\_Prod\_100\_Mile\_House –debug ON

## process each gdb

-   Read each GDB
-   export to PostgreSQL

## Load using sf::gdal\_utils

This will bring any NULL values in the GDB as actual NULL in PostgreSQL.

    gdal_utils_gdb_load <- function(pf,n){

      # n <- 1
      # pf <- f_list[1]
      
      # PostgreSQL connection settings
      # schema is not defined
      dest <- c("PG:dbname=msyt user=results")
      
      gdb_fc <- tools::file_path_sans_ext(basename(pf))
      
      # give new layer name the schema name 
      new_layer <- paste0('msyt_',year,'.pspl_unit',n)
      
      
      # Options Notes
      # spatial index is required
      # set geometry name to wkb_geometry
      
      gdal_utils(
        util="vectortranslate",
        source=pf,
        dest,
        options=
          c('-a_srs','EPSG:3005',
            '-gt','10000',
            '-nln',new_layer,
            '-lco', 'GEOMETRY_NAME=wkb_geometry',
            '-overwrite'
            )
        )
      

    }

    # creates unit1 .. unitxx depending on the number of GDBs
      # unit1 does NOT refer to tsa 01
      # it is simply a reference number
    if(length(f_list) ==0 ) { print("file list EMPTY")}

    # initialize the counter
    n <- 1


    #process the file list
    for(f in f_list){
          
      a <- gdal_utils_gdb_load(f,n)
      
      n <- n + 1
          
    }

    dbDisconnect(con)

    ## [1] TRUE

End: 2023-01-16 11:50:26
