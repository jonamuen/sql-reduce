select  
  subq_0.c4 as c0, 
  case when 0 then subq_0.c4 else subq_0.c4 end
     as c1, 
  subq_0.c3 as c2, 
  subq_0.c2 as c3, 
  subq_0.c4 as c4, 
  case when subq_0.c3 is not NULL then subq_0.c3 else subq_0.c3 end
     as c5, 
  (select id from main.t0 limit 1 offset 3)
     as c6, 
  (select id from main.t0 limit 1 offset 3)
     as c7
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1, 
        ref_0.name as c2, 
        ref_0.id as c3, 
        ref_0.name as c4
      from 
        main.t0 as ref_0
      where ref_0.name is not NULL
      limit 98) as subq_0
where (select name from main.t0 limit 1 offset 4)
     is not NULL
limit 128;
