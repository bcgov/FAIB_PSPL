# RASTER Standards for Analysis Ready Data

## Source Data

Sources:

- whse_forest_vegetation.veg_comp_lyr_r1_poly 
- gdb from Data BC
- gdb from Vivid (pre WHSE load)
- gdb internal from Vivid (pre WHSE load)

Discussion:

How many (other that Iain will ever us the internal only version of veg_comp?

## Raster Output Type

Recommended:

Int32

In the GDAL documentation, the list of supported integer data types includes:

- Int16 (short)
- Int32 (long)

 Since the max value for Int32 is 2,147,483,647 this should be adequate to allow for future feature_ids.

Long Integer

Discussion:

see presentation from Dave on why to use Long Integer

## Provincial Extents

As per Iaian:


| Extent | Value |
|:-------|:------|
| xmin | 273287.5 |
| xmax | 1870587.5 |
| ymin | 367787.5 |
| ymax <- 1735787.5 |

## No Data Value

Value = 0

Discussion:
- need example
Setting -a_noData is not enough

may have to read (terra::rast(src)  
then cast to 0 using:  
r1[is.na(r1)]  <- 0  
then re-write  



## Coordinate System

- EPSG:3005
- PROJ 7.2.1 definition

## Provincial Mask

All data near the borders or coast needs to have a provincial mask applied to it.  

It also seems that some version of VRI seems to have a piece in western Alberta?

## GDAL Backing

- 3.2.1 (minimum)

## Python, OSGEO4W, GDAL

- not required for base analyst install
- may be required under specific circumstances
	- Iaian

If Python and GDAL can be replaced by R and letting R handle the links to GDAL internally, OSGEO4W is no longer required.  This simplifies the install base for software and gets around having conflicting Python installs vis a vis 2.x versus 3.x


## Keeping Current

Revisions are made to R packages on a continuing basis.  In some cases (like Rasterization) there can be light speed improvements in performance.  Any tools that we write need to be aware of and keep pace with these changes.  This requires a staff commitment to an ongoing development of tools.
