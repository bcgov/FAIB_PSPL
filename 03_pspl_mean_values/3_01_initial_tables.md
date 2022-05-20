## Generate PSPL point averages

-   feature\_id
-   opening\_id

Start: 2022-05-20 09:00:28

    library(RPostgreSQL)

    ## Loading required package: DBI

    # set up for schema and user
    schema <- 'msyt_2022'
    opt <- paste0("-c search_path=",schema)



    user_name <- 'postgres'
    database <- 'msyt'
    con <- dbConnect('PostgreSQL',dbname='msyt',user=user_name,options=opt)
    #con <- dbConnect('PostgreSQL',dbname='msyt',user=user_name)



    db_vac <- function(tb){
      
      com <- shQuote(paste0('vacuum analyze ',tb))
      cmd_arg <- c('-d ' ,database,
                        '-c ' ,com)
      system2('psql', args=cmd_arg,stderr=TRUE)
      
    }


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
    from pspl_raw 
    where feature_id is not NULL;

    select now() as "end init";

     
    create index m_idx_sr2 on pspl_init_t(feature_id);

    tbl <- paste0(schema,'.pspl_init_t')
    db_vac(tbl)

    ## character(0)


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

    tbl <- paste0(schema,'.pspl_init')
    db_vac(tbl)

    ## character(0)

End: 2022-05-20 09:08:11
