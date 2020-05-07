select  
  subq_0.c0 as c0
from 
  (select  
        ref_0.name as c0, 
        ref_0.id as c1, 
        ref_0.id as c2, 
        ref_0.id as c3, 
        ref_0.id as c4
      from 
        main.t0 as ref_0
      where ref_0.name is NULL
      limit 149) as subq_0
where 0
limit 92;
