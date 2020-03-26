select  
  subq_0.c2 as c0, 
  subq_0.c2 as c1, 
  subq_0.c0 as c2, 
  subq_0.c6 as c3, 
  subq_0.c8 as c4, 
  (select name from main.t0 limit 1 offset 4)
     as c5, 
  subq_0.c2 as c6, 
  subq_0.c1 as c7
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1, 
        ref_0.name as c2, 
        46 as c3, 
        (select name from main.t0 limit 1 offset 2)
           as c4, 
        ref_0.id as c5, 
        ref_0.name as c6, 
        ref_0.id as c7, 
        ref_0.name as c8, 
        ref_0.name as c9, 
        case when 0 then ref_0.name else ref_0.name end
           as c10
      from 
        main.t0 as ref_0
      where ref_0.name is not NULL) as subq_0
where (subq_0.c7 is not NULL) 
  and (subq_0.c3 is not NULL)
limit 191;
