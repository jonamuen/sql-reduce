select  
  subq_0.c0 as c0
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1, 
        ref_0.name as c2
      from 
        main.t0 as ref_0
      where ref_0.id is NULL) as subq_0
where subq_0.c0 is not NULL
limit 102;
