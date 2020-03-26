select  
  subq_0.c2 as c0, 
  subq_0.c2 as c1
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1, 
        (select name from main.t0 limit 1 offset 5)
           as c2, 
        ref_0.id as c3
      from 
        main.t0 as ref_0
      where ref_0.name is not NULL
      limit 106) as subq_0
where (select name from main.t0 limit 1 offset 5)
     is NULL
limit 37;
