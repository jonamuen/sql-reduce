select  
  subq_0.c0 as c0, 
  subq_0.c1 as c1, 
  subq_0.c0 as c2, 
  subq_0.c2 as c3, 
  subq_0.c0 as c4
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1, 
        ref_0.name as c2
      from 
        main.t0 as ref_0
      where 1
      limit 189) as subq_0
where (0) 
  or (subq_0.c1 is not NULL)
limit 128;
