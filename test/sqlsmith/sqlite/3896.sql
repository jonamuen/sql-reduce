select  
  subq_0.c0 as c0, 
  subq_0.c0 as c1, 
  subq_0.c2 as c2, 
  45 as c3
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1, 
        ref_0.name as c2, 
        75 as c3, 
        ref_0.id as c4
      from 
        main.t0 as ref_0
      where ref_0.id is not NULL
      limit 158) as subq_0
where (select id from main.t0 limit 1 offset 98)
     is NULL
limit 137;
