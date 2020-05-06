select  
  subq_0.c2 as c0, 
  case when 0 then subq_0.c6 else subq_0.c6 end
     as c1
from 
  (select  
        ref_0.name as c0, 
        ref_0.id as c1, 
        ref_0.name as c2, 
        ref_0.name as c3, 
        ref_0.name as c4, 
        ref_0.name as c5, 
        ref_0.name as c6, 
        ref_0.name as c7, 
        18 as c8, 
        ref_0.id as c9, 
        ref_0.name as c10, 
        ref_0.id as c11
      from 
        main.t0 as ref_0
      where 0
      limit 33) as subq_0
where subq_0.c3 is NULL
limit 77;
