select  
  subq_0.c0 as c0, 
  subq_0.c1 as c1, 
  subq_0.c0 as c2, 
  cast(nullif(subq_0.c0,
    subq_0.c0) as VARCHAR(16)) as c3, 
  subq_0.c0 as c4
from 
  (select  
        ref_0.name as c0, 
        ref_0.id as c1
      from 
        main.t0 as ref_0
      where 1) as subq_0
where ((1) 
    and (1)) 
  and (0)
limit 102;
