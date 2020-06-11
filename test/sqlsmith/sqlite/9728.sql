select  
  (select id from main.t0 limit 1 offset 4)
     as c0, 
  subq_0.c1 as c1
from 
  (select  
        ref_0.name as c0, 
        ref_0.id as c1
      from 
        main.t0 as ref_0
      where ((ref_0.id is not NULL) 
          and (ref_0.name is NULL)) 
        or (1)
      limit 101) as subq_0
where 1
limit 137;
