select  
  subq_0.c2 as c0
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1, 
        ref_0.id as c2, 
        (select id from main.t0 limit 1 offset 2)
           as c3, 
        ref_0.name as c4, 
        ref_0.id as c5, 
        ref_0.name as c6
      from 
        main.t0 as ref_0
      where 0
      limit 126) as subq_0
where (1) 
  or (EXISTS (
    select  
        ref_1.name as c0, 
        ref_1.name as c1, 
        subq_0.c2 as c2
      from 
        main.t0 as ref_1
      where ref_1.id is not NULL
      limit 77));
