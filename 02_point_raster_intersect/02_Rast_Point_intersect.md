## VRI raster intersect with PSPL points

Start: 2022-05-19 12:29:34

    library(sf)

    ## Linking to GEOS 3.9.1, GDAL 3.2.1, PROJ 7.2.1; sf_use_s2() is TRUE

    library(terra)

    ## terra 1.5.21

    library(RPostgreSQL)

    ## Loading required package: DBI

    # set up for load to PostgreSQL
    schema <- 'msyt_2022'
    opt <- paste0("-c search_path=",schema)
    user_name <- 'postgres'
    database <- 'msyt'
    con <- dbConnect('PostgreSQL',dbname=database,user=user_name,options=opt)


    # read Provincial fid tif
    fn1 <- paste0(substr(getwd(),1,1),':/data/data_projects/base_data/vri_2021_fid_gr_skey.tif')
    raster_fid <- rast(fn1)

    # prov land mask
    lm_fn <- paste0(substr(getwd(),1,1),':/data/data_projects/base_data/land_water.tif')
    land_mask <- rast(lm_fn)


    # this is where the unzipped files are placed locally
    local_pspl_folder <- paste0(substr(getwd(),1,1),':/data/data_projects/PSPL_2021/data/gdb')

    # build list of the PSPL gdbs
    # list of gdb files to process
    f_list <- list.files(local_pspl_folder,full.names = TRUE)
    num_gdb = length(f_list)  #number of files to process

## process each gdb

-   Read each GDB
-   extract feature id from the raster using extract
-   join to the point attribute data
-   export to PostgreSQL table: pspl\_raw

