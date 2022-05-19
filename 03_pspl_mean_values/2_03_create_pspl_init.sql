
-- add unique identifier (point_id) and check_sum: pspl_raw

-- 2021_nov_29

-- create:
--	pspl_init with
--  pspl_red

-- reads:
-- pspl_raw

-- add sequence key
-- cast si from real to numeric(5,1)


-- notes to self
-- in the unit tables objectid is unique
-- after the merge this is no longer unique

--select now() as "start merge step3";

-- set the schema
set search_path to :sch,public;


drop sequence if exists t1_seq;
create sequence t1_seq;

drop table if exists pspl_init;
drop table if exists pspl_init_t;

select now() as "start create pspl raw initialze";

-- in each unit(n) objectid is unique
-- after the merge, objectid is no longer unique
-- create id as unique
create table pspl_init_t as 
select 
	nextval('t1_seq') as id,	-- unique id,
	feature_id,
	cast(at_si as numeric(5,1)) as at_si,
  cast(ba_si as numeric(5,1)) as ba_si,
  cast(bg_si as numeric(5,1)) as bg_si,
  cast(bl_si as numeric(5,1)) as bl_si,
  cast(cw_si as numeric(5,1)) as cw_si,
  cast(dr_si as numeric(5,1)) as dr_si,
  cast(ep_si as numeric(5,1)) as ep_si,
  cast(fd_si as numeric(5,1)) as fd_si,
  cast(hm_si as numeric(5,1)) as hm_si,
  cast(hw_si as numeric(5,1)) as hw_si,
  cast(lt_si as numeric(5,1)) as lt_si,
  cast(lw_si as numeric(5,1)) as lw_si,
  cast(pa_si as numeric(5,1)) as pa_si,
  cast(pl_si as numeric(5,1)) as pl_si,
  cast(pw_si as numeric(5,1)) as pw_si,
  cast(py_si as numeric(5,1)) as py_si,
  cast(sb_si as numeric(5,1)) as sb_si,
  cast(se_si as numeric(5,1)) as se_si,
  cast(ss_si as numeric(5,1)) as ss_si,
  cast(sw_si as numeric(5,1)) as sw_si,
  cast(sx_si as numeric(5,1)) as sx_si,
  cast(yc_si as numeric(5,1)) as yc_si,
	trim(substring(bgc_label,1,4)) as bec_zone,
	trim(substring(bgc_label,5,3)) as bec_subzone

from pspl_raw 
;


select now() as "create indexes on pspl raw";
 

--create index m_idx_sr1 on pspl_raw using gist(wkb_geometry);
create index m_idx_sr2 on pspl_init_t(feature_id);
vacuum analyze pspl_init_t;

select now() as "pspl init complete";
drop sequence t1_seq;

-- add opening from veg_comp
drop table if exists pspl_init;
create table pspl_init as
select
	a.id,
	a.feature_id,
	b.opening_id,
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
	a.bec_zone,
	a.bec_subzone
from pspl_init_t a
left join veg_comp b using(feature_id)
;

drop table pspl_init_t;

create index idx_sr2 on pspl_init(feature_id);
create index idx_ps_op on pspl_init(opening_id);

vacuum analyze pspl_init;


-- keep auxillary info

drop table if exists pspl_red;

create table pspl_red as 
select
	pid,
	feature_id,
	id_tag,
	bapid,
	pem_spp,
	bgc_label,
	tsa_number
from pspl_raw
;

create index idx_pspl2 on pspl_red(feature_id);
vacuum analyze pspl_red;

-- drop the id column
-- this will make the export to csv smaller

alter table pspl_init drop column if exists id;

-- this is the export if required
--copy pspl_init to 'D:/data/data_projects/PSPL_2021/pspl_init.csv' csv header;





