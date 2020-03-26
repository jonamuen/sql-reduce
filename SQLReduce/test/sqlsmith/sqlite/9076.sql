select  
  subq_0.c4 as c0, 
  subq_0.c1 as c1
from 
  (select  
        (select name from main.t0 limit 1 offset 4)
           as c0, 
        ref_0.id as c1, 
        case when ref_0.name is NULL then ref_0.name else ref_0.name end
           as c2, 
        ref_0.id as c3, 
        ref_0.id as c4
      from 
        main.t0 as ref_0
      where 0) as subq_0
where 53 is not NULL;
