select  
  subq_0.c2 as c0, 
  subq_0.c3 as c1
from 
  (select  
        ref_0.name as c0, 
        (select name from main.t0 limit 1 offset 6)
           as c1, 
        ref_0.name as c2, 
        ref_0.name as c3, 
        ref_0.id as c4, 
        ref_0.id as c5
      from 
        main.t0 as ref_0
      where ref_0.name is NULL) as subq_0
where 0
limit 25;
