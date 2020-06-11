select  
  subq_0.c0 as c0, 
  subq_0.c0 as c1, 
  subq_0.c0 as c2, 
  subq_0.c0 as c3
from 
  (select  
        ref_0.name as c0
      from 
        main.t0 as ref_0
      where (ref_0.name is not NULL) 
        and (ref_0.id is not NULL)) as subq_0
where 0
limit 90;
