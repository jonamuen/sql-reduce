select  
  (select id from main.t0 limit 1 offset 35)
     as c0, 
  subq_0.c1 as c1, 
  subq_0.c0 as c2, 
  subq_0.c0 as c3, 
  subq_0.c1 as c4, 
  subq_0.c1 as c5, 
  (select name from main.t0 limit 1 offset 94)
     as c6
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1
      from 
        main.t0 as ref_0
      where ref_0.id is not NULL
      limit 91) as subq_0
where (((1) 
      and (subq_0.c1 is NULL)) 
    or ((1) 
      or (1))) 
  and (subq_0.c1 is not NULL)
limit 167;
