select  
  subq_0.c4 as c0, 
  case when subq_0.c5 is not NULL then subq_0.c9 else subq_0.c9 end
     as c1, 
  subq_0.c0 as c2
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1, 
        ref_0.id as c2, 
        ref_0.id as c3, 
        ref_0.name as c4, 
        ref_0.id as c5, 
        ref_0.name as c6, 
        ref_0.id as c7, 
        ref_0.name as c8, 
        ref_0.id as c9
      from 
        main.t0 as ref_0
      where (0) 
        and (ref_0.name is NULL)) as subq_0
where 1
limit 83;
