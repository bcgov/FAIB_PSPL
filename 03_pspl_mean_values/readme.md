# PSPL Mean Values

Once the PSPL data has been joined with the VRI, 3 sets of mean values can be derived:

- feature_id mean values
- opening_id mean values
- BEC based mean values

These values are the RAW PSPL values.  No conversions or substitutions have been made. 

## Pre-Processing

Set any occurrences of a site index values being 0 to NULL.  This allows the SQL processor to ignore NULLs in calulating a mean value.  

Data type for individual values is kept are DOUBLE for processing mean values.  

Create initial table: pspl_init  

Note that this data is taken as is from the PSPL source.

## Derive BEC for feature_id

Within a feature_id, the BEC is assigned using the largest count of the bec zone and subzone.  
Count can be used since each point has equal weight.

## Derive BEC for opening_id

Within a opening_id, the BEC is assigned using the largest count of the bec zone and subzone


## Derive feature_id mean site index values

Processing note:

This process requires tuning on 8GB or less processor

ERROR:  out of memory
DETAIL:  Failed on request of size 848 in memory context "Caller tuples".
CONTEXT:  parallel worker

if required can shut down parallell processing  
set max_parallel_workers_per_gather = 2;  

This process runs fine on a 32GB machine as is.  


Cast final values to Numeric(5,1)

Uses the SQL avg function: cast(avg(at_si) as numeric(5,1)) as at_si as an example, with a cast to Numeric(5.1) for the output table.  

group by feature_id

## Derive BEC mean values 

Derive the Bec zone, subzone grouped mean values for site index.

## Derive the opening_id mean site index values

Again use the SQL function avg and cast to Numeric(5,1)  
group by feature_id

## Join with both feature_id and opening_id BEC

Create the pre-convert tables:  

- pspl_op_site_index_pre_convert
- pspl_fid_site_index_pre_convert
- pspl_bec_site_index_pre_convert

## Export these to csv

- pspl_fid_site_index_pre_convert.csv
- pspl_op_site_index_pre_convert.csv
- pspl_bec_site_index_pre_convert.csv

NOTE:  CSVs created for transitional testing against older site index conversion C program.  
Can probably re-write this to just have R read the PostgreSQl tables.


## Data Dictionary


Format for feature_id/opening_id:

|  Column    |       Type       |
|------------|------------------|
|feature_id  | double precision |
|at_si       | numeric(5,1)     |
|ba_si       | numeric(5,1)     |
|bg_si       | numeric(5,1)     |
|bl_si       | numeric(5,1)     |
|cw_si       | numeric(5,1)     |
|dr_si       | numeric(5,1)     |
|ep_si       | numeric(5,1)     |
|fd_si       | numeric(5,1)     |
|hm_si       | numeric(5,1)     |
|hw_si       | numeric(5,1)     |
|lt_si       | numeric(5,1)     |
|lw_si       | numeric(5,1)     |
|pa_si       | numeric(5,1)     |
|pl_si       | numeric(5,1)     |
|pw_si       | numeric(5,1)     |
|py_si       | numeric(5,1)     |
|sb_si       | numeric(5,1)     |
|se_si       | numeric(5,1)     |
|ss_si       | numeric(5,1)     |
|sw_si       | numeric(5,1)     |
|sx_si       | numeric(5,1)     |
|yc_si       | numeric(5,1)     |
|bec_zone    | text             |
|bec_subzone | text             |

Format for BEC:

|  Column    |       Type       |
|------------|------------------|
|bec_zone    | text             |
|bec_subzone | text             |
|at_si       | numeric(5,1)     |
|ba_si       | numeric(5,1)     |
|bg_si       | numeric(5,1)     |
|bl_si       | numeric(5,1)     |
|cw_si       | numeric(5,1)     |
|dr_si       | numeric(5,1)     |
|ep_si       | numeric(5,1)     |
|fd_si       | numeric(5,1)     |
|hm_si       | numeric(5,1)     |
|hw_si       | numeric(5,1)     |
|lt_si       | numeric(5,1)     |
|lw_si       | numeric(5,1)     |
|pa_si       | numeric(5,1)     |
|pl_si       | numeric(5,1)     |
|pw_si       | numeric(5,1)     |
|py_si       | numeric(5,1)     |
|sb_si       | numeric(5,1)     |
|se_si       | numeric(5,1)     |
|ss_si       | numeric(5,1)     |
|sw_si       | numeric(5,1)     |
|sx_si       | numeric(5,1)     |
|yc_si       | numeric(5,1)     |
