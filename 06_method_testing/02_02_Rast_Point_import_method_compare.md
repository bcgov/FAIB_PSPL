## Import from GDB to PostgreSQL

Start: 2023-01-13 14:47:33

    year <- '2022'

    library(sf)

    ## Linking to GEOS 3.9.1, GDAL 3.2.1, PROJ 7.2.1; sf_use_s2() is TRUE

    library(terra)

    ## terra 1.5.21

    library(RPostgreSQL)

    ## Loading required package: DBI

    # set up for load to PostgreSQL
    schema <- paste0('msyt_',year)
    opt <- paste0("-c search_path=",schema)
    user_name <- 'results'
    database <- 'msyt'
    con <- dbConnect('PostgreSQL',dbname=database,user=user_name,options=opt)


    # this is where the unzipped files are placed locally
    local_gdb_folder <- paste0(substr(getwd(),1,1),':/data/data_projects/AR2022/PSPL/gdb_data_test')

    # build list of the PSPL gdbs
    # list of gdb files to process
    f_list <- list.files(local_gdb_folder,full.names = TRUE)
    num_gdb = length(f_list)  #number of files to process

## process each gdb

-   Read each GDB
-   export to PostgreSQL

## Load via Terra

Fails as spatVect can’t be exported to PostgreSQL

Error in (function (classes, fdef, mtable) :  
unable to find an inherited method for function ‘dbWriteTable’ for
signature ‘“PostgreSQLConnection”, “character”, “SpatVector”’

    terra_gdb_load <- function(pf,n){

    n <- 1
    pf <- f_list[2]

    t_name <- tools::file_path_sans_ext(basename(pf))
      
      # read the point file
      point_set <- vect(pf)
      

      tab_name <- paste0('pspl_terra_unit',n)
      
      dbWriteTable(con,tab_name,point_set,row.names=FALSE,overwrite=TRUE)
      
      
      

    }

## Load using sf::gdal\_utils

This will bring any NULL values in the GDB as actual NULL in PostgreSQL.

    gdal_utils_gdb_load <- function(pf,n){

      #n <- 1
      #fname <- pf
      
      # PostgreSQL connection settings
      # schema is not defined
      dest <- c("PG:dbname='msyt' user='results'")
      
      gdb_fc <- tools::file_path_sans_ext(basename(pf))
      
      # give new layer name the schema name 
      new_layer <- paste0('msyt_',year,'.pspl_gdal_util_unit',n)
      
      sel_query <- paste0('select id_tag,at_si,ba_si,bg_si,bl_si,cw_si,dr_si,ep_si,fd_si,hm_si,hw_si,lt_si,lw_si,pa_si,pl_si,pw_si,py_si,sb_si,se_si,ss_si,sw_si,sx_si,yc_si from ',gdb_fc)
      
      gdal_utils(
        util="vectortranslate",
        source=pf,
        dest,
        options=
          c('-a_srs','EPSG:3005',
            '-gt','10000',
            '-nln',new_layer,
            '-lco', 'SPATIAL_INDEX=NONE',
            '-lco', 'GEOMETRY_NAME=wkb_geometry',
            '-sql', sel_query,
            '-overwrite'
            )
        )
      

    }

## ogr2ogr import to PostgreSQL

-   ogr2ogr -a\_srs EPSG:3005 -lco SPATIAL\_INDEX=NO -gt 200000 –config
    PG\_USE\_COPY YES -nln new\_in -f PostgreSQL PG:dbname=results\_201x
    x.gdb layer

Note: If you get the following message when doing a psql&gt; able  
ERROR: column c.relhasoids does not exist  
Your client is wrong.  
Change to client that matches your PostreSQL version.

    #dest <- c("PG:dbname='msyt' user='results'")

    select <- "id_tag,at_si,ba_si,bg_si,bl_si,cw_si,dr_si,ep_si,fd_si,hm_si,hw_si,lt_si,lw_si,pa_si,pl_si,pw_si,py_si,sb_si,se_si,ss_si,sw_si,sx_si,yc_si"

    ogr_load <- function(pf,n){
      
      
        # pf = GDB full name
      
      # give new layer name the schema name 
      new_layer <- paste0('msyt_',year,'.pspl_ogr2ogr_unit',n)
      gdb_fc <- tools::file_path_sans_ext(basename(pf))  
      
      ogr1 <- paste0("-a_srs EPSG:3005 -gt 100000 -select ",select,' ')
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
      b <- ogr_load(f,n)
      n <- n + 1
          
    }

## Test compare

Union the 2 tables from each method.  
If the row count does not inceras, the tables are exactly the same.

    a1 <- 'pspl_gdal_util_unit1'
    a2 <- 'pspl_gdal_util_unit2'
    b1 <- 'pspl_ogr2ogr_unit1'
    b2 <- 'pspl_ogr2ogr_unit2'

    q1 <- paste0('create table u1 as select * from ',a1,' union select * from ',b1)
    q2 <- paste0('create table u2 as select * from ',a2,' union select * from ',b2)

    dbExecute(con, 'drop table if exists u1')

    ## [1] 0

    dbExecute(con, 'drop table if exists u2')

    ## [1] 0

    dbExecute(con,q1)

    ## [1] 1158840

    dbExecute(con,q2)

    ## [1] 706549

    a1_cnt <- dbGetQuery(con,'select count(*) from pspl_gdal_util_unit1')
    b1_cnt <- dbGetQuery(con,'select count(*) from pspl_ogr2ogr_unit1')
    u1_cnt <- dbGetQuery(con,'select count(*) from u1')

    rep1 <- data.frame('table' = c('pspl_gdal_util_unit1','pspl_ogr2ogr_unit1','union'), 'n' = c(a1_cnt$count,b1_cnt$count,u1_cnt$count))

    dbExecute(con, 'drop table if exists u1')

    ## [1] 0

    dbExecute(con, 'drop table if exists u2')

    ## [1] 0

    knitr::kable(rep1,format="markdown")

<table>
<thead>
<tr class="header">
<th style="text-align: left;">table</th>
<th style="text-align: right;">n</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">pspl_gdal_util_unit1</td>
<td style="text-align: right;">1158840</td>
</tr>
<tr class="even">
<td style="text-align: left;">pspl_ogr2ogr_unit1</td>
<td style="text-align: right;">1158840</td>
</tr>
<tr class="odd">
<td style="text-align: left;">union</td>
<td style="text-align: right;">1158840</td>
</tr>
</tbody>
</table>

    dbDisconnect(con)

    ## [1] TRUE

Table 1. If all the numbers are the same, then the union indicates taht
the tables are exactly the same.

End: 2023-01-13 14:49:49
