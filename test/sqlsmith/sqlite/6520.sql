select  
  subq_0.c1 as c0, 
  subq_0.c0 as c1, 
  (select name from main.t0 limit 1 offset 3)
     as c2, 
  subq_0.c1 as c3, 
  subq_0.c1 as c4, 
  subq_0.c1 as c5
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1
      from 
        main.t0 as ref_0
      where ref_0.id is not NULL
      limit 103) as subq_0
where subq_0.c0 is not NULL
limit 114;
