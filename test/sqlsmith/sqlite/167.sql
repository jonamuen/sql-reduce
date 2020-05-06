select  
  subq_0.c6 as c0, 
  subq_0.c5 as c1, 
  subq_0.c0 as c2, 
  subq_0.c1 as c3
from 
  (select  
        ref_0.name as c0, 
        ref_0.id as c1, 
        ref_0.name as c2, 
        ref_0.name as c3, 
        ref_0.id as c4, 
        ref_0.name as c5, 
        ref_0.name as c6
      from 
        main.t0 as ref_0
      where (1) 
        or (ref_0.id is NULL)
      limit 151) as subq_0
where subq_0.c4 is not NULL
limit 152;
