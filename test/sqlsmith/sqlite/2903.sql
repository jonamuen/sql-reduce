select  
  subq_0.c2 as c0, 
  subq_0.c1 as c1
from 
  (select  
        ref_0.name as c0, 
        ref_0.id as c1, 
        ref_0.id as c2, 
        ref_0.id as c3, 
        ref_0.id as c4, 
        ref_0.name as c5, 
        ref_0.name as c6, 
        ref_0.id as c7, 
        ref_0.id as c8, 
        ref_0.id as c9, 
        ref_0.id as c10, 
        ref_0.id as c11, 
        ref_0.id as c12, 
        ref_0.id as c13
      from 
        main.t0 as ref_0
      where ((ref_0.id is NULL) 
          and (1)) 
        and (ref_0.name is not NULL)
      limit 93) as subq_0
where 1
limit 70;
