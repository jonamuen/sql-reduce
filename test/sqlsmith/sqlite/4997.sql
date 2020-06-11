select  
  subq_0.c7 as c0, 
  subq_0.c3 as c1
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1, 
        ref_0.id as c2, 
        ref_0.name as c3, 
        ref_0.name as c4, 
        ref_0.name as c5, 
        ref_0.id as c6, 
        ref_0.id as c7, 
        ref_0.id as c8, 
        ref_0.name as c9, 
        ref_0.name as c10
      from 
        main.t0 as ref_0
      where (1) 
        or (ref_0.name is NULL)
      limit 97) as subq_0
where case when (1) 
      and (subq_0.c6 is NULL) then subq_0.c0 else subq_0.c0 end
     is NULL;
