select  
  subq_0.c3 as c0, 
  subq_0.c1 as c1, 
  subq_0.c2 as c2, 
  9 as c3, 
  subq_0.c1 as c4, 
  subq_0.c3 as c5, 
  subq_0.c3 as c6
from 
  (select  
        ref_0.name as c0, 
        1 as c1, 
        ref_0.id as c2, 
        ref_0.name as c3
      from 
        main.t0 as ref_0
      where 1
      limit 55) as subq_0
where cast(nullif((select name from main.t0 limit 1 offset 4)
      ,
    subq_0.c3) as VARCHAR(16)) is NULL;
