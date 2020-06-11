select  
  subq_0.c3 as c0, 
  subq_0.c1 as c1
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1, 
        ref_0.id as c2, 
        ref_0.id as c3
      from 
        main.t0 as ref_0
      where 1) as subq_0
where subq_0.c3 is not NULL;
