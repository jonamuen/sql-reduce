select  
  subq_0.c1 as c0, 
  subq_0.c3 as c1, 
  subq_0.c5 as c2, 
  subq_0.c5 as c3, 
  subq_0.c3 as c4, 
  subq_0.c4 as c5, 
  subq_0.c7 as c6, 
  subq_0.c3 as c7, 
  subq_0.c0 as c8, 
  subq_0.c6 as c9, 
  subq_0.c2 as c10, 
  subq_0.c6 as c11, 
  subq_0.c3 as c12, 
  subq_0.c4 as c13, 
  subq_0.c0 as c14, 
  subq_0.c4 as c15
from 
  (select  
        ref_0.name as c0, 
        ref_0.id as c1, 
        ref_0.id as c2, 
        ref_0.id as c3, 
        ref_0.name as c4, 
        ref_0.id as c5, 
        ref_0.name as c6, 
        cast(coalesce(ref_0.name,
          ref_0.name) as VARCHAR(16)) as c7
      from 
        main.t0 as ref_0
      where 0
      limit 54) as subq_0
where subq_0.c4 is NULL;
