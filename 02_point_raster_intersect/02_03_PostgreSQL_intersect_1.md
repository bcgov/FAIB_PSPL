## VRI spatial intersect with PSPL points

Assumes veg\_comp\_spatial exists.  
assumes that the PSPL points have been loaded: unit 1.. unit n

Start: 2023-01-16 12:56:02

    year <- '2022'


    library(RPostgreSQL)

    ## Loading required package: DBI

    # set up for load to PostgreSQL
    # schema must include public for geom functions to work.
    schema <- paste0('msyt_',year,',public')
    opt <- paste0("-c search_path=",schema)
    user_name <- 'results'
    database <- 'msyt'

    #con2 <- dbConnect('PostgreSQL',dbname=database,user=user_name,options=opt)


    # this is where the unzipped files are placed locally
    local_pspl_folder <- paste0(substr(getwd(),1,1),':/data/data_projects/AR2022/PSPL/gdb_data')

    # build list of the PSPL gdbs
    # list of gdb files to process
    f_list <- list.files(local_pspl_folder,full.names = TRUE)

    #number of files to process
    num_units = length(f_list)

## process each point table

Note that the intersection is using st\_contains(vri,point).

This may fail in what is expected to be a very small subset it the point
falls exactly on the vri polygon line.

There are examples where the PSPL point is OUTSIDE the VRI boundary.

Arrow, Arrowsmith as examples.

Ignore these and move on.

id\_tag = 01\_082F\_16203\_04799

End: 2023-01-16 14:52:37
