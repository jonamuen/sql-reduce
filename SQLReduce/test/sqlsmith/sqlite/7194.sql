select  
  case when ((subq_0.c6 is NULL) 
        or (subq_0.c3 is NULL)) 
      and ((subq_0.c0 is NULL) 
        or (subq_0.c3 is not NULL)) then subq_0.c3 else subq_0.c3 end
     as c0
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1, 
        ref_0.name as c2, 
        ref_0.id as c3, 
        ref_0.name as c4, 
        ref_0.name as c5, 
        ref_0.id as c6, 
        ref_0.id as c7
      from 
        main.t0 as ref_0
      where 0
      limit 178) as subq_0
where (select name from main.t0 limit 1 offset 3)
     is not NULL
limit 133;
