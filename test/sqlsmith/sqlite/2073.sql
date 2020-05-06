select  
  subq_0.c2 as c0, 
  subq_0.c3 as c1, 
  subq_0.c1 as c2
from 
  (select  
        ref_0.name as c0, 
        ref_0.id as c1, 
        ref_0.name as c2, 
        ref_0.id as c3, 
        ref_0.id as c4, 
        ref_0.id as c5, 
        ref_0.id as c6, 
        ref_0.id as c7, 
        ref_0.id as c8, 
        ref_0.id as c9, 
        ref_0.id as c10, 
        ref_0.name as c11, 
        ref_0.name as c12
      from 
        main.t0 as ref_0
      where 0
      limit 113) as subq_0
where subq_0.c6 is NULL
limit 152;
