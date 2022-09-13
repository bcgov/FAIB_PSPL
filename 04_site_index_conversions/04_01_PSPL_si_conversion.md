# PSPL Method 2022

## Feature\_id processing

-   run SI conversion on feature\_id based si
-   run SI conversion on opening\_id based si
-   run SI conversion on BEC based si

Create the following tables:

-   pspl\_site\_index\_bec
-   pspl\_site\_index\_fid
-   pspl\_site\_index\_op

Start: Tue Sep 13 15:24:43 2022

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
    user_name <- 'results'
    database <- 'msyt'
    con <- dbConnect('PostgreSQL',dbname='msyt',user=user_name,options=opt)


    #load the R code for site index conversions

    si_convert <- paste0(getwd(),'/site_index_conversion_equations_v2.r')
    source(si_convert, local = knitr::knit_global())

### run SI conversion on the bec means values

-   run SI conversion on BEC based si

This has to be run first as any missing values in fid or opening use
this table

    # read avg_BEC_data: table = psql_bec_site_index_pre_convert
    q1 <- paste0('select *  from msyt_',year,'.pspl_site_index_pre_convert_bec')
    r1 <- dbSendQuery(con,q1)
    avg_BEC_data <- dbFetch(r1,n=-1)

    setDT(avg_BEC_data)


    avg_BEC_data <- si_convert(avg_BEC_data)

## BEC substitution

mmp is missing all site index values.  
Assume that this is actually mm (since it is one of) and may be next to
mm.

SWB mk, mks, un substitute BWBS dk

    ## Substitute for MHmmp
    mm <- avg_BEC_data %>% subset(bec_zone == 'MH' & bec_subzone == 'mm')
    mm$bec_subzone <- 'mmp'

    avg_BEC_data <- rbind(avg_BEC_data,mm)


    ## substitute for SWB mk,mks,un

    # delete the older data
    # all SWB data is blank
    avg_BEC_data <- avg_BEC_data %>% subset(bec_zone != 'SWB')

    swb1 <- avg_BEC_data %>% subset(bec_zone == 'BWBS' & bec_subzone == 'dk')
    swb1$bec_zone <- 'SWB'
    swb1$bec_subzone <- 'mk'

    swb2 <- swb1
    swb3 <- swb1

    swb2$bec_zone <- 'SWB'
    swb2$bec_subzone <- 'mks'

    swb3$bec_zone <- 'SWB'
    swb3$bec_subzone <- 'un'

    avg_BEC_data <- rbind(avg_BEC_data,swb1,swb2,swb3)






    # write the data
    file_name <- paste0(substr(getwd(),1,1),':/data/data_projects/AR',year,'/PSPL/si_data/pspl_site_index_bec.csv')
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

### Feature\_id Site Index Conversions

Run the SI conversion on avg\_fid\_data.

mean value data by feature

    # read avg_fid_data: table = pspl_site_index_pre_convert_fid
    # this is the mean value feature_id data

    q1 <- paste0('select *  from msyt_',year,'.pspl_site_index_pre_convert_fid')
    avg_fid_data <- dbGetQuery(con,q1)
     

    setDT(avg_fid_data)

    # note that si_convert required 0 in place of NA
    # si_convert will handle this


    # run the SI conversions
    avg_fid_data <- si_convert(avg_fid_data)

## update converted using BEC converted

-   update feature\_id si using BEc avg

<!-- -->

    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), at_si := ifelse(at_si==0, i.at_si,at_si)]
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), ba_si := ifelse(ba_si==0, i.ba_si,ba_si)]
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), bg_si := ifelse(bg_si==0, i.bg_si,bg_si)]
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), bl_si := ifelse(bl_si==0, i.bl_si,bl_si)]
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), cw_si := ifelse(cw_si==0, i.cw_si,cw_si)]
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), dr_si := ifelse(dr_si==0, i.dr_si,dr_si)]
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), ep_si := ifelse(ep_si==0, i.ep_si,ep_si)]
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), fd_si := ifelse(fd_si==0, i.fd_si,fd_si)]
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), hm_si := ifelse(hm_si==0, i.hm_si,hm_si)]
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), hw_si := ifelse(hw_si==0, i.hw_si,hw_si)]
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), lt_si := ifelse(lt_si==0, i.lt_si,lt_si)]  
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), lw_si := ifelse(lw_si==0, i.lw_si,lw_si)]
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), pa_si := ifelse(pa_si==0, i.pa_si,pa_si)]
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), pl_si := ifelse(pl_si==0, i.pl_si,pl_si)]
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), pw_si := ifelse(pw_si==0, i.pw_si,pw_si)]
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), py_si := ifelse(py_si==0, i.py_si,py_si)]
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), sb_si := ifelse(sb_si==0, i.sb_si,sb_si)]
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), se_si := ifelse(se_si==0, i.se_si,se_si)]
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), ss_si := ifelse(ss_si==0, i.ss_si,ss_si)]
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), sw_si := ifelse(sw_si==0, i.sw_si,sw_si)]
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), sx_si := ifelse(sx_si==0, i.sx_si,sx_si)]
    avg_fid_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), yc_si := ifelse(yc_si==0, i.yc_si,yc_si)]



    # add src

    avg_fid_data$si_src <- 'PSPL'

    # write the data
    file_name <- paste0(substr(getwd(),1,1),':/data/data_projects/AR',year,'/PSPL/si_data/pspl_site_index_fid.csv')
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

