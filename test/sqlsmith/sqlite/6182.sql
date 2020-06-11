select  
  subq_0.c4 as c0, 
  case when 1 then subq_0.c0 else subq_0.c0 end
     as c1, 
  subq_0.c1 as c2, 
  subq_0.c2 as c3, 
  (select id from main.t0 limit 1 offset 4)
     as c4, 
  subq_0.c1 as c5, 
  subq_0.c3 as c6, 
  subq_0.c1 as c7, 
  subq_0.c4 as c8, 
  cast(nullif(subq_0.c4,
    subq_0.c4) as VARCHAR(16)) as c9, 
  (select id from main.t0 limit 1 offset 3)
     as c10, 
  (select id from main.t0 limit 1 offset 5)
     as c11, 
  subq_0.c1 as c12, 
  (select name from main.t0 limit 1 offset 2)
     as c13
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1, 
        ref_0.id as c2, 
        ref_0.name as c3, 
        ref_0.name as c4
      from 
        main.t0 as ref_0
      where 1
      limit 82) as subq_0
where 0
limit 94;
