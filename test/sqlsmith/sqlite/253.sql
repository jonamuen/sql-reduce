select  
  subq_0.c2 as c0
from 
  (select  
        case when ref_0.id is not NULL then ref_0.id else ref_0.id end
           as c0, 
        ref_0.id as c1, 
        ref_0.id as c2, 
        ref_0.name as c3
      from 
        main.t0 as ref_0
      where 1) as subq_0
where 0
limit 77;
