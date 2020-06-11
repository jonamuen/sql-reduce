select  
  subq_0.c2 as c0, 
  subq_0.c2 as c1, 
  cast(coalesce(subq_0.c2,
    subq_0.c3) as VARCHAR(16)) as c2, 
  subq_0.c0 as c3, 
  subq_0.c1 as c4, 
  subq_0.c5 as c5, 
  (select id from main.t0 limit 1 offset 6)
     as c6
from 
  (select  
        (select name from main.t0 limit 1 offset 5)
           as c0, 
        ref_0.name as c1, 
        ref_0.name as c2, 
        ref_0.name as c3, 
        ref_0.name as c4, 
        ref_0.name as c5
      from 
        main.t0 as ref_0
      where ((1) 
          or (0)) 
        and (1)
      limit 64) as subq_0
where 0
limit 114;
