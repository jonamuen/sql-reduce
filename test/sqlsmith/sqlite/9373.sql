select  
  subq_0.c0 as c0, 
  subq_0.c0 as c1, 
  (select name from main.t0 limit 1 offset 2)
     as c2
from 
  (select  
        ref_0.name as c0
      from 
        main.t0 as ref_0
      where ref_0.name is not NULL) as subq_0
where (case when 94 is NULL then subq_0.c0 else subq_0.c0 end
       is not NULL) 
  or (subq_0.c0 is NULL);
