select  
  74 as c0, 
  subq_0.c0 as c1, 
  subq_0.c0 as c2
from 
  (select  
        ref_0.name as c0
      from 
        main.t0 as ref_0
      where 0
      limit 68) as subq_0
where (((subq_0.c0 is NULL) 
      or (67 is NULL)) 
    and (subq_0.c0 is NULL)) 
  or (subq_0.c0 is not NULL)
limit 96;
