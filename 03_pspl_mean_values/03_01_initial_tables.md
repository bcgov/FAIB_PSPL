# PSPL Method 2022

Requires: pspl\_intersected

Creates:

-   pspl\_site\_index\_pre\_convert\_bec
-   pspl\_site\_index\_pre\_convert\_fid
-   pspl\_site\_index\_pre\_convert\_op

These are the mean values tables (grouped)

## PSPL data pre-processing

-   Set all 0 values to NULL
-   Join PSPL to VRI opening\_id

Note on BEC. Although BEC values are in the VRI data, they are NOT
used.  
Instead, the PSPL BEC is used throughout the MSYT process.

## Treatment of NULL values

There are 22 species site index values for each feature\_id. In general,
some of these will not have data and thus be null. When deriving mean
values, it is important to exclude these NULL values from the
calculation. It is also important to check that 0 is not substituted for
a NULL. This can happen inadvertently when using a DUCK Typed language
such as R.

Start: 2022-09-13 14:36:26

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
      #print(q1)
      
    }

### Create inital (temp) table

-   read: pspl\_intersected
-   crate: pspl\_init\_t

This contains the entire Provincial set of PSPL points


    drop sequence if exists t1_seq;
    create sequence t1_seq;

    drop table if exists pspl_init;
    drop table if exists pspl_init_t;

    select now() as "start create pspl raw initialze";

    -- in each unit(n) objectid is unique
    -- after the merge, objectid is no longer unique
    -- create id as unique

    -- use NULLIF to change 0 si values to NULL
    -- required so AVG() ignores the 0 values 

    create table pspl_init_t as 
    select 
        nextval('t1_seq') as id,    -- unique id,
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
        NULLIF(yc_si,0) as yc_si,
        trim(substring(bgc_label,1,4)) as bec_zone,
        trim(substring(bgc_label,5,3)) as bec_subzone
    from pspl_intersected 
    where feature_id is not NULL;

    select now() as "end init";

### Index the intial table

     
    create index m_idx_sr2 on pspl_init_t(feature_id);

    tbl <- paste0(schema,'.pspl_init_t')
    db_vac(tbl)

    ## character(0)

## Create pre convert table

-   pspl\_init

<!-- -->


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

    create index idx_pspl1 on pspl_init(feature_id);
    create index idx_pspl2 on pspl_init(opening_id);

# create the feature largest BEC table

-   pspl\_fid\_bec

BEC is assigned based on the largest feature\_id contribution


    -- do some intial clean up

    drop table if exists pspl_fid_bec;
    drop table if exists pspl_op_bec;

    drop table if exists pspl_site_index_pre_convert_fid;
    drop table if exists pspl_site_index_pre_convert_bec;
    drop table if exists pspl_site_index_pre_convert_op;

    drop table if exists pspl_fid_site_index;
    drop table if exists pspl_bec_site_index;
    drop table if exists pspl_op_site_index;


    -- create temp table to update bec from pspl_init
    -- uses the largest contributor

    create table pspl_fid_bec as 
    with
        -- count the number of points
        sum_bec as (select count(*) as num_bec,feature_id,bec_zone,bec_subzone 
                                    from pspl_init 
                                    group by 2,3,4
                                    order by 2,3,4 desc),
        -- assign rank 1 to the max
        sum_bec2 as (select num_bec,feature_id,bec_zone,bec_subzone ,
                                rank() over (partition by feature_id order by feature_id,num_bec desc) rn
                                    from sum_bec),
        -- select the first row from each feature_id
        sum_bec3 as (select distinct on (feature_id) feature_id,bec_zone,bec_subzone from sum_bec2 order by feature_id)
    select * from sum_bec3
    ;

    select count(*) from pspl_fid_bec;

<table>
<caption>1 records</caption>
<thead>
<tr class="header">
<th style="text-align: right;">count</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">5321242</td>
</tr>
</tbody>
</table>

1 records

# create the opening largest BEC table

-   pspl\_op\_bec

<!-- -->


    -- create the pspl_op_bec table

    create table pspl_op_bec as
    with
        -- count the number of points
        pspl_op as (select * from pspl_init where opening_id is NOT NULL),
        sum_bec as (select count(*) as num_bec,opening_id,bec_zone,bec_subzone 
                                    from pspl_op group by 2,3,4
                                    order by 2,3,4 desc),
        -- assign rank 1 to the max
        sum_bec2 as (select num_bec,opening_id,bec_zone,bec_subzone ,
                                rank() over (partition by opening_id order by opening_id,num_bec desc) rn
                                    from sum_bec),
        -- select the first row from each opening_id
        sum_bec3 as (select distinct on (opening_id) opening_id,bec_zone,bec_subzone from sum_bec2 order by opening_id)
    select * from sum_bec3
    ;

    select count (*) from pspl_op_bec;

