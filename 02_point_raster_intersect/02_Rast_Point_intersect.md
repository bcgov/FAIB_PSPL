## VRI raster intersect with PSPL points

Start: 2022-05-12 16:14:20

    library(sf)

    ## Linking to GEOS 3.9.1, GDAL 3.2.1, PROJ 7.2.1; sf_use_s2() is TRUE

    library(terra)

    ## terra 1.5.21

    # read Provincial fid tif
    fn1 <- paste0(substr(getwd(),1,1),':/data/data_projects/base_data/vri_2021_fid_gr_skey.tif')
    raster_fid <- rast(fn1)


    # this is where the unzipped files are placed locally
    local_pspl_folder <- paste0(substr(getwd(),1,1),':/data/data_projects/PSPL_2021/data')

    # build list of the PSPL gdbs
    # list of gdb files to process
    f_list <- list.files(local_pspl_folder,full.names = TRUE,pattern = "\\.gdb$")
    num_gdb = length(f_list)  #number of files to process

    rast_intersect <- function(r,pf,n){
      
      # r = PROV raster of fid
      # p = PSPL point set
      # n = counter
      
      # read the point file
      p <- vect(pf)
      
      n_points <- nrow(p)


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
      p[, 2:23] <- round(p[, 2:23], digits = 1)


      # export to csv, append if exists
      fn3 <- paste0(substr(getwd(),1,1),':/Data/data_projects/PSPL_2021/data/pspl_out',n,'.csv')
      data.table::fwrite(p,fn3,sep=',',append=FALSE)
      
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
     f1 <- f_list[1]

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
<td style="text-align: left;">1158840</td>
<td style="text-align: left;">1158840</td>
<td style="text-align: left;">1</td>
</tr>
<tr class="odd">
<td style="text-align: left;">627848</td>
<td style="text-align: left;">627848</td>
<td style="text-align: left;">2</td>
</tr>
</tbody>
</table>

Table 1. PSPL Summary

End: 2022-05-12 16:16:15
