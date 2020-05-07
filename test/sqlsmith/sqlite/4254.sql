select  
  subq_0.c1 as c0
from 
  (select  
        ref_0.id as c0, 
        case when ref_0.name is NULL then ref_0.id else ref_0.id end
           as c1, 
        ref_0.name as c2, 
        ref_0.name as c3
      from 
        main.t0 as ref_0
      where ref_0.id is NULL
      limit 53) as subq_0
where subq_0.c1 is not NULL
limit 69;
