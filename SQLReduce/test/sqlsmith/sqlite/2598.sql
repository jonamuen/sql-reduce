select  
  subq_0.c1 as c0, 
  subq_0.c1 as c1, 
  subq_0.c0 as c2, 
  subq_0.c1 as c3, 
  subq_0.c0 as c4, 
  subq_0.c1 as c5, 
  (select id from main.t0 limit 1 offset 2)
     as c6, 
  subq_0.c1 as c7, 
  subq_0.c1 as c8, 
  subq_0.c1 as c9, 
  subq_0.c1 as c10, 
  subq_0.c0 as c11, 
  subq_0.c0 as c12, 
  subq_0.c1 as c13, 
  subq_0.c0 as c14
from 
  (select  
        ref_0.id as c0, 
        15 as c1
      from 
        main.t0 as ref_0
      where (1) 
        or (case when 1 then ref_0.id else ref_0.id end
             is NULL)
      limit 91) as subq_0
where 17 is not NULL
limit 36;
