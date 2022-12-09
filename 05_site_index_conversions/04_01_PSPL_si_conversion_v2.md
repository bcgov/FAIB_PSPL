# PSPL Method 2022

## Version testing

Using version 3

revised BA/BG  
revised SS

## Feature\_id processing

-   run SI conversion on feature\_id based si
-   run SI conversion on opening\_id based si
-   run SI conversion on BEC based si

Create the following tables:

-   pspl\_site\_index\_bec
-   pspl\_site\_index\_fid
-   pspl\_site\_index\_op

Requires the following tables:

-   pspl\_site\_index\_pre\_convert\_bec
-   pspl\_site\_index\_pre\_convert\_fid
-   pspl\_site\_index\_pre\_convert\_op

Start: Thu Oct 6 16:26:28 2022

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

    #  Versions to test
    #si_convert <- paste0(getwd(),'/site_index_conversion_equations_v2a.r')
    #si_convert <- paste0(getwd(),'/site_index_conversion_equations_v2b.r')
    #si_convert <- paste0(getwd(),'/site_index_conversion_equations_v2c.r')
    si_convert <- paste0(getwd(),'/site_index_conversion_equations_v3.r')

    source(si_convert, local = knitr::knit_global())

    # function to derive where species do no have a site index
    assign_missing <- function(d){
      
      
      setDF(d)
      
      # set NA to 0 
      d[is.na(d)] <- 0
      
      # convert 3 char species to 2 char
      # Cwc,Fdc,Hwc
      d$species <- gsub('Cwc','Cw',d$species)
      d$species <- gsub('Cwi','Cw',d$species)
      d$species <- gsub('Fdc','Fd',d$species)
      d$species <- gsub('Fdi','Fd',d$species)
      d$species <- gsub('Hwc','Hw',d$species)
      d$species <- gsub('Hwi','Hw',d$species)
      
      d$missing <- ''
      
      d$missing <- case_when(
        grepl('At',d$species) & d$at_si == 0 ~ 'At',
        TRUE ~ ''
      )
      
      sp <- c('Ba','Bg','Bl','Cw','Dr','Ep','Fd','Hm','Hw','Lt','Lw','Pa','Pl','Pw','Py','Sb','Se','Ss','Sw','Yc')
      
      # use the at_si column as reference
      n <- which(colnames(d)=='at_si')
      #n <- 3
      for (s in sp) {
        
        n <- n + 1
        d$missing <- case_when(
          grepl(s,d$species) & d[,n] == 0 ~ paste0(d$missing,':',s),
          TRUE ~ paste0(d$missing,'')
        )
        
      }
      
      return(d)
      
    }

    call_si_conversion <- function(inp) {
      
        # cast to table
      dt <- setDT(inp)

        
        #### Spruce
        # ********************************************************************
        # Spruce   Se Sw Sx all interchange
        # set sw = sx
        dt$sw_si[which(dt$sw_si==0)] <- convert_sw_from_sx(dt[which(dt$sw_si==0)]) 
        
        # set sw = se 
        dt$sw_si[which(dt$sw_si==0)] <- convert_sw_from_se(dt[which(dt$sw_si==0)]) 
        
        # set se = sw
        dt$se_si[which(dt$se_si==0)] <- convert_se_from_sw(dt[which(dt$se_si==0)])
        
        # set ss = sx
        dt$ss_si[which(dt$ss_si==0)] <- convert_ss_from_sx(dt[which(dt$ss_si==0)]) 
        
        #### Spruce
        # **************************************************************************
        
        
        # sp <- At 'Ba','Bg','Bl','Cw','Dr','Ep','Fd','Hm','Hw','Lt','Lw','Pa','Pl','Pw','Py','Sb','Se','Ss','Sw','Yc')
        
        # At  
        dt$at_si[which(dt$at_si==0 & grepl('At',dt$missing))] <- convert_at_si(dt[which(dt$at_si==0 & grepl('At',dt$missing))])
        
        # Ba 
        dt$ba_si[which(dt$ba_si==0 & grepl('Ba',dt$missing))] <- convert_ba_si(dt[which(dt$ba_si==0 & grepl('Ba',dt$missing))])
        
        
        # Bl
        dt$bl_si[which(dt$bl_si==0 & grepl('Bl',dt$missing))] <- convert_bl_si(dt[which(dt$bl_si==0 & grepl('Bl',dt$missing))])
        
        # Cwc
        dt$cw_si[which(dt$cw_si==0 & grepl('Cw',dt$missing))] <- convert_cw_si(dt[which(dt$cw_si==0 & grepl('Cw',dt$missing))])
        
        # Fdc
        dt$fd_si[which(dt$fd_si==0 & grepl('Fd',dt$missing) & dt$bec_zone %in% c('CDF','CWH','MH') )] <- convert_fdc_si(dt[which(dt$fd_si==0 & grepl('Fd',dt$missing) & dt$bec_zone %in% c('CDF','CWH','MH') )])
        
        # Fdi
        dt$fd_si[which(dt$fd_si==0 & grepl('Fd',dt$missing) & !dt$bec_zone %in% c('CDF','CWH','MH') )] <- convert_fdi_si(dt[which(dt$fd_si==0 & grepl('Fd',dt$missing) & !dt$bec_zone %in% c('CDF','CWH','MH') )])
        
        # hw coast
        dt$hw_si[which(dt$hw_si==0 & grepl('Hw',dt$missing) & dt$bec_zone %in% c('CDF','CWH','MH') )] <- convert_hwc_si(dt[which(dt$hw_si==0 & grepl('Hw',dt$missing) & dt$bec_zone %in% c('CDF','CWH','MH') )])
        
        # hw interior
        dt$hw_si[which(dt$hw_si==0 & grepl('Hw',dt$missing) & !dt$bec_zone %in% c('CDF','CWH','MH') )] <- convert_hwi_si(dt[which(dt$hw_si==0 & grepl('Hw',dt$missing) & !dt$bec_zone %in% c('CDF','CWH','MH') )])
        
        
        # Lw
        dt$lw_si[which(dt$lw_si==0)] <- convert_lw_si(dt[which(dt$lw_si==0)])
        
        # Pl
        dt$pl_si[which(dt$pl_si==0)] <- convert_pl_si(dt[which(dt$pl_si==0)])
        
        # Sb
        dt$sb_si[which(dt$sb_si==0)] <- convert_sb_si(dt[which(dt$sb_si==0)])
        
        # Ss (coastal)
        dt$ss_si[which(dt$ss_si==0)] <- convert_ss_si(dt[which(dt$ss_si==0)])
        
        # Sw
        dt$sw_si[which(dt$sw_si==0)] <- convert_sw_si(dt[which(dt$sw_si==0)])
        
        # Pw
        dt$pw_si[which(dt$pw_si==0 & grepl('Pw',dt$missing))] <- convert_pw(dt[which(dt$pw_si==0 & grepl('Pw',dt$missing))])
        
        # Pa
        dt$pa_si[which(dt$pa_si==0 & grepl('Pa',dt$missing))] <- convert_pa(dt[which(dt$pa_si==0 & grepl('Pa',dt$missing))])
        
        # Py
        dt$py_si[which(dt$py_si==0 & grepl('Py',dt$missing))] <- convert_py(dt[which(dt$py_si==0 & grepl('Py',dt$missing))]) 
        
        
        # Dr Coast/Interior
        dt$dr_si[which(dt$dr_si==0 & grepl('Dr',dt$missing))] <- convert_dr(dt[which(dt$dr_si==0 & grepl('Dr',dt$missing))])  
        
        # 1-1
        
        # Bg 1-1
        dt$bg_si[which(dt$bg_si==0 & grepl('Bg',dt$missing))] <- convert_bg(dt[which(dt$bg_si==0 & grepl('Bg',dt$missing))])
        dt$bl_si[which(dt$bl_si==0 & grepl('Bl',dt$missing))] <- convert_bl(dt[which(dt$bl_si==0 & grepl('Bl',dt$missing))])
        dt$ba_si[which(dt$ba_si==0 & grepl('Ba',dt$missing))] <- convert_ba(dt[which(dt$ba_si==0 & grepl('Ba',dt$missing))])
        
        # Lw Lt 
        dt$lt_si[which(dt$lt_si==0 & grepl('Lt',dt$missing))] <- convert_lt_from_lw(dt[which(dt$lt_si==0 & grepl('Lt',dt$missing))])
        
        # ********************************************************************
        # Spruce   Se Sw Sx all interchange
        # set sw = sx
        
        dt$sw_si[which(dt$sw_si==0)] <- convert_sw_from_sx(dt[which(dt$sw_si==0)]) 
        
        # set sw = se 
        dt$sw_si[which(dt$sw_si==0)] <- convert_sw_from_se(dt[which(dt$sw_si==0)]) 
        
        # set se = sw
        dt$se_si[which(dt$se_si==0)] <- convert_se_from_sw(dt[which(dt$se_si==0)])
        
        # set ss = sx
        dt$ss_si[which(dt$ss_si==0)] <- convert_ss_from_sx(dt[which(dt$ss_si==0)]) 
        
        # can not do this because opening id can be negative
      #dt[dt <0 ] <- 0.0
      
      dt$at_si[dt$at_si < 0 ] <- 0.0
      dt$ba_si[dt$ba_si < 0 ] <- 0.0
      dt$bg_si[dt$bg_si < 0 ] <- 0.0
      dt$bl_si[dt$bl_si < 0 ] <- 0.0
      dt$cw_si[dt$cw_si < 0 ] <- 0.0
      dt$dr_si[dt$dr_si < 0 ] <- 0.0
      dt$ep_si[dt$ep_si < 0 ] <- 0.0
      dt$fd_si[dt$fd_si < 0 ] <- 0.0
      dt$hm_si[dt$hm_si < 0 ] <- 0.0
      dt$hw_si[dt$hw_si < 0 ] <- 0.0
      dt$lt_si[dt$lt_si < 0 ] <- 0.0
      dt$lw_si[dt$lw_si < 0 ] <- 0.0
      dt$pa_si[dt$pa_si < 0 ] <- 0.0
      dt$pl_si[dt$pl_si < 0 ] <- 0.0
      dt$pw_si[dt$pw_si < 0 ] <- 0.0
      dt$py_si[dt$py_si < 0 ] <- 0.0
      dt$sb_si[dt$sb_si < 0 ] <- 0.0
      dt$se_si[dt$se_si < 0 ] <- 0.0
      dt$ss_si[dt$ss_si < 0 ] <- 0.0
      dt$sw_si[dt$sw_si < 0 ] <- 0.0
      dt$sx_si[dt$sx_si < 0 ] <- 0.0
      dt$yc_si[dt$yc_si < 0 ] <- 0.0
      

      
      #convert to numeric 1
      dt <- dt %>% mutate_if(is.numeric, round, digits=1)
        
        return(dt)
    }

