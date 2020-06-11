select  
  subq_0.c1 as c0, 
  subq_0.c5 as c1, 
  subq_0.c3 as c2
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1, 
        ref_0.name as c2, 
        ref_0.name as c3, 
        ref_0.id as c4, 
        ref_0.id as c5
      from 
        main.t0 as ref_0
      where 0
      limit 111) as subq_0
where (((subq_0.c4 is not NULL) 
      and (subq_0.c0 is not NULL)) 
    or ((subq_0.c3 is not NULL) 
      and ((subq_0.c3 is NULL) 
        and (0)))) 
  and (subq_0.c1 is not NULL)
limit 135;