## Conversion on Opening

    # read avg_op_data: table = pspl_site_index_pre_convert_op
    q1 <- 'select *  from msyt_2022.pspl_site_index_pre_convert_op'
    avg_op_data <- dbGetQuery(con,q1)

    setDT(avg_op_data)



    # run the conversion

    avg_op_data <- si_convert(avg_op_data)

## update converted using BEC converted

-   update opening\_id\_id si using BEc avg

<!-- -->

    # update from BEC

    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), at_si := ifelse(at_si==0, i.at_si,at_si)]
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), ba_si := ifelse(ba_si==0, i.ba_si,ba_si)]
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), bg_si := ifelse(bg_si==0, i.bg_si,bg_si)]
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), bl_si := ifelse(bl_si==0, i.bl_si,bl_si)]
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), cw_si := ifelse(cw_si==0, i.cw_si,cw_si)]
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), dr_si := ifelse(dr_si==0, i.dr_si,dr_si)]
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), ep_si := ifelse(ep_si==0, i.ep_si,ep_si)]
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), fd_si := ifelse(fd_si==0, i.fd_si,fd_si)]
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), hm_si := ifelse(hm_si==0, i.hm_si,hm_si)]
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), hw_si := ifelse(hw_si==0, i.hw_si,hw_si)]
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), lt_si := ifelse(lt_si==0, i.lt_si,lt_si)]  
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), lw_si := ifelse(lw_si==0, i.lw_si,lw_si)]
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), pa_si := ifelse(pa_si==0, i.pa_si,pa_si)]
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), pl_si := ifelse(pl_si==0, i.pl_si,pl_si)]
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), pw_si := ifelse(pw_si==0, i.pw_si,pw_si)]
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), py_si := ifelse(py_si==0, i.py_si,py_si)]
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), sb_si := ifelse(sb_si==0, i.sb_si,sb_si)]
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), se_si := ifelse(se_si==0, i.se_si,se_si)]
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), ss_si := ifelse(ss_si==0, i.ss_si,ss_si)]
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), sw_si := ifelse(sw_si==0, i.sw_si,sw_si)]
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), sx_si := ifelse(sx_si==0, i.sx_si,sx_si)]
    avg_op_data[avg_BEC_data, on=c("bec_zone","bec_subzone"), yc_si := ifelse(yc_si==0, i.yc_si,yc_si)]


    # add src

    avg_op_data$si_src <- 'PSPL'

    # writeout the post conversion file
    file_name <-  paste0(substr(getwd(),1,1),':/data/data_projects/AR',year,'/PSPL/si_data/pspl_site_index_op.csv')
    fwrite(avg_op_data, file_name, col.names=TRUE, row.names=FALSE, quote = FALSE, sep=",")




    tbl_name <- paste0('pspl_site_index_op')

    # pre delete table
    if(dbExistsTable(con,tbl_name)) {
      dbRemoveTable(con,tbl_name)
    }

    ## [1] TRUE

    dbWriteTable(con,tbl_name,avg_op_data,row.names = FALSE)

    ## [1] TRUE

    if(dbExistsTable(con,'pspl_site_index_pre_convert_fid')) {
      dbRemoveTable(con,'pspl_site_index_pre_convert_fid')
    }

    if(dbExistsTable(con,'pspl_site_index_pre_convert_op')) {
      dbRemoveTable(con,'pspl_site_index_pre_convert_op')
    }

    if(dbExistsTable(con,'pspl_site_index_pre_convert_bec')) {
      dbRemoveTable(con,'pspl_site_index_pre_convert_bec')
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

End: Tue Sep 13 15:27:19 2022
