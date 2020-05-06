select  
  subq_0.c1 as c0, 
  cast(nullif((select id from main.t0 limit 1 offset 83)
      ,
    subq_0.c2) as INT) as c1, 
  subq_0.c1 as c2, 
  subq_0.c2 as c3, 
  subq_0.c1 as c4
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1, 
        ref_0.id as c2
      from 
        main.t0 as ref_0
      where 0) as subq_0
where subq_0.c2 is not NULL
limit 167;
