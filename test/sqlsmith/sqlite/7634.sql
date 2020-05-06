select  
  subq_0.c2 as c0, 
  subq_0.c0 as c1, 
  subq_0.c0 as c2, 
  subq_0.c2 as c3, 
  subq_0.c1 as c4, 
  subq_0.c1 as c5, 
  cast(coalesce(subq_0.c0,
    cast(nullif(subq_0.c0,
      subq_0.c0) as INT)) as INT) as c6, 
  subq_0.c2 as c7, 
  subq_0.c0 as c8
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1, 
        39 as c2
      from 
        main.t0 as ref_0
      where 1
      limit 167) as subq_0
where 1
limit 58;
