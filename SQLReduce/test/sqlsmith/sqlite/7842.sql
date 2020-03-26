select  
  subq_0.c0 as c0, 
  subq_0.c4 as c1, 
  subq_0.c1 as c2, 
  subq_0.c2 as c3, 
  subq_0.c4 as c4, 
  subq_0.c2 as c5, 
  subq_0.c0 as c6, 
  subq_0.c2 as c7, 
  subq_0.c3 as c8, 
  (select id from main.t0 limit 1 offset 99)
     as c9, 
  subq_0.c2 as c10, 
  subq_0.c1 as c11
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1, 
        (select id from main.t0 limit 1 offset 2)
           as c2, 
        (select name from main.t0 limit 1 offset 6)
           as c3, 
        ref_0.name as c4
      from 
        main.t0 as ref_0
      where 1
      limit 108) as subq_0
where 0
limit 119;