<table>
<caption>1 records</caption>
<thead>
<tr class="header">
<th style="text-align: right;">count</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">256602</td>
</tr>
</tbody>
</table>

1 records

### generate feature\_id mean values using SQL

-   these are the unconverted data
-   generate feature\_id based si mean values
-   any initial Zero si values have been converted to NULL

Take the original PSPL data by pid and generate the feature\_id based
mean values.

Processing note:

This process requires tuning on 8GB or less processor

ERROR: out of memory DETAIL: Failed on request of size 848 in memory
context “Caller tuples”. CONTEXT: parallel worker

if required can shut down parallell processing  
set max\_parallel\_workers\_per\_gather = 2;

This process runs fine on a 32GB machine as is.

Cast final values to Numeric(5,1)



    drop table if exists pspl_site_index_pre_convert_fid;
    create table pspl_site_index_pre_convert_fid as
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

    create index idx_pspl_fid_si on pspl_site_index_pre_convert_fid(feature_id);



    select count (*) as n from pspl_site_index_pre_convert_fid;

### generate BEC mean values

-   generate BEC mean values using pspl\_init
-   use SQL

Note that this uses the PSPL assigned BEC by point  
NOT the feature\_id assigned BEC based on largest number of points



    drop table if exists pspl_site_index_pre_convert_bec;
    create table pspl_site_index_pre_convert_bec as
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

    select count(*) as n from pspl_site_index_pre_convert_bec;

### generate opening\_id averages

-   these are the unconverted data

Take the original PSPL data by pid and generate the opening\_id based
mean values.


    drop table if exists pspl_site_index_pre_convert_op;
    create table pspl_site_index_pre_convert_op as
    select
        opening_id,
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
    from pspl_init where opening_id is not null and opening_id not in (0,-99)
    group by opening_id
    order by 1
    ;

-   original values from PSPL are numeric(n,1)
-   values in PostreSQL are double

<!-- -->


    drop table if exists t1;
    alter table pspl_site_index_pre_convert_op rename to t1;

    create table pspl_site_index_pre_convert_op as
    select 
     a.opening_id,
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
    from t1 a
    left join pspl_op_bec b using (opening_id);

    select now();


    drop table if exists t1;
    alter table pspl_site_index_pre_convert_fid rename to t1;

    create table pspl_site_index_pre_convert_fid as
    select 
     a.feature_id,
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
    from t1 a
    left join pspl_fid_bec b using (feature_id);

    drop table t1;


    drop table pspl_fid_bec;
    drop table pspl_op_bec;



    select count(*) as n from pspl_site_index_pre_convert_fid;

### Export to CSV

    dbDisconnect(con)

    ## [1] TRUE

    # copy can only be run as superuser
    # re-establish connection
    schema <- paste0('msyt_',year)
    opt <- paste0("-c search_path=",schema)
    user_name <- 'postgres'
    database <- 'msyt'
    con <- dbConnect('PostgreSQL',dbname='msyt',user=user_name,options=opt)



    # pspl_site_index_pre_convert_fid
    # pspl_site_index_pre_convert_op
    # pspl_site_index_pre_convert_bec

    base <- paste0(substr(getwd(),1,1),':/data/data_projects/AR',year,'/PSPL/si_data')

    f1 <- paste0(base,'/pspl_site_index_pre_convert_fid.csv')
    q1 <- paste0("copy pspl_site_index_pre_convert_fid to \'",f1, "\' csv header;")
    dbExecute(con,q1)

    ## [1] 5321242

    f2 <- paste0(base,'/pspl_site_index_pre_convert_op.csv')
    q2 <- paste0("copy pspl_site_index_pre_convert_op to \'",f2, "\' csv header;")
    dbExecute(con,q2)

    ## [1] 256600

    f3 <- paste0(base,'/pspl_site_index_pre_convert_bec.csv')
    q3 <- paste0("copy pspl_site_index_pre_convert_bec to \'",f3, "\' csv header;")
    dbExecute(con,q3)

    ## [1] 138

    ## dump to sql

    out_folder <- paste0(substr(getwd(),1,1),':/data/data_projects/AR',year,'/PSPL/si_data/')

    pg_dump_table(paste0('msyt_',year,'.pspl_site_index_pre_convert_bec'),out_folder)

    ## character(0)

    pg_dump_table(paste0('msyt_',year,'.pspl_site_index_pre_convert_fid'),out_folder)

    ## character(0)

    pg_dump_table(paste0('msyt_',year,'.pspl_site_index_pre_convert_op'),out_folder)

    ## character(0)

    tbl <- paste0(schema,'.pspl_init')
    db_vac(tbl)

    ## character(0)

    dbDisconnect(con)

    ## [1] TRUE

End: 2022-09-13 14:47:06
