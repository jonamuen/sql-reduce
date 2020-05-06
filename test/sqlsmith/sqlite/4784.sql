select  
  subq_0.c0 as c0, 
  subq_0.c0 as c1, 
  subq_0.c1 as c2, 
  subq_0.c1 as c3, 
  subq_0.c1 as c4, 
  subq_0.c0 as c5, 
  subq_0.c0 as c6, 
  subq_0.c1 as c7, 
  subq_0.c0 as c8, 
  subq_0.c1 as c9, 
  subq_0.c1 as c10, 
  subq_0.c0 as c11, 
  subq_0.c0 as c12, 
  subq_0.c1 as c13, 
  subq_0.c1 as c14, 
  subq_0.c0 as c15
from 
  (select  
        55 as c0, 
        93 as c1
      from 
        main.t0 as ref_0
      where 0) as subq_0
where subq_0.c1 is not NULL
limit 52;
