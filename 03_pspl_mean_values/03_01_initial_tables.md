# PSPL Method 2022

Requires: pspl\_intersected

Creates:

-   pspl\_site\_index\_mean\_bec
-   pspl\_site\_index\_mean\_fid

no longer producing:

-   pspl\_site\_index\_mean\_op

These are the mean values tables (grouped)

## PSPL data pre-processing

-   Set all 0 values to NULL
-   Join PSPL to VRI opening\_id

Note on BEC. BEC must be consistent between the point set and VRI.

In this case, BEC 12 has been added to the VRI.

The BEC is based on the opening largest BEC contribution for

## Treatment of NULL values

There are 22 species site index values for each feature\_id. In general,
some of these will not have data and thus be null. When deriving mean
values, it is important to exclude these NULL values from the
calculation. It is also important to check that 0 is not substituted for
a NULL. This can happen inadvertently when using a DUCK Typed language
such as R.

Start: 2023-02-07 14:35:49

### Initialize PostgreSQL Connection

    year <- '2022'

    library(RPostgreSQL)

    ## Loading required package: DBI

    # set up for schema and user
    schema <- paste0('msyt_',year)
    opt <- paste0("-c search_path=",schema)
    user_name <- 'results'
    database <- 'msyt'
    con <- dbConnect('PostgreSQL',dbname='msyt',user=user_name,options=opt)
    #con <- dbConnect('PostgreSQL',dbname='msyt',user=user_name)



    db_vac <- function(tb){
      
      com <- shQuote(paste0('vacuum analyze ',tb))
      cmd_arg <- c('-d ' ,database,
                        '-c ' ,com)
      system2('psql', args=cmd_arg,stderr=TRUE)
      
    }

    pg_dump_table <- function(t_name,folder){
      
      # -O required to negate ownership
      
      f_out <- paste0(folder,t_name,'.sql')

      
      q1 <- paste0("-d ",
                   database,
                   " -O",
                    " -t ",
                    t_name,
                   " -f ",
                   f_out )
      
      system2("pg_dump",args=q1,stderr=TRUE,wait=TRUE)
      print(q1)
      
    }

### Create inital (temp) table

-   read: pspl\_intersected
-   create: pspl\_init\_t

This contains the entire Provincial set of PSPL points


    --drop sequence if exists t1_seq;
    --create sequence t1_seq;

    drop table if exists pspl_init;
    drop table if exists pspl_init_t;

    select now() as "start create pspl raw initialze";

    -- in each unit(n) objectid is unique
    -- after the merge, objectid is no longer unique
    -- create id as unique

    -- use NULLIF to change 0 si values to NULL
    -- required so AVG() ignores the NULL values 

    -- this is redundant as the intersection process should have set NULLs properly
    --  keep just in case

    create table pspl_init_t as 
    select 
        --nextval('t1_seq') as id,  -- unique id,
        feature_id,
        NULLIF(at_si,0) as at_si,
        NULLIF(ba_si,0) as ba_si,
        NULLIF(bg_si,0) as bg_si,
        NULLIF(bl_si,0) as bl_si,
        NULLIF(cw_si,0) as cw_si,
        NULLIF(dr_si,0) as dr_si,
        NULLIF(ep_si,0) as ep_si,
        NULLIF(fd_si,0) as fd_si,
        NULLIF(hm_si,0) as hm_si,
        NULLIF(hw_si,0) as hw_si,
        NULLIF(lt_si,0) as lt_si,
        NULLIF(lw_si,0) as lw_si,
        NULLIF(pa_si,0) as pa_si,
        NULLIF(pl_si,0) as pl_si,
        NULLIF(pw_si,0) as pw_si,
        NULLIF(py_si,0) as py_si,
        NULLIF(sb_si,0) as sb_si,
        NULLIF(se_si,0) as se_si,
        NULLIF(ss_si,0) as ss_si,
        NULLIF(sw_si,0) as sw_si,
        NULLIF(sx_si,0) as sx_si,
        NULLIF(yc_si,0) as yc_si
        --trim(substring(bgc_label,1,4)) as bec_zone,
        --trim(substring(bgc_label,5,3)) as bec_subzone
    from pspl_intersected ;
    --where feature_id is not NULL;

    select now() as "end init";

<table>
<caption>1 records</caption>
<thead>
<tr class="header">
<th style="text-align: left;">end init</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">2023-02-07 14:35:50</td>
</tr>
</tbody>
</table>

1 records

Initial Table: 2023-02-07 14:37:03

### Index the intial table

     
    create index m_idx_sr2 on pspl_init_t(feature_id);

Index: 2023-02-07 14:37:24

    tbl <- paste0(schema,'.pspl_init_t')
    db_vac(tbl)

    ## character(0)

Vacuum Analyze: 2023-02-07 14:37:32

## Create pre convert table

-   pspl\_init

Note that BEC 12 from VRI is being used.

The VRI has BEC assigned by largest BEC within opening.


    --drop sequence t1_seq;

    -- add opening from veg_comp
    drop table if exists pspl_init;
    create table pspl_init as
    select
        --a.id,
        a.feature_id,
        --b.opening_id,
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
        b.bec_zone,
        b.bec_subzone
    from pspl_init_t a
    left join veg_comp b using(feature_id)
    ;

    --drop table pspl_init_t;

    create index idx_pspl1 on pspl_init(feature_id);
    --create index idx_pspl2 on pspl_init(opening_id);

    select now();

