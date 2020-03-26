select  
  subq_0.c1 as c0, 
  case when subq_0.c0 is not NULL then subq_0.c0 else subq_0.c0 end
     as c1, 
  subq_0.c0 as c2, 
  subq_0.c0 as c3, 
  subq_0.c0 as c4, 
  subq_0.c1 as c5, 
  subq_0.c1 as c6, 
  subq_0.c0 as c7
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1
      from 
        main.t0 as ref_0
      where 1
      limit 89) as subq_0
where (select name from main.t0 limit 1 offset 99)
     is NULL;
