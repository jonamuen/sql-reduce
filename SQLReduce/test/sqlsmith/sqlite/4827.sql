select  
  subq_0.c3 as c0
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1, 
        ref_0.id as c2, 
        ref_0.name as c3, 
        71 as c4, 
        ref_0.id as c5, 
        ref_0.name as c6
      from 
        main.t0 as ref_0
      where (ref_0.id is NULL) 
        and (19 is NULL)
      limit 176) as subq_0
where subq_0.c1 is NULL
limit 100;
