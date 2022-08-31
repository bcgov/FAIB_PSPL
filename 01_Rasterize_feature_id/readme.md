# Rasterize feature id

Rasterization of the VRI feature_id, a requirement for the preparation of the Analysis Ready data sets, previously used a stand alone version of gdal_rasterize.  This produce comes from the suit of tools provided through the open source group OSGeo. (https://www.osgeo.org/)  

Using a packaged bundle from OSGeo (OSGeo4W) includes the Geospatial Data Abstraction Library (GDAL) from https://gdal.org/

## GDAL Versions

Using gdal_rasterize with GDAL versions prior to 3.1 to rasterize the VRI generally take ~90min.  

Switching to GDAL version 3.2 and higher show a major performance improvement.  The rasterization of VRI feature_id using newer versions of GDAL now takes ~4min.

## R spatial packages

R has now release some new/updated packages that do not require a local installation of GDAL.  The GDAL binaries are incorporated into the packages and thus any updates are managed on the R package side.  This much simplifies the user installation .  

The process used here to rasterize VRI uses to packages in particular: 

- SF
- Terra

In particular, the rasterization is done using:  

- sf::gdal_utils

This function has the same parameterization as used in the stand alone gdal_rasterize.exe

