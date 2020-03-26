select  
  subq_0.c0 as c0, 
  subq_0.c0 as c1
from 
  (select  
        ref_0.id as c0
      from 
        main.t0 as ref_0
      where 1
      limit 111) as subq_0
where EXISTS (
  select  
      subq_0.c0 as c0, 
      subq_0.c0 as c1
    from 
      main.t0 as ref_1
    where 0)
limit 107;
