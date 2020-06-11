select  
  subq_0.c1 as c0, 
  subq_0.c1 as c1, 
  subq_0.c0 as c2
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1
      from 
        main.t0 as ref_0
      where 1
      limit 63) as subq_0
where subq_0.c1 is NULL
limit 153;
