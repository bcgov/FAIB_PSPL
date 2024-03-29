    library(kableExtra)


    # raster files
    tif_method1 <- 'D:/data/data_projects/VRI_Rasterization/method1.tif'
    tif_method2 <- 'D:/data/data_projects/VRI_Rasterization/method2.tif'
    tif_method3 <- 'D:/data/data_projects/VRI_Rasterization/method3.tif'
    tif_method4 <- 'D:/data/data_projects/VRI_Rasterization/method4.tif'
    tif_method5 <- 'D:/data/data_projects/VRI_Rasterization/fasterize2.tif'
    vri_official <- 'D:/data/data_projects/AR2022/base/veg_comp_lyr_r1_poly_internal_2021.tif'



    # read each raster set and compare

    # if the diff is not zero, set it to 1
    # this will show where pixel values are different


    r1 <- terra::rast(tif_method1)

    # compare 1 to 2

    r2 <- terra::rast(tif_method2)

    c1 <- r1 - r2
    c1[c1 != 0] <- 1

    f1 <- as.data.frame(terra::freq(c1))
    f1 <- f1[,2:3]


    kable(f1)

<table>
<thead>
<tr>
<th style="text-align:right;">
value
</th>
<th style="text-align:right;">
count
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
99528787
</td>
</tr>
<tr>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
31
</td>
</tr>
</tbody>
</table>

    #kable(f1,format="html",caption = 'sf::gdal_utils.rasterize GDB to PostgreSQL') %>%
    #kable_styling(bootstrap_options = c("striped"),full_width=F,font_size=13,position = 'left')

Table 1. Compare sf::gdal\_utils.rasterize GDB to PostgreSQL

This table shows there are 31 features that are different.

Both methods use sf::gdal\_utils.rasterize.  
Except one points at a GDB as source.  
The other points at PostgreSQL as source.

    # compare 1 to 3
    r3 <- terra::rast(tif_method3)


    c1 <- r1 - r3
    c1[c1 != 0] <- 1

    # differences
    # 0 = no difference
    # 1 = difference of 1
    # 2 = difference greater than 1

    f2 <- as.data.frame(terra::freq(c1))
    f2 <- f2[,2:3]


    kable(f2)

<table>
<thead>
<tr>
<th style="text-align:right;">
value
</th>
<th style="text-align:right;">
count
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
99528818
</td>
</tr>
</tbody>
</table>

    #kable(f2,format="html",caption = 'sf::gdal_utils.rasterize GDB to gdal_rasterize.exe') %>%
    #kable_styling(bootstrap_options = c("striped"),full_width=F,font_size=13,position = 'left')

Table 2. Compare sf::gdal\_utils.rasterize (GDB) to gdal\_rasterize.exe
GDB

This table shows that the 2 TIFs are identical.

    # compare 2 to 4
    r4 <- terra::rast(tif_method4)

    c1 <- r2 - r4
    c1[c1 != 0] <- 1

    f3 <- as.data.frame(terra::freq(c1))
    f3 <- f3[,2:3]

    kable(f3)

<table>
<thead>
<tr>
<th style="text-align:right;">
value
</th>
<th style="text-align:right;">
count
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
99528818
</td>
</tr>
</tbody>
</table>

    #kable(f3,format="html",caption = 'sf::gdal_utils.rasterize PostgreSQL to gdal_rasterize.exe') %>%
    #kable_styling(bootstrap_options = c("striped"),full_width=F,font_size=13,position = 'left')

Table 3. Compare sf::gdal\_utils.rasterize (PostgreSQL) to
gdal\_rasterize.exe PostgreSQL

This table shows that the 2 TIFs are identical.

    # compare 1 to 5
    r5 <- terra::rast(tif_method5)

    # force projection
    terra::crs(r5) <- 'epsg:3005'


    # use absolutes
    c1 <- abs(r1 - r5)

    # where the difference is 1 assign 2
    c1[c1 != 0] <- 1



    f4 <- as.data.frame(terra::freq(c1))
    f4 <- f4[,2:3]

    kable(f4)
    #kable(f4,format="html",caption = 'sf::gdal_utils.rasterize GDB to fasterize') %>%
    #kable_styling(bootstrap_options = c("striped"),full_width=F,font_size=13,position = 'left')

Table 4: Compare sf::gdal\_utils.rasterize to fasterize

This table shows that there are larger differences between fasterize and
the other rasterize techniques.

There are 332 features that are different, but again this is not a
significant number.

In comparing the difference, they all seem to be where there is a
diagonal bisector of the raster.

![Figure 1.
Differences](D:/data/GitManagedProjects/FAIB_PSPL/Rasterize_methods/Fasterize_vs_gdal_util.png)

This shows where diagonal lines bisect the raster, the raster cell value
can take either the left or right value.

    # build a raster brick of all the differences.

    # create list of rasters
    #lst <- list(r1,r2,r3,r4,r5)
    lst <- list(r1,r2,r3,r4)

    # create a brick of these rasters from list
    raster_brick <-terra::rast(lst)

    # write brick to a tiff
    tif_brick <- 'D:/data/data_projects/VRI_Rasterization/tif_brick.tif'
    terra::writeRaster(raster_brick, tif_brick, datatype='INT4U', overwrite=TRUE)

    # write the fasterize compare to a tif

    diff_tif <- 'D:/data/data_projects/VRI_Rasterization/tif_diff.tif'
    terra::writeRaster(c1, diff_tif, datatype='INT4U', overwrite=TRUE)

## Discussion

The first 4 methods seem to line up quite well. The differences between
the GDB and PostgreSQL as source come from the interpretation of a
diagonal line bisecting the raster. One method goes left, the other goes
right. Comparing the 2 GDB reads and the 2 PostgreSQL reads, they are
identical. There is only a difference when comparing between the GDB and
PostgreSQL reads.

The fasterize raster also lines up reasonably well with only 332
feature\_ids with differing values.

Fasterize requires 64GB of RAM to be able to complete this task. IT will
NOT run on a 32GB machine.

As to which method is best, it is more of a personal preference. The
first 2 methods mean the OSGEO/GDAL does NOT need to be installed on a
users machine. It also means that there are no ENV requirements that
need to be updated. From a drop on an analysts desk point of view, the
first 2 methods are simpler.

The third and fourth methods require an install of GDAL and also require
an update to the ENV to locate all the software components. This needs
to be updated every time GDAL changes.