### run SI conversion on the bec means values

-   run SI conversion on BEC based si

This has to be run first as any missing values in fid or opening use
this table

    # read avg_BEC_data: table = psql_bec_site_index_pre_convert
    q1 <- paste0('select *  from msyt_',year,'.pspl_site_index_pre_convert_bec')
    avg_BEC_data <- dbGetQuery(con,q1)

    # get species that are assigned from RESULTS
    # can be a combination of Planted and Natural
    species <- dbGetQuery(con,"select bec_zone,bec_subzone,array_to_string(species,',') as species from species_list_bec_agg")

    # join species to BEC
    avg_BEC_data <- left_join(avg_BEC_data,species)

    ## Joining, by = c("bec_zone", "bec_subzone")

    avg_BEC_data <- avg_BEC_data %>% subset(!is.na(species))

## BEC substitution

mmp is missing all site index values.  
Assume that this is actually mm (since it is one of) and may be next to
mm.

SWB mk, mks, un substitute BWBS dk

    ## Substitute for MHmmp
    mmp <- avg_BEC_data %>% subset(bec_zone == 'MH' & bec_subzone == 'mmp')
    avg_BEC_data <- avg_BEC_data %>% subset(paste0(bec_zone,bec_subzone) != 'MHmmp' )
    mm <- avg_BEC_data %>% subset(bec_zone == 'MH' & bec_subzone == 'mm')
    mm$bec_subzone <- 'mmp'
    mm$species <- mmp$species

    avg_BEC_data <- rbind(avg_BEC_data,mm)


    ## substitute for SWB mk,mks,un
    avg_BEC_data <- avg_BEC_data %>% subset(bec_zone != 'SWB')
    swb1 <- avg_BEC_data %>% subset(bec_zone == 'BWBS' & bec_subzone == 'dk')

    swb1$bec_zone <- 'SWB'
    swb1$bec_subzone <- 'mk'

    swb2 <- swb1
    swb3 <- swb1
    swb4 <- swb1

    swb2$bec_zone <- 'SWB'
    swb2$bec_subzone <- 'mks'

    swb3$bec_zone <- 'SWB'
    swb3$bec_subzone <- 'un'

    swb4$bec_zone <- 'SWB'
    swb4$bec_subzone <- 'vk'

    avg_BEC_data <- rbind(avg_BEC_data,swb1,swb2,swb3,swb4)

    df_base <- avg_BEC_data #%>% subset(bec_zone == 'ESSF')

    #df <- avg_BEC_data

    df_base$id <- 1:nrow(df_base)

    df_base <- assign_missing(df_base)

    # split into those with missing and thos without
    df <- df_base %>% subset(missing != '') 
    df_base <- df_base %>% subset(!id %in% df$id)

    df <- call_si_conversion(df)

    ### cross check

    df <- assign_missing(df)
    x1 <- df %>% subset(missing != '')

    # Force balsam BA Bg swap
    # Lw Lt swap

    df$missing <- ':Ba:Bg:Bl:Lt'
    df <- call_si_conversion(df)

    # back together
    avg_BEC_data <- rbind(df_base,df)
    avg_BEC_data$missing <- ':Ba:Bg:Bl:Lt'
    avg_BEC_data <- call_si_conversion(avg_BEC_data)
    avg_BEC_data$missing <- ''

    x <- assign_missing(avg_BEC_data)
    x <- x %>% subset(missing != '')
    # write the data
    #file_name <- paste0(substr(getwd(),1,1),':/data/data_projects/AR',year,'/PSPL/si_data/pspl_site_index_bec.csv')
    #fwrite(avg_BEC_data, file_name, col.names=TRUE, row.names=FALSE, quote = FALSE, sep=",")


    #tbl_name <- paste0('pspl_site_index_bec')


    # pre delete table
    #if(dbExistsTable(con,tbl_name)) {
    #  dbRemoveTable(con,tbl_name)
    #}


    # write to table
    #dbWriteTable(con,tbl_name,avg_BEC_data,row.names = FALSE)

