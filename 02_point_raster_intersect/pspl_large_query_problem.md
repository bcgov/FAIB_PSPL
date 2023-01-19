

# psql problem


| table | n|
|:---|:---|
|pspl from GDAL | 62 764 759 |
|pspl from terra | 62 764 765 |

msyt=> explain select id_tag from p2 where id_tag not in (select id_tag from p1);  
                                     QUERY PLAN  
-------------------------------------------------------------------------------------  
 Gather  (cost=1000.00..14639275335383.73 rows=31382382 width=20)  
   Workers Planned: 4  
   ->  Parallel Seq Scan on p2  (cost=0.00..14639272196145.54 rows=7845596 width=20)  
         Filter: (NOT (SubPlan 1))  
         SubPlan 1  
           ->  Materialize  (cost=0.00..1709010.40 rows=62764760 width=20)  
                 ->  Seq Scan on p1  (cost=0.00..1027423.60 rows=62764760 width=20)  
(7 rows)  


create index x1 on p1(id_tag);
create index x2 on p2(id_tag);

vacuum analyze p1;
vacuum analyze p2;

explain select id_tag from p2 where id_tag not in (select id_tag from p1);

msyt=> explain select id_tag from p2 where id_tag not in (select id_tag from p1);  
                                     QUERY PLAN  
-------------------------------------------------------------------------------------  
 Gather  (cost=1000.00..14639275335383.73 rows=31382382 width=20)  
   Workers Planned: 4  
   ->  Parallel Seq Scan on p2  (cost=0.00..14639272196145.54 rows=7845596 width=20)  
         Filter: (NOT (SubPlan 1))  
         SubPlan 1  
           ->  Materialize  (cost=0.00..1709010.40 rows=62764760 width=20)  
                 ->  Seq Scan on p1  (cost=0.00..1027423.60 rows=62764760 width=20)  
(7 rows)  


## try resetting statistics

alter table p1 alter id_tag set statistics 10000;    
alter table p1 alter id_tag set statistics 10000;  

msyt=> explain select id_tag from p2 where id_tag not in (select id_tag from p1);  
                                     QUERY PLAN  
-------------------------------------------------------------------------------------  
 Gather  (cost=1000.00..14639275335383.73 rows=31382382 width=20)  
   Workers Planned: 4  
   ->  Parallel Seq Scan on p2  (cost=0.00..14639272196145.54 rows=7845596 width=20)  
         Filter: (NOT (SubPlan 1))  
         SubPlan 1  
           ->  Materialize  (cost=0.00..1709010.40 rows=62764760 width=20)  
                 ->  Seq Scan on p1  (cost=0.00..1027423.60 rows=62764760 width=20)  
(7 rows)  

## Force the sequential scan off

msyt=> set enable_seqscan = off;  
SET  
msyt=> explain select id_tag from p2 where id_tag not in (select id_tag from p1);  
                                             QUERY PLAN  
-----------------------------------------------------------------------------------------------------  
 Gather  (cost=1001.13..16650271183220.39 rows=31382382 width=20)  
   Workers Planned: 4  
   ->  Parallel Index Only Scan using x2 on p2  (cost=1.13..16650268043982.19 rows=7845596 width=20)  
         Filter: (NOT (SubPlan 1))  
         SubPlan 1  
           ->  Materialize  (cost=0.56..1965332.57 rows=62764760 width=20)  
                 ->  Index Only Scan using x1 on p1  (cost=0.56..1283745.77 rows=62764760 width=20)  
(7 rows)  

This has not fixed the problem.  

create table p3 as   
select a.id_tag,b.id_tag as p1_id_tag  
from p2 a  
left join p1 b using(id_tag)  
;

                                       QUERY PLAN  
----------------------------------------------------------------------------------------  
 Merge Left Join  (cost=1.13..3508964.10 rows=62764760 width=40)  
   Merge Cond: (a.id_tag = b.id_tag)  
   ->  Index Only Scan using x1 on p1 a  (cost=0.56..1283745.77 rows=62764760 width=20)   
   ->  Index Only Scan using x2 on p2 b  (cost=0.56..1283746.92 rows=62764764 width=20)  
(4 rows)  



select * from p3 where p1_id_tag is null;








