select  
  subq_0.c0 as c0, 
  91 as c1, 
  subq_0.c0 as c2, 
  subq_0.c0 as c3, 
  case when 0 then subq_0.c0 else subq_0.c0 end
     as c4
from 
  (select  
        ref_0.name as c0
      from 
        main.t0 as ref_0
      where (ref_0.name is not NULL) 
        or (1)
      limit 112) as subq_0
where 1;
