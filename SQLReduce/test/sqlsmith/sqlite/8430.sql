select  
  subq_0.c2 as c0, 
  subq_0.c1 as c1, 
  subq_0.c0 as c2, 
  subq_0.c1 as c3, 
  subq_0.c6 as c4
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1, 
        ref_0.id as c2, 
        ref_1.id as c3, 
        cast(coalesce(ref_0.name,
          ref_1.name) as VARCHAR(16)) as c4, 
        ref_1.name as c5, 
        ref_0.id as c6
      from 
        main.t0 as ref_0
          inner join main.t0 as ref_1
          on (0)
      where 0
      limit 98) as subq_0
where subq_0.c2 is NULL;
