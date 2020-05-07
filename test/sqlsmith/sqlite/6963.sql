select distinct 
  subq_0.c7 as c0, 
  subq_0.c1 as c1, 
  subq_0.c0 as c2
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1, 
        ref_0.id as c2, 
        ref_0.id as c3, 
        (select id from main.t0 limit 1 offset 6)
           as c4, 
        ref_0.name as c5, 
        ref_0.name as c6, 
        ref_0.id as c7, 
        ref_0.name as c8, 
        ref_0.name as c9, 
        ref_0.name as c10, 
        ref_0.id as c11
      from 
        main.t0 as ref_0
      where 96 is not NULL) as subq_0
where subq_0.c4 is NULL;
