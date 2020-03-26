select  
  subq_0.c3 as c0, 
  case when subq_0.c2 is NULL then subq_0.c1 else subq_0.c1 end
     as c1, 
  subq_0.c1 as c2
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1, 
        ref_0.name as c2, 
        ref_0.name as c3
      from 
        main.t0 as ref_0
      where (select id from main.t0 limit 1 offset 2)
           is not NULL
      limit 173) as subq_0
where subq_0.c2 is not NULL
limit 91;
