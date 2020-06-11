select  
  subq_0.c3 as c0, 
  subq_0.c2 as c1, 
  cast(coalesce(subq_0.c4,
    subq_0.c3) as INT) as c2, 
  subq_0.c5 as c3, 
  subq_0.c4 as c4
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1, 
        ref_0.id as c2, 
        case when (select name from main.t0 limit 1 offset 2)
               is not NULL then ref_0.id else ref_0.id end
           as c3, 
        ref_0.id as c4, 
        ref_0.name as c5
      from 
        main.t0 as ref_0
      where (((1) 
            or (ref_0.id is NULL)) 
          or (ref_0.id is NULL)) 
        or (1)) as subq_0
where (select id from main.t0 limit 1 offset 3)
     is NULL;
