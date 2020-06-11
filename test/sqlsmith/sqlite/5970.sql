select  
  subq_0.c0 as c0, 
  subq_0.c0 as c1, 
  subq_0.c0 as c2
from 
  (select  
        ref_0.name as c0
      from 
        main.t0 as ref_0
      where 0) as subq_0
where subq_0.c0 is not NULL
limit 60;
