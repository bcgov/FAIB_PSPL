## Load compressed PSPL gdb files to processing location

## directory locations are fixed as follows:

PSPL GDB Files :/Data/Data\_projects/AR2022/PSPL/gdb\_data

And is copied from:

\tension.dmz!publish\_Site\_Productivity\_Layer\_Prod\_with\_Approved\_PEM\_TEM\_Prod\_Point\_FGDBs

Load Date: 2022-09-06 Start: Tue Sep 6 08:56:13 2022

Copy PSPL data from FTP site

    ##  [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
    ## [16] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
    ## [31] TRUE TRUE TRUE TRUE TRUE TRUE TRUE

Unzip the Gdb files

    # get a list of the zip file names
    zipF <- list.files(local_pspl_folder,full.names = TRUE)

    # unzip
    a <- lapply(zipF,FUN=unzip,exdir = local_pspl_folder)

    # delete the zip files
    b <- lapply(zipF,FUN=file.remove)

End of GDB Load

End: Tue Sep 6 08:58:45 2022
