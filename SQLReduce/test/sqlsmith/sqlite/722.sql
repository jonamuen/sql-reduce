select  
  subq_0.c0 as c0, 
  71 as c1
from 
  (select  
        60 as c0
      from 
        main.t0 as ref_0
      where ref_0.id is NULL) as subq_0
where (select id from main.t0 limit 1 offset 31)
     is not NULL;
