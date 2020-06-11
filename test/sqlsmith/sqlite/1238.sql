select  
  subq_0.c0 as c0, 
  93 as c1
from 
  (select  
        ref_0.name as c0
      from 
        main.t0 as ref_0
      where (0) 
        and (ref_0.id is not NULL)
      limit 85) as subq_0
where (subq_0.c0 is not NULL) 
  and (((((0) 
          and (subq_0.c0 is not NULL)) 
        or (((subq_0.c0 is NULL) 
            or (subq_0.c0 is not NULL)) 
          and (subq_0.c0 is NULL))) 
      or (1)) 
    and (subq_0.c0 is NULL));
