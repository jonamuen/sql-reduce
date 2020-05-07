select  
  subq_0.c3 as c0, 
  subq_0.c4 as c1, 
  case when 1 then subq_0.c6 else subq_0.c6 end
     as c2
from 
  (select  
        ref_0.name as c0, 
        ref_0.id as c1, 
        ref_0.name as c2, 
        ref_0.name as c3, 
        ref_0.id as c4, 
        ref_0.name as c5, 
        ref_0.id as c6, 
        ref_0.id as c7
      from 
        main.t0 as ref_0
      where ref_0.id is not NULL
      limit 114) as subq_0
where subq_0.c1 is NULL;