### Feature\_id Site Index Conversions

Run the SI conversion on avg\_fid\_data.

mean value data by feature

    # read avg_fid_data: table = pspl_site_index_pre_convert_fid
    # this is the mean value feature_id data

    q1 <- paste0('select *  from msyt_',year,'.pspl_site_index_pre_convert_fid')
    avg_fid_data <- dbGetQuery(con,q1)



    species <- dbGetQuery(con,"select feature_id,array_to_string(species,',') as species from species_list_current_fid")

    avg_fid_data <- left_join(avg_fid_data,species,by='feature_id')
    avg_fid_data <- avg_fid_data %>% subset(!is.na(species))


    avg_fid_data <- assign_missing(avg_fid_data)
    avg_fid_data <- avg_fid_data %>% subset(missing != '')  # %>% subset(bec_zone != 'IMA')

    avg_fid_data <- call_si_conversion(avg_fid_data)

    avg_fid_data <- assign_missing(avg_fid_data)
    avg_fid_data <- avg_fid_data %>% subset(missing != '') 

    # do bec updates
    # blunt fill
    setDT(avg_fid_data)
    setDT(avg_BEC_data)

      
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




    avg_fid_data <- assign_missing(avg_fid_data) 
    avg_fid_data <- avg_fid_data %>% subset(missing != '')


    a <- count(avg_fid_data,missing)
    b <- count(avg_fid_data,bec_zone)

    a

    ##      missing  n
    ## 1     :Ba:Se  2
    ## 2        :Bl  8
    ## 3  :Bl:Fd:Pl  1
    ## 4     :Bl:Pl  6
    ## 5     :Bl:Se  1
    ## 6        :Cw  5
    ## 7        :Dr 17
    ## 8        :Hw  3
    ## 9        :Pl  4
    ## 10    :Pl:Sw 11
    ## 11       :Pw  1
    ## 12       :Ss 12
    ## 13        At 45
    ## 14  At:Pl:Sw  7

    b

    ##   bec_zone  n
    ## 1     BAFA 36
    ## 2      CWH 41
    ## 3     ESSF 15
    ## 4      ICH 11
    ## 5      IDF  5
    ## 6      IMA  6
    ## 7       MH  6
    ## 8     SBPS  2
    ## 9      SBS  1

    # add src

    avg_fid_data$si_src <- 'PSPL'

    # write the data
    file_name <- paste0(substr(getwd(),1,1),':/data/data_projects/AR',year,'/PSPL/si_data/pspl_site_index_fid.csv')
    #fwrite(avg_fid_data, file_name, col.names=TRUE, row.names=FALSE, quote = FALSE, sep=",")


    tbl_name <- paste0('pspl_site_index_fid')

    # pre delete table
    if(dbExistsTable(con,tbl_name)) {
      dbRemoveTable(con,tbl_name)
    }

    # write to table

    dbWriteTable(con,tbl_name,avg_fid_data,row.names = FALSE)

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

    dbDisconnect(con)

    ## [1] TRUE

End: Thu Oct 6 16:27:17 2022
