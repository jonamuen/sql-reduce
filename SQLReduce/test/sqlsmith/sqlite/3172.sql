select  
  subq_0.c0 as c0
from 
  (select  
        (select id from main.t0 limit 1 offset 6)
           as c0
      from 
        main.t0 as ref_0
      where ref_0.name is not NULL
      limit 118) as subq_0
where 0;
