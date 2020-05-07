select  
  subq_0.c6 as c0, 
  subq_0.c13 as c1, 
  subq_0.c10 as c2, 
  subq_0.c2 as c3, 
  cast(nullif(cast(coalesce(subq_0.c4,
      subq_0.c4) as VARCHAR(16)),
    subq_0.c12) as VARCHAR(16)) as c4, 
  subq_0.c1 as c5, 
  subq_0.c8 as c6
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1, 
        ref_0.id as c2, 
        ref_0.id as c3, 
        ref_0.name as c4, 
        ref_0.id as c5, 
        cast(coalesce(ref_0.id,
          ref_0.id) as INT) as c6, 
        ref_0.name as c7, 
        ref_0.id as c8, 
        (select id from main.t0 limit 1 offset 4)
           as c9, 
        case when ref_0.id is not NULL then ref_0.id else ref_0.id end
           as c10, 
        ref_0.id as c11, 
        ref_0.name as c12, 
        ref_0.name as c13, 
        ref_0.name as c14, 
        ref_0.id as c15, 
        ref_0.name as c16, 
        ref_0.id as c17
      from 
        main.t0 as ref_0
      where (ref_0.id is NULL) 
        or (ref_0.name is NULL)) as subq_0
where 0
limit 68;
