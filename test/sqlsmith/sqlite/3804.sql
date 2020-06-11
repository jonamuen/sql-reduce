select  
  subq_0.c1 as c0, 
  subq_0.c1 as c1, 
  subq_0.c1 as c2, 
  subq_0.c1 as c3, 
  subq_0.c1 as c4, 
  55 as c5, 
  subq_0.c1 as c6, 
  subq_0.c0 as c7
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1
      from 
        main.t0 as ref_0
      where 0
      limit 67) as subq_0
where 0
limit 130;
