select  
  subq_0.c1 as c0, 
  subq_0.c1 as c1, 
  subq_0.c0 as c2, 
  subq_0.c0 as c3
from 
  (select  
        ref_0.id as c0, 
        cast(coalesce(ref_0.id,
          ref_0.id) as INT) as c1
      from 
        main.t0 as ref_0
      where ref_0.id is NULL
      limit 93) as subq_0
where 1
limit 23;
