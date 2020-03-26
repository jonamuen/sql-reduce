select  
  subq_0.c0 as c0, 
  subq_0.c0 as c1, 
  subq_0.c0 as c2
from 
  (select  
        ref_0.name as c0
      from 
        main.t0 as ref_0
      where ((0) 
          and (ref_0.id is not NULL)) 
        or (1)
      limit 92) as subq_0
where ((67 is not NULL) 
    and (subq_0.c0 is not NULL)) 
  and (1)
limit 160;
