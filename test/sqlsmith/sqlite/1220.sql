select  
  subq_0.c2 as c0
from 
  (select  
        ref_0.id as c0, 
        46 as c1, 
        ref_0.id as c2, 
        ref_0.name as c3, 
        cast(nullif(ref_0.id,
          ref_0.id) as INT) as c4, 
        ref_0.id as c5, 
        ref_0.id as c6
      from 
        main.t0 as ref_0
      where ref_0.id is NULL
      limit 92) as subq_0
where (1) 
  and (subq_0.c3 is NULL)
limit 85;
