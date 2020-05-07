select  
  subq_0.c2 as c0
from 
  (select  
        ref_0.id as c0, 
        42 as c1, 
        ref_0.name as c2
      from 
        main.t0 as ref_0
      where 1
      limit 68) as subq_0
where subq_0.c0 is NULL;
