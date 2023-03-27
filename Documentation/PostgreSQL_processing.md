#  PSPL Load Process

## load GDB points

Create tables 1-n pspl_unitn

## Intersect with VRI spatial

- REQUIRES: veg_comp_spatial

- create Blank table pspl_fid_merged

IN a for loop, merge the intersected data

- define unit_name & number
- call 02_04_intersect_fid.sql with unit, unit_no
- parameters unit=pspl_unitn
- parameters unit_no = n
- for each unit	
	- delete where si is all NULL
	- st_contains
		- from :unit a, veg_comp_spatial b
		- where st_contains(b.wkb_geometry,a.wkb_geometry) and a.wkb_geometry && b.wkb_geometry 		

Rename the table:

 - alter table pspl_fid_merged rename to pspl_intersected	

## Creat Mean Value Tables 

### Create pspl_init_t
 
- set NULL where any si value is zero
- NULLIF(at_si,0) as at_si  (all 22 si values)
- reading from pspl_intersected

### Create pspl_init

- join BEC from veg_comp_spatial

### Create pspl_site_index_mean_fid

- cast(avg(at_si) as numeric(5,1)) as at_si,

- create mean values using avg which ignored NULLs

### Create pspl_site_index_mean_bec

- select bec_zone,bec_subzone, cast(avg(at_si) as numeric(5,1)) as at_si,
- grouped by bec_zone, bec_subzone

### For each ARset, only need to import

- pspl_site_index_mean_fid
- pspl_site_index_mean_bec

The site index conversion are handled during the MSYT processing.

