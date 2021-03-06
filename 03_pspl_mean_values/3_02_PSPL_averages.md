# PSPL Method 2022

-   generate feature id based site index mean values
-   generate BEC averages using feature\_id mean si values
-   generate opening id based site index mean values

requires table:

-   pspl\_init

Create the following tables:

-   pspl\_fid\_bec (temp)

-   pspl\_op\_bec (temp)

-   pspl\_fid\_site\_index\_pre\_convert  

-   pspl\_op\_site\_index\_pre\_convert

-   pspl\_bec\_site\_index\_pre\_convert

Note: no site index conversions have been applied

Means are derived using SQL to avoid overtaxing limited Memory in R

Start: Fri May 20 10:32:45 2022

    library(RPostgreSQL)

    ## Loading required package: DBI

    # set up for schema and user
    schema <- 'msyt_2022'
    opt <- paste0("-c search_path=",schema)
    user_name <- 'postgres'
    database <- 'msyt'
    con <- dbConnect('PostgreSQL',dbname='msyt',user=user_name,options=opt)

# create the feature largest BEC table

-   pspl\_fid\_bec

<!-- -->


    -- do some intial clean up

    drop table if exists pspl_fid_bec;
    drop table if exists pspl_op_bec;

    drop table if exists pspl_fid_site_index_pre_convert;
    drop table if exists pspl_bec_site_index_pre_convert;
    drop table if exists pspl_op_site_index_pre_convert;

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
<td style="text-align: right;">4721645</td>
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
<td style="text-align: right;">221358</td>
</tr>
</tbody>
</table>

1 records

### generate feature\_id averages using SQL

-   these are the unconverted data
-   generate feature\_id based si mean values
-   any initial Zero si values have been converted to NULL

Take the original PSPL data by pid and generate the feature\_id based
mean values.

Processing note:

This process requires tuning on 8GB or less processor

ERROR: out of memory DETAIL: Failed on request of size 848 in memory
context ???Caller tuples???. CONTEXT: parallel worker

if required can shut down parallell processing  
set max\_parallel\_workers\_per\_gather = 2;

This process runs fine on a 32GB machine as is.



    drop table if exists pspl_fid_site_index_pre_convert;
    create table pspl_fid_site_index_pre_convert as
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

    create index idx_pspl_fid_si on pspl_fid_site_index_pre_convert(feature_id);



    select count (*) as n from pspl_fid_site_index_pre_convert;

### generate BEC averages from the feature\_id average data

-   generate BEC averages using pspl\_init
-   use SQL

Note that this uses the PSPL assigned BEC by point  
NOT the feature\_id assigned BEC based on largest number of points



    drop table if exists pspl_bec_site_index_pre_convert;
    create table pspl_bec_site_index_pre_convert as
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

    select count(*) as n from pspl_bec_site_index_pre_convert;

### generate opening\_id averages

-   these are the unconverted data

Take the original PSPL data by pid and generate the opening\_id based
mean values.


    drop table if exists pspl_op_site_index_pre_convert;
    create table pspl_op_site_index_pre_convert as
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
-   after averaging need to make decimals equal

<!-- -->


    drop table if exists t1;
    alter table pspl_op_site_index_pre_convert rename to t1;

    create table pspl_op_site_index_pre_convert as
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
    alter table pspl_fid_site_index_pre_convert rename to t1;

    create table pspl_fid_site_index_pre_convert as
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



    select count(*) as n from pspl_fid_site_index_pre_convert;

### Export to CSV

    # pspl_fid_site_index_pre_convert
    # pspl_op_site_index_pre_convert
    # pspl_bec_site_index_pre_convert

    base <- paste0(substr(getwd(),1,1),':/data/data_projects/pspl_2022/si_data')

    f1 <- paste0(base,'/pspl_fid_site_index_pre_convert.csv')
    q1 <- paste0("copy msyt_2022.pspl_fid_site_index_pre_convert to \'",f1, "\' csv header;")
    dbExecute(con,q1)

    ## [1] 4721645

    f2 <- paste0(base,'/pspl_op_site_index_pre_convert.csv')
    q2 <- paste0("copy msyt_2022.pspl_op_site_index_pre_convert to \'",f2, "\' csv header;")
    dbExecute(con,q2)

    ## [1] 221356

    f3 <- paste0(base,'/pspl_bec_site_index_pre_convert.csv')
    q3 <- paste0("copy msyt_2022.pspl_bec_site_index_pre_convert to \'",f3, "\' csv header;")
    dbExecute(con,q3)

    ## [1] 138

    dbDisconnect(con)

    ## [1] TRUE

End: Fri May 20 10:35:00 2022
