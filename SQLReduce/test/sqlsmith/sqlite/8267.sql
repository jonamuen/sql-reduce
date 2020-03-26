select  
  (select id from main.t0 limit 1 offset 3)
     as c0, 
  subq_0.c5 as c1
from 
  (select  
        cast(coalesce(ref_0.id,
          ref_0.id) as INT) as c0, 
        ref_0.id as c1, 
        ref_0.id as c2, 
        ref_0.name as c3, 
        ref_0.name as c4, 
        ref_0.id as c5, 
        ref_0.name as c6, 
        ref_0.id as c7
      from 
        main.t0 as ref_0
      where ref_0.name is NULL
      limit 58) as subq_0
where 1
limit 44;
