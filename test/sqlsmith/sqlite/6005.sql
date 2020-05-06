select  
  subq_0.c5 as c0
from 
  (select  
        ref_0.name as c0, 
        ref_0.id as c1, 
        ref_0.id as c2, 
        (select name from main.t0 limit 1 offset 4)
           as c3, 
        ref_0.name as c4, 
        ref_0.name as c5, 
        ref_0.id as c6, 
        ref_0.name as c7
      from 
        main.t0 as ref_0
      where ((select id from main.t0 limit 1 offset 6)
             is not NULL) 
        and (ref_0.id is not NULL)
      limit 90) as subq_0
where subq_0.c3 is NULL;
