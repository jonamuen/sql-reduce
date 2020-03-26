select  
  subq_0.c4 as c0, 
  (select name from main.t0 limit 1 offset 2)
     as c1, 
  subq_0.c1 as c2
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1, 
        (select id from main.t0 limit 1 offset 4)
           as c2, 
        ref_0.name as c3, 
        ref_0.name as c4, 
        ref_0.id as c5, 
        ref_0.id as c6, 
        ref_0.name as c7
      from 
        main.t0 as ref_0
      where (select id from main.t0 limit 1 offset 3)
           is not NULL) as subq_0
where subq_0.c7 is not NULL
limit 58;
