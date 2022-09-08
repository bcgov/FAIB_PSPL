# PSPL Method 2022

## Feature\_id processing

-   run SI conversion on feature\_id based si
-   run SI conversion on opening\_id based si
-   run SI conversion on BEC based si

Create the following tables:

-   pspl\_site\_index\_bec
-   pspl\_site\_index\_fid
-   pspl\_site\_index\_op

Start: Thu Sep 8 07:52:57 2022

    year <- '2022'

    library(RPostgreSQL)

    ## Loading required package: DBI

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

    library(ggplot2)

    # set up for schema and user
    schema <- 'msyt_2022'
    opt <- paste0("-c search_path=",schema)
    user_name <- 'postgres'
    database <- 'msyt'
    con <- dbConnect('PostgreSQL',dbname='msyt',user=user_name,options=opt)


    #load the R code for site index conversions

    si_convert <- paste0(getwd(),'/site_index_conversion_equations_v2.r')
    source(si_convert, local = knitr::knit_global())

### Feature\_id Site Index Conversions

Run the SI conversion on avg\_fid\_data.

mean value data by feature

    # read avg_fid_data: table = pspl_fid_site_index_pre_convert
    # this is the mean value feature_id data

    q1 <- 'select *  from msyt_2022.pspl_fid_site_index_pre_convert'
    avg_fid_data <- dbGetQuery(con,q1)
     

    setDT(avg_fid_data)

    # note that si_convert required 0 in place of NA
    # si_convert will handle this


    # run the SI conversions
    avg_fid_data <- si_convert(avg_fid_data)


    # write the data
    file_name <- paste0(substr(getwd(),1,1),':/data/data_projects/AR2022/PSPL/si_data/pspl_site_index_fid.csv')
    fwrite(avg_fid_data, file_name, col.names=TRUE, row.names=FALSE, quote = FALSE, sep=",")


    tbl_name <- paste0('pspl_site_index_fid')

    # pre delete table
    if(dbExistsTable(con,tbl_name)) {
      dbRemoveTable(con,tbl_name)
    }

    ## [1] TRUE

    # write to table

    dbWriteTable(con,tbl_name,avg_fid_data,row.names = FALSE)

    ## [1] TRUE

### run SI conversion on the bec means values

-   run SI conversion on BEC based si

<!-- -->

    # read avg_BEC_data: table = psql_bec_site_index_pre_convert
    q1 <- 'select *  from msyt_2022.pspl_bec_site_index_pre_convert'
    r1 <- dbSendQuery(con,q1)
    avg_BEC_data <- dbFetch(r1,n=-1)

    setDT(avg_BEC_data)


    avg_BEC_data <- si_convert(avg_BEC_data)


    # write the data
    file_name <- paste0(substr(getwd(),1,1),':/data/data_projects/AR2022/PSPL/si_data/pspl_site_index_bec.csv')
    fwrite(avg_BEC_data, file_name, col.names=TRUE, row.names=FALSE, quote = FALSE, sep=",")


    tbl_name <- paste0('pspl_site_index_bec')


    # pre delete table
    if(dbExistsTable(con,tbl_name)) {
      dbRemoveTable(con,tbl_name)
    }

    ## [1] TRUE

    # write to table
    dbWriteTable(con,tbl_name,avg_BEC_data,row.names = FALSE)

    ## [1] TRUE

## Conversion on Opening

    # read avg_op_data: table = pspl_op_site_index_pre_convert
    q1 <- 'select *  from msyt_2022.pspl_op_site_index_pre_convert'
    avg_op_data <- dbGetQuery(con,q1)

    setDT(avg_op_data)



    # run the conversion

    avg_op_data <- si_convert(avg_op_data)

    # writeout the post conversion file
    file_name <-  paste0(substr(getwd(),1,1),':/data/data_projects/AR2022/PSPL/si_data/pspl_site_index_op.csv')
    fwrite(avg_op_data, file_name, col.names=TRUE, row.names=FALSE, quote = FALSE, sep=",")


    # add src

    avg_op_data$si_src <- 'PSPL'

    tbl_name <- paste0('pspl_site_index_op')

    # pre delete table
    if(dbExistsTable(con,tbl_name)) {
      dbRemoveTable(con,tbl_name)
    }

    ## [1] TRUE

    dbWriteTable(con,tbl_name,avg_op_data,row.names = FALSE)

    ## [1] TRUE

    if(dbExistsTable(con,'pspl_fid_site_index_pre_convert')) {
      dbRemoveTable(con,'pspl_fid_site_index_pre_convert')
    }

    if(dbExistsTable(con,'pspl_op_site_index_pre_convert')) {
      dbRemoveTable(con,'pspl_op_site_index_pre_convert')
    }

    if(dbExistsTable(con,'pspl_bec_site_index_pre_convert')) {
      dbRemoveTable(con,'pspl_bec_site_index_pre_convert')
    }

    #if(dbExistsTable(con,'pspl_init')) {
    #  dbRemoveTable(con,'pspl_init')
    #}

    #if(dbExistsTable(con,'pspl_raw')) {
    #  dbRemoveTable(con,'pspl_raw')
    #}

    pg_dump <- function(t_name,folder){
      
      # -O required to negate ownership
      
      f_out <- paste0(folder,'msyt_',year,'_',t_name,'.sql')
      tbl <- paste0('msyt_',year,'.',t_name)
      
      q1 <- paste0("-d ",
                   database,
                   " -O",
                    " -t ",
                    tbl,
                   " -f ",
                   f_out )
      
      system2("pg_dump",args=q1,stderr=TRUE,wait=TRUE)
      #print(q1)
    }

    ## character(0)

    ## character(0)

    ## character(0)

    dbDisconnect(con)

    ## [1] TRUE

End: Thu Sep 8 07:55:14 2022
