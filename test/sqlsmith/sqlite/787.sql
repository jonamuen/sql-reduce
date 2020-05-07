select  
  subq_0.c0 as c0, 
  subq_0.c0 as c1, 
  subq_0.c0 as c2, 
  cast(coalesce(subq_0.c1,
    subq_0.c0) as VARCHAR(16)) as c3, 
  subq_0.c2 as c4, 
  subq_0.c1 as c5, 
  cast(coalesce(subq_0.c1,
    subq_0.c1) as VARCHAR(16)) as c6, 
  subq_0.c2 as c7, 
  cast(nullif(subq_0.c1,
    cast(coalesce(subq_0.c0,
      subq_0.c1) as VARCHAR(16))) as VARCHAR(16)) as c8, 
  subq_0.c2 as c9, 
  subq_0.c2 as c10, 
  subq_0.c2 as c11, 
  subq_0.c1 as c12, 
  cast(nullif(subq_0.c0,
    subq_0.c1) as VARCHAR(16)) as c13, 
  subq_0.c2 as c14
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1, 
        ref_0.id as c2
      from 
        main.t0 as ref_0
      where (((1) 
            and ((ref_0.name is not NULL) 
              or (0))) 
          and (1)) 
        or (ref_0.name is not NULL)
      limit 150) as subq_0
where subq_0.c1 is not NULL
limit 14;
