select  
  subq_0.c2 as c0, 
  subq_0.c0 as c1, 
  subq_0.c1 as c2, 
  cast(coalesce(subq_0.c2,
    subq_0.c2) as VARCHAR(16)) as c3, 
  subq_0.c2 as c4, 
  subq_0.c2 as c5, 
  subq_0.c1 as c6
from 
  (select  
        ref_0.name as c0, 
        (select name from main.t0 limit 1 offset 1)
           as c1, 
        ref_0.name as c2
      from 
        main.t0 as ref_0
      where 0) as subq_0
where subq_0.c2 is not NULL
limit 90;
