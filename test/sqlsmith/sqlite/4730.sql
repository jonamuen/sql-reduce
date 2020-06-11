select  
  subq_0.c4 as c0, 
  subq_0.c6 as c1
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1, 
        ref_0.id as c2, 
        ref_0.name as c3, 
        ref_0.id as c4, 
        ref_0.name as c5, 
        ref_0.id as c6, 
        ref_0.id as c7, 
        ref_0.name as c8
      from 
        main.t0 as ref_0
      where 1
      limit 20) as subq_0
where subq_0.c8 is not NULL
limit 108;
