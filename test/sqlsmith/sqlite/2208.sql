select  
  66 as c0, 
  subq_0.c0 as c1, 
  subq_0.c1 as c2, 
  subq_0.c0 as c3, 
  subq_0.c0 as c4
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1
      from 
        main.t0 as ref_0
      where ref_0.id is not NULL
      limit 32) as subq_0
where subq_0.c0 is NULL;
