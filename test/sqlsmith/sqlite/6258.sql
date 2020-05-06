select  
  subq_0.c3 as c0, 
  subq_0.c4 as c1, 
  subq_0.c2 as c2, 
  subq_0.c0 as c3, 
  subq_0.c4 as c4
from 
  (select  
        ref_0.name as c0, 
        ref_0.id as c1, 
        ref_0.id as c2, 
        ref_0.id as c3, 
        cast(nullif(ref_0.name,
          ref_0.name) as VARCHAR(16)) as c4
      from 
        main.t0 as ref_0
      where ref_0.name is not NULL
      limit 48) as subq_0
where subq_0.c1 is not NULL
limit 73;
