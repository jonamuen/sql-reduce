select  
  subq_0.c5 as c0, 
  subq_0.c0 as c1, 
  subq_0.c8 as c2, 
  subq_0.c6 as c3, 
  subq_0.c0 as c4, 
  subq_0.c6 as c5, 
  subq_0.c8 as c6
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1, 
        ref_0.name as c2, 
        ref_0.name as c3, 
        ref_0.id as c4, 
        ref_0.name as c5, 
        ref_0.id as c6, 
        ref_0.name as c7, 
        ref_0.id as c8
      from 
        main.t0 as ref_0
      where (ref_0.name is not NULL) 
        or (ref_0.id is NULL)
      limit 92) as subq_0
where 0
limit 96;
