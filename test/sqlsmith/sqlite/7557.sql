select  
  subq_0.c4 as c0, 
  (select id from main.t0 limit 1 offset 5)
     as c1, 
  subq_0.c1 as c2, 
  subq_0.c10 as c3, 
  subq_0.c9 as c4
from 
  (select distinct 
        ref_0.name as c0, 
        ref_0.id as c1, 
        ref_0.name as c2, 
        ref_0.id as c3, 
        ref_0.name as c4, 
        ref_0.id as c5, 
        ref_0.name as c6, 
        ref_0.id as c7, 
        ref_0.id as c8, 
        (select id from main.t0 limit 1 offset 2)
           as c9, 
        ref_0.id as c10, 
        20 as c11, 
        ref_0.id as c12
      from 
        main.t0 as ref_0
      where (select id from main.t0 limit 1 offset 27)
           is not NULL
      limit 36) as subq_0
where (subq_0.c6 is NULL) 
  or (subq_0.c1 is not NULL)
limit 84;
