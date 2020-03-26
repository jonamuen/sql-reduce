select  
  subq_0.c16 as c0, 
  subq_0.c0 as c1, 
  subq_0.c0 as c2, 
  cast(nullif((select id from main.t0 limit 1 offset 12)
      ,
    subq_0.c1) as INT) as c3
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1, 
        ref_0.name as c2, 
        (select name from main.t0 limit 1 offset 4)
           as c3, 
        ref_0.id as c4, 
        ref_0.id as c5, 
        ref_0.name as c6, 
        ref_0.name as c7, 
        ref_0.id as c8, 
        ref_0.name as c9, 
        ref_0.name as c10, 
        ref_0.id as c11, 
        (select name from main.t0 limit 1 offset 6)
           as c12, 
        ref_0.name as c13, 
        ref_0.name as c14, 
        ref_0.name as c15, 
        ref_0.name as c16, 
        ref_0.name as c17
      from 
        main.t0 as ref_0
      where 0
      limit 113) as subq_0
where 0
limit 172;
