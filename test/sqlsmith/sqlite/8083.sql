select  
  subq_0.c0 as c0, 
  subq_0.c0 as c1
from 
  (select  
        ref_0.id as c0
      from 
        main.t0 as ref_0
      where EXISTS (
        select  
            ref_1.id as c0, 
            ref_1.name as c1, 
            (select id from main.t0 limit 1 offset 36)
               as c2, 
            ref_0.id as c3
          from 
            main.t0 as ref_1
          where ref_0.id is NULL)
      limit 97) as subq_0
where subq_0.c0 is not NULL
limit 97;