<!-- -->

    rast_intersect <- function(r,pf,n){
      
      # r = PROV raster of fid
      # p = PSPL point set
      # n = counter
      
      # read the point file
      p <- vect(pf)
      
      # lower case the names
      names(p) <- c("id_tag","at_si","ba_si","bg_si","bl_si","cw_si","dr_si","ep_si","fd_si","hm_si","hw_si","lt_si","lw_si","pa_si","pl_si","pw_si","py_si","sb_si","se_si","ss_si","sw_si","sx_si","yc_si","bapid","pem_spp","bgc_label","tsa_number")
      
      # number points i pspl
      n_points <- nrow(p)


      # add id to point data
      p$pspl_id <- seq(1:nrow(p))


      #crop raster to point extent + 51

      # define extent from p add 1 m all around
      e <- ext(p)
      e[1] <- e[1] - 51
      e[2] <- e[2] + 51
      e[3] <- e[3] - 51
      e[4] <- e[4] + 51

      # crop the raster using the extent
      rc <- crop(r,e)
      
      
      # extract the raster data at the x,y of the points
      x <- extract(rc,p)

      # drop the geometry by changing to data frame
      p <- as.data.frame(p)


      # join raster data feature_id
      p$feature_id <- x[,"feature_id"]

      # join raster data gr_skey
      p$gr_skey <- x[,"gr_skey"]
      
      # set to 1 decimal place 
      # this matches the output from the Biophysical model
      
      # note that this works for CSV
      # export to PostgreSQL will keep as double
      # unless field.types are specified
      # but this has to be a named vector
      # handle the conversion in SQL
      
      p[, 2:23] <- round(p[, 2:23], digits = 1)

      
      # add a table number to allow tracking
      p$tab_no <- n
      
      # at this point can drop anything with a NULL feature_id
      # or can do this as firest step in SQL
      

      # export to csv, append if exists
      #fn3 <- paste0(substr(getwd(),1,1),':/Data/data_projects/PSPL_2021/data/csv/csv',n,'.csv')
      #data.table::fwrite(p,fn3,sep=',',append=FALSE)
      
      # load to PostgreSQL
      if (n ==1) {
        dbWriteTable(con,'pspl_raw',p,row.names=FALSE,overwrite=TRUE)
      } else {
        dbWriteTable(con,'pspl_raw',p,row.names=FALSE,overwrite=FALSE,append = TRUE)
      }
      
      
      rows_out <- nrow(p)
      
      fo <- data.frame('num_points' = n_points,'rows_out' = rows_out, 'n' = n)
      
      return(fo)

    }

    # creates unit1 .. unitxx depending on the number of GDBs
      # unit1 does NOT refer to tsa 01
      # it is simply a reference number
    if(length(f_list) ==0 ) { print("file list EMPTY")}

    # initialize the counter
    n <- 1

    # create reporting data frame
    report <- data.frame('num_points' = '','rows_out' = '', 'n' = '')

    # single file 
    # f1 <- f_list[1]
    # f2 <- f_list[2]

    #process the file list
        for(fname in f_list){
          
          a <- rast_intersect(raster_fid,fname,n)
          
          report <- rbind(report,a)
          
          n <- n + 1
          
        }

    library(kableExtra)

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
<td style="text-align: left;">1181106</td>
<td style="text-align: left;">1181106</td>
<td style="text-align: left;">1</td>
</tr>
<tr class="odd">
<td style="text-align: left;">1158840</td>
<td style="text-align: left;">1158840</td>
<td style="text-align: left;">2</td>
</tr>
<tr class="even">
<td style="text-align: left;">1397598</td>
<td style="text-align: left;">1397598</td>
<td style="text-align: left;">3</td>
</tr>
<tr class="odd">
<td style="text-align: left;">627848</td>
<td style="text-align: left;">627848</td>
<td style="text-align: left;">4</td>
</tr>
<tr class="even">
<td style="text-align: left;">706549</td>
<td style="text-align: left;">706549</td>
<td style="text-align: left;">5</td>
</tr>
<tr class="odd">
<td style="text-align: left;">235530</td>
<td style="text-align: left;">235530</td>
<td style="text-align: left;">6</td>
</tr>
<tr class="even">
<td style="text-align: left;">11584979</td>
<td style="text-align: left;">11584979</td>
<td style="text-align: left;">7</td>
</tr>
<tr class="odd">
<td style="text-align: left;">1163296</td>
<td style="text-align: left;">1163296</td>
<td style="text-align: left;">8</td>
</tr>
<tr class="even">
<td style="text-align: left;">2886578</td>
<td style="text-align: left;">2886578</td>
<td style="text-align: left;">9</td>
</tr>
<tr class="odd">
<td style="text-align: left;">8137232</td>
<td style="text-align: left;">8137232</td>
<td style="text-align: left;">10</td>
</tr>
<tr class="even">
<td style="text-align: left;">4575950</td>
<td style="text-align: left;">4575950</td>
<td style="text-align: left;">11</td>
</tr>
<tr class="odd">
<td style="text-align: left;">1277207</td>
<td style="text-align: left;">1277207</td>
<td style="text-align: left;">12</td>
</tr>
<tr class="even">
<td style="text-align: left;">897676</td>
<td style="text-align: left;">897676</td>
<td style="text-align: left;">13</td>
</tr>
<tr class="odd">
<td style="text-align: left;">3915758</td>
<td style="text-align: left;">3915758</td>
<td style="text-align: left;">14</td>
</tr>
<tr class="even">
<td style="text-align: left;">974722</td>
<td style="text-align: left;">974722</td>
<td style="text-align: left;">15</td>
</tr>
<tr class="odd">
<td style="text-align: left;">1018812</td>
<td style="text-align: left;">1018812</td>
<td style="text-align: left;">16</td>
</tr>
<tr class="even">
<td style="text-align: left;">960109</td>
<td style="text-align: left;">960109</td>
<td style="text-align: left;">17</td>
</tr>
<tr class="odd">
<td style="text-align: left;">564902</td>
<td style="text-align: left;">564902</td>
<td style="text-align: left;">18</td>
</tr>
<tr class="even">
<td style="text-align: left;">2464966</td>
<td style="text-align: left;">2464966</td>
<td style="text-align: left;">19</td>
</tr>
<tr class="odd">
<td style="text-align: left;">970338</td>
<td style="text-align: left;">970338</td>
<td style="text-align: left;">20</td>
</tr>
<tr class="even">
<td style="text-align: left;">1066597</td>
<td style="text-align: left;">1066597</td>
<td style="text-align: left;">21</td>
</tr>
<tr class="odd">
<td style="text-align: left;">1377731</td>
<td style="text-align: left;">1377731</td>
<td style="text-align: left;">22</td>
</tr>
<tr class="even">
<td style="text-align: left;">836864</td>
<td style="text-align: left;">836864</td>
<td style="text-align: left;">23</td>
</tr>
<tr class="odd">
<td style="text-align: left;">5408180</td>
<td style="text-align: left;">5408180</td>
<td style="text-align: left;">24</td>
</tr>
<tr class="even">
<td style="text-align: left;">1112873</td>
<td style="text-align: left;">1112873</td>
<td style="text-align: left;">25</td>
</tr>
<tr class="odd">
<td style="text-align: left;">1300445</td>
<td style="text-align: left;">1300445</td>
<td style="text-align: left;">26</td>
</tr>
<tr class="even">
<td style="text-align: left;">842986</td>
<td style="text-align: left;">842986</td>
<td style="text-align: left;">27</td>
</tr>
<tr class="odd">
<td style="text-align: left;">1385525</td>
<td style="text-align: left;">1385525</td>
<td style="text-align: left;">28</td>
</tr>
<tr class="even">
<td style="text-align: left;">2281523</td>
<td style="text-align: left;">2281523</td>
<td style="text-align: left;">29</td>
</tr>
<tr class="odd">
<td style="text-align: left;">518560</td>
<td style="text-align: left;">518560</td>
<td style="text-align: left;">30</td>
</tr>
<tr class="even">
<td style="text-align: left;">7507664</td>
<td style="text-align: left;">7507664</td>
<td style="text-align: left;">31</td>
</tr>
<tr class="odd">
<td style="text-align: left;">1964607</td>
<td style="text-align: left;">1964607</td>
<td style="text-align: left;">32</td>
</tr>
<tr class="even">
<td style="text-align: left;">506172</td>
<td style="text-align: left;">506172</td>
<td style="text-align: left;">33</td>
</tr>
<tr class="odd">
<td style="text-align: left;">756254</td>
<td style="text-align: left;">756254</td>
<td style="text-align: left;">34</td>
</tr>
<tr class="even">
<td style="text-align: left;">585414</td>
<td style="text-align: left;">585414</td>
<td style="text-align: left;">35</td>
</tr>
<tr class="odd">
<td style="text-align: left;">849903</td>
<td style="text-align: left;">849903</td>
<td style="text-align: left;">36</td>
</tr>
<tr class="even">
<td style="text-align: left;">4153662</td>
<td style="text-align: left;">4153662</td>
<td style="text-align: left;">37</td>
</tr>
</tbody>
</table>

Table 1. PSPL Summary

End: 2022-05-19 13:35:25
