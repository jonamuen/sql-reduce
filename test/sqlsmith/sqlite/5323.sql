select  
  subq_0.c1 as c0
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1
      from 
        main.t0 as ref_0
      where 1
      limit 42) as subq_0
where (subq_0.c0 is NULL) 
  or ((subq_0.c1 is NULL) 
    and (subq_0.c1 is NULL))
limit 122;
