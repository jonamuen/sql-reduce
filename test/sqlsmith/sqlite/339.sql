select  
  subq_0.c5 as c0
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1, 
        ref_0.id as c2, 
        ref_0.id as c3, 
        case when (ref_0.name is not NULL) 
            and ((select id from main.t0 limit 1 offset 4)
                 is NULL) then ref_0.id else ref_0.id end
           as c4, 
        ref_0.name as c5, 
        ref_0.name as c6, 
        case when ref_0.name is not NULL then ref_0.id else ref_0.id end
           as c7, 
        ref_0.name as c8, 
        ref_0.name as c9
      from 
        main.t0 as ref_0
      where 1
      limit 143) as subq_0
where 1
limit 96;
