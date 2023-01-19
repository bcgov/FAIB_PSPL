# Point Raster Intersect

**DRAFT ONLY: waiting for comparison of methods**

## PSPL data
PSPL data takes the form of a set of points that cover the province and are based on a regular grid.  This grid follows the HaBC extents.  Given the size of the data, it is broken into 37 units, each representing Timber Supply Area (TSA) boundaries.   


VRI data (veg_comp_lyr_r1_poly) is in a vector spatial format and is rasterized for use in TSR.  The VRI data is rasterized to the same base as the PSPL point data.

## Potential new methods

The intersection of the VRI and PSPL data is a process that can take significant processing time.  Recent improvements in raster processing in R have led to a switch from a previously PostgreSQL based spatial intersect to an R based raster process.

## PostgreSQL Process

Prior to using R raster processing, the PSPL point sets (TSA based) were imported into PostgreSQL and a spatial intersect was run to join the VRI feature_id to each PSPL point.  

Intersection: st_contains(VRI.wkb_geometry,PSPL.wkb_geometry)  

This process took on the order of 2 hours on a 32GB machine.

## Downloading PSPL data

PSPL data is publicly available here: 

https://governmentofbc.maps.arcgis.com/apps/webappviewer/index.html?id=7bb2cbccb9be4f0aa808f1858b399980


And for ministry users there is an ftp site:

ftp://ftp.for.gov.bc.ca/HTS/external/!publish/Provincial_Site_Productivity_Layer/Site_Prod_with_Approved_PEM_TEM/Site_Prod_Point_FGDBs/


## Process

Once the unit point sets are downloaded, the following sequence is used to join the VRI feature_id to each PSPL point:

- crop the VRI raster feature_id to the unit boundary
- intersect with the VRI raster and join the feature_id
- append the unit data to a PostgreSQL table

The intersect utilizes the terra::extract(cropped_raster,point_set) which serves to join the feature_id from the VRI raster at the given x,y location defined by the point. 

## Data Dictionary

The PSPL data takes the following form in the PostgreSLQ database:

Table: msyt_2022.pspl_intersected

|   Column   |       Type       |
|------------|------------------|
| id_tag     | text             |
| at_si      | double precision |
| ba_si      | double precision |
| bg_si      | double precision |
| bl_si      | double precision |
| cw_si      | double precision |
| dr_si      | double precision |
| ep_si      | double precision |
| fd_si      | double precision |
| hm_si      | double precision |
| hw_si      | double precision |
| lt_si      | double precision |
| lw_si      | double precision |
| pa_si      | double precision |
| pl_si      | double precision |
| pw_si      | double precision |
| py_si      | double precision |
| sb_si      | double precision |
| se_si      | double precision |
| ss_si      | double precision |
| sw_si      | double precision |
| sx_si      | double precision |
| yc_si      | double precision |
| bapid      | integer          |
| pem_spp    | text             |
| bgc_label  | text             |
| tsa_number | text             |
| pspl_id    | integer          |
| feature_id | double precision |
| gr_skey    | double precision |
| tab_no     | double precision |






