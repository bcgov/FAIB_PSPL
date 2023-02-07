## Import from GDB to PostgreSQL

Compare 2 methods

-   gdal\_utils.vectortranslate
-   use GDAL OGR2OGR (installed)

Start: 2023-02-07 07:47:28

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

## process each gdb

-   Read each GDB
-   export to PostgreSQL

## Load using sf::gdal\_utils.gdaltranslate

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

# alternative load OGR2OGR

ogr2ogr -f “PostgreSQL” PG:“dbname=msyt”
Site\_Prod\_100\_Mile\_House.gdb Site\_Prod\_100\_Mile\_House –debug ON

-   ogr2ogr -a\_srs EPSG:3005 -nln test1 -gt 200000 –config
    PG\_USE\_COPY YES -lco GEOMETRY\_NAME=wkb\_geometry -f PostgreSQL
    PG:“dbname=msyt user=results” Site\_Prod\_100\_Mile\_House.gdb
    Site\_Prod\_100\_Mile\_House

Note: If you get the following message when doing a psql&gt; able  
ERROR: column c.relhasoids does not exist  
Your client is wrong.  
Change to client that matches your PostreSQL version.

    ogr_load <- function(pf,n){
      
      
      # pf = GDB full name
      
      # give new layer name the schema name 
      new_layer <- paste0('msyt_',year,'.pspl_ogr2ogr_unit',n)
      gdb_fc <- tools::file_path_sans_ext(basename(pf))  
      
      ogr1 <- paste0("-a_srs EPSG:3005 -gt 100000 ")
      ogr2 <- paste0("-f PostgreSQL \"PG:dbname='msyt' user='results'\" -nln  ")
      ogr_cmd <- paste0(ogr1,ogr2,new_layer,' ',pf,' ',gdb_fc,' -lco ', 'GEOMETRY_NAME=wkb_geometry',' -overwrite')

      system2("ogr2ogr",args=ogr_cmd,wait=TRUE,stderr=TRUE)
      
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
      #b <- ogr_load(f,n)
      
      n <- n + 1
          
    }

    dbDisconnect(con)

    ## [1] TRUE

End: 2023-02-07 08:18:17
