select  
  subq_0.c3 as c0, 
  subq_0.c3 as c1, 
  subq_0.c2 as c2, 
  subq_0.c2 as c3, 
  subq_0.c2 as c4, 
  subq_0.c0 as c5, 
  (select id from main.t0 limit 1 offset 6)
     as c6, 
  subq_0.c1 as c7, 
  subq_0.c1 as c8
from 
  (select  
        ref_0.name as c0, 
        (select id from main.t0 limit 1 offset 5)
           as c1, 
        ref_0.id as c2, 
        case when ref_0.id is not NULL then ref_0.id else ref_0.id end
           as c3
      from 
        main.t0 as ref_0
      where 1
      limit 150) as subq_0
where (subq_0.c2 is not NULL) 
  and (1)
limit 18;
