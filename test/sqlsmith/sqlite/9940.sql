select  
  12 as c0, 
  subq_0.c10 as c1, 
  subq_0.c12 as c2, 
  subq_0.c6 as c3, 
  subq_0.c0 as c4, 
  62 as c5, 
  subq_0.c8 as c6
from 
  (select  
        ref_0.name as c0, 
        (select id from main.t0 limit 1 offset 95)
           as c1, 
        case when 0 then ref_0.id else ref_0.id end
           as c2, 
        ref_0.name as c3, 
        20 as c4, 
        (select name from main.t0 limit 1 offset 5)
           as c5, 
        ref_0.id as c6, 
        ref_0.id as c7, 
        47 as c8, 
        ref_0.name as c9, 
        ref_0.id as c10, 
        ref_0.id as c11, 
        ref_0.name as c12, 
        ref_0.name as c13, 
        (select id from main.t0 limit 1 offset 5)
           as c14, 
        ref_0.name as c15
      from 
        main.t0 as ref_0
      where (ref_0.name is not NULL) 
        or (ref_0.name is NULL)
      limit 40) as subq_0
where subq_0.c9 is not NULL
limit 30;
