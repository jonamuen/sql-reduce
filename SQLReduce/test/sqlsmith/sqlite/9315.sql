select  
  subq_0.c0 as c0, 
  subq_0.c1 as c1, 
  subq_0.c0 as c2, 
  subq_0.c0 as c3
from 
  (select  
        ref_0.name as c0, 
        ref_0.id as c1
      from 
        main.t0 as ref_0
      where ref_0.id is NULL
      limit 66) as subq_0
where subq_0.c1 is not NULL;
