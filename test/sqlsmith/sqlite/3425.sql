select  
  subq_0.c0 as c0, 
  (select id from main.t0 limit 1 offset 5)
     as c1, 
  subq_0.c0 as c2, 
  subq_0.c0 as c3
from 
  (select  
        ref_0.id as c0
      from 
        main.t0 as ref_0
      where ref_0.name is not NULL
      limit 138) as subq_0
where subq_0.c0 is NULL
limit 128;
