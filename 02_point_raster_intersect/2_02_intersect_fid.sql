-- process each pspl by unit
-- 2023_jan_16

-- creates table: pspl_fid_merged
-- all pspl unit table merged and intersected with veg

-- assume that veg has come in as veg_comp_spatial

-- each unit has a spatial index set when loaded from ogr

-- assume that data has been loaded to unit(1)- unit(n)


-- call using >psql -f 1_intersect_veg.sql -v unit=unit8 -v unit_no=8

\echo "processing"
\echo :sp

-- pre delete rows where ALL site index values are NULL
delete from :unit where
at_si is null and
ba_si is null and
bg_si is null and
bl_si is null and
cw_si is null and
dr_si is null and
ep_si is null and
fd_si is null and
hm_si is null and
hw_si is null and
lt_si is null and
lw_si is null and
pa_si is null and
pl_si is null and
pw_si is null and
py_si is null and
sb_si is null and
se_si is null and
ss_si is null and
sw_si is null and
sx_si is null and
yc_si is null
;

vacuum analyze :unit;

-- Intersection: -- where veg_comp polygon contains the SPROD points
--drop table if exists :sp;
--select now();
--create table :sp as

insert into pspl_fid_merged 
select
	--a.ogc_fid,
	b.feature_id,
	a.id_tag,
	a.at_si,
	a.ba_si,
	a.bg_si,
	a.bl_si,
	a.cw_si,
	a.dr_si,
	a.ep_si,
	a.fd_si,
	a.hm_si,
	a.hw_si,
	a.lt_si,
	a.lw_si,
	a.pa_si,
	a.pl_si,
	a.pw_si,
	a.py_si,
	a.sb_si,
	a.se_si,
	a.ss_si,
	a.sw_si,
	a.sx_si,
	a.yc_si,
	--a.bapid,
	--a.pem_spp,
	--a.bgc_label,
	--a.tsa_number,
	--a.wkb_geometry,
	:unit_no as unit_no
from :unit a, veg_comp_spatial b
where st_contains(b.wkb_geometry,a.wkb_geometry) and a.wkb_geometry && b.wkb_geometry 
;



select now();






