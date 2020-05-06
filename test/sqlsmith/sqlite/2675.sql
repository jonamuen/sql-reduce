select  
  subq_0.c0 as c0, 
  (select name from main.t0 limit 1 offset 6)
     as c1, 
  subq_0.c0 as c2, 
  subq_0.c0 as c3, 
  subq_0.c0 as c4, 
  subq_0.c0 as c5
from 
  (select  
        ref_0.id as c0
      from 
        main.t0 as ref_0
      where 0
      limit 121) as subq_0
where 1
limit 53;
