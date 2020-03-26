select  
  cast(coalesce(subq_0.c2,
    subq_0.c0) as VARCHAR(16)) as c0
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1, 
        ref_0.name as c2, 
        ref_0.id as c3, 
        ref_0.id as c4, 
        ref_0.id as c5
      from 
        main.t0 as ref_0
      where ref_0.id is NULL
      limit 78) as subq_0
where subq_0.c3 is NULL
limit 103;
