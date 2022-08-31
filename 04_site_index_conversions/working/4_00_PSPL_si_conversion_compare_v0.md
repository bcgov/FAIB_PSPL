# PSPL Method 2022

## Feature\_id processing

-   run SI conversion on feature\_id based si
-   run SI conversion on opening\_id based si
-   run SI conversion on BEC based si

Create the following tables:

-   pspl\_bec\_site\_index
-   pspl\_fid\_site\_index
-   pspl\_op\_site\_index

## compare methods

-   original Code translation using if then else cascade
-   revised to case\_when

Start: Fri May 20 14:18:55 2022

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
    si_convert0 <- paste0(getwd(),'/site_index_conversion_equations_v0.r')
    source(si_convert0, local = knitr::knit_global())

    ver <- 'v0'
    #ver <- 'v1'

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
    file_name <- paste0(substr(getwd(),1,1),':/data/data_projects/PSPL_2022/pspl_fid_site_index_post_convert_',ver,'.csv')
    fwrite(avg_fid_data, file_name, col.names=TRUE, row.names=FALSE, quote = FALSE, sep=",")


    tbl_name <- paste0('pspl_fid_site_index_post_convert_',ver)

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
    file_name <- paste0(substr(getwd(),1,1),':/data/data_projects/PSPL_2021/pspl_bec_site_index_post_convert_',ver,'.csv')
    fwrite(avg_BEC_data, file_name, col.names=TRUE, row.names=FALSE, quote = FALSE, sep=",")


    tbl_name <- paste0('pspl_bec_site_index_post_convert_',ver)


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
    file_name <-  paste0(substr(getwd(),1,1),':/data/data_projects/PSPL_2021/pspl_op_site_index_post_convert_',ver,'.csv')
    fwrite(avg_op_data, file_name, col.names=TRUE, row.names=FALSE, quote = FALSE, sep=",")


    # add src

    avg_op_data$si_src <- 'PSPL'

    tbl_name <- paste0('pspl_op_site_index_post_convert_',ver)

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

    dbDisconnect(con)

    ## [1] TRUE

End: Fri May 20 14:21:46 2022
