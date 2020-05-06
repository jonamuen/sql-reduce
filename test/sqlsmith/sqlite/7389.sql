select  
  subq_0.c0 as c0, 
  subq_0.c0 as c1, 
  subq_0.c0 as c2
from 
  (select  
        ref_0.id as c0
      from 
        main.t0 as ref_0
      where ref_0.name is NULL
      limit 62) as subq_0
where 18 is NULL
limit 111;