<table>
<caption>1 records</caption>
<thead>
<tr class="header">
<th style="text-align: left;">now</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">2023-02-07 14:37:32</td>
</tr>
</tbody>
</table>

1 records

Pspl Init: 2023-02-07 14:39:14

### generate feature\_id mean values using SQL

-   these are the unconverted data
-   generate feature\_id based si mean values
-   any initial Zero si values have been converted to NULL

Take the original PSPL data by pid and generate the feature\_id based
mean values.

Processing note:

This process requires 8GB

ERROR: out of memory DETAIL: Failed on request of size 848 in memory
context “Caller tuples”. CONTEXT: parallel worker

if required can shut down parallel processing  
set max\_parallel\_workers\_per\_gather = 2;

This process runs fine on a 32GB machine as is.

Cast final values to Numeric(5,1)



    drop table if exists pspl_site_index_mean_fid;
    create table pspl_site_index_mean_fid as
    select
        feature_id,
        cast(avg(at_si) as numeric(5,1)) as at_si,
        cast(avg(ba_si) as numeric(5,1)) as ba_si,
        cast(avg(bg_si) as numeric(5,1)) as bg_si,
        cast(avg(bl_si) as numeric(5,1)) as bl_si,
        cast(avg(cw_si) as numeric(5,1)) as cw_si,
        cast(avg(dr_si) as numeric(5,1)) as dr_si,
        cast(avg(ep_si) as numeric(5,1)) as ep_si,
        cast(avg(fd_si) as numeric(5,1)) as fd_si,
        cast(avg(hm_si) as numeric(5,1)) as hm_si,
        cast(avg(hw_si) as numeric(5,1)) as hw_si,
        cast(avg(lt_si) as numeric(5,1)) as lt_si,
        cast(avg(lw_si) as numeric(5,1)) as lw_si,
        cast(avg(pa_si) as numeric(5,1)) as pa_si,
        cast(avg(pl_si) as numeric(5,1)) as pl_si,
        cast(avg(pw_si) as numeric(5,1)) as pw_si,
        cast(avg(py_si) as numeric(5,1)) as py_si,
        cast(avg(sb_si) as numeric(5,1)) as sb_si,
        cast(avg(se_si) as numeric(5,1)) as se_si,
        cast(avg(ss_si) as numeric(5,1)) as ss_si,
        cast(avg(sw_si) as numeric(5,1)) as sw_si,
        cast(avg(sx_si) as numeric(5,1)) as sx_si,
        cast(avg(yc_si) as numeric(5,1)) as yc_si
    from pspl_init
    group by feature_id
    order by 1
    ;

    create index idx_pspl_fid_si on pspl_site_index_mean_fid(feature_id);



    select count (*) as n from pspl_site_index_mean_fid;

Mean si FID: 2023-02-07 14:42:01

### generate BEC mean values

-   generate BEC mean values using pspl\_init

Note that this uses the BEC 12 assigned BEC updated in VRI



    drop table if exists pspl_site_index_mean_bec;
    create table pspl_site_index_mean_bec as
    select
        bec_zone,bec_subzone,
        cast(avg(at_si) as numeric(5,1)) as at_si,
        cast(avg(ba_si) as numeric(5,1)) as ba_si,
        cast(avg(bg_si) as numeric(5,1)) as bg_si,
        cast(avg(bl_si) as numeric(5,1)) as bl_si,
        cast(avg(cw_si) as numeric(5,1)) as cw_si,
        cast(avg(dr_si) as numeric(5,1)) as dr_si,
        cast(avg(ep_si) as numeric(5,1)) as ep_si,
        cast(avg(fd_si) as numeric(5,1)) as fd_si,
        cast(avg(hm_si) as numeric(5,1)) as hm_si,
        cast(avg(hw_si) as numeric(5,1)) as hw_si,
        cast(avg(lt_si) as numeric(5,1)) as lt_si,
        cast(avg(lw_si) as numeric(5,1)) as lw_si,
        cast(avg(pa_si) as numeric(5,1)) as pa_si,
        cast(avg(pl_si) as numeric(5,1)) as pl_si,
        cast(avg(pw_si) as numeric(5,1)) as pw_si,
        cast(avg(py_si) as numeric(5,1)) as py_si,
        cast(avg(sb_si) as numeric(5,1)) as sb_si,
        cast(avg(se_si) as numeric(5,1)) as se_si,
        cast(avg(ss_si) as numeric(5,1)) as ss_si,
        cast(avg(sw_si) as numeric(5,1)) as sw_si,
        cast(avg(sx_si) as numeric(5,1)) as sx_si,
        cast(avg(yc_si) as numeric(5,1)) as yc_si
    from pspl_init
    group by bec_zone,bec_subzone
    order by 1
    ;

    select count(*) as n from pspl_site_index_mean_bec;

BEC Mean si: 2023-02-07 14:42:17

-   original values from PSPL are numeric(n,1)
-   values in PostreSQL are double

<!-- -->

    dbDisconnect(con)

End: 2023-02-07 14:42:17
