select  
  subq_0.c0 as c0
from 
  (select  
        ref_0.name as c0
      from 
        main.t0 as ref_0
      where ref_0.name is not NULL
      limit 19) as subq_0
where subq_0.c0 is NULL
limit 82;
