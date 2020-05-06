select  
  subq_1.c0 as c0
from 
  (select  
        subq_0.c7 as c0
      from 
        (select  
              ref_0.name as c0, 
              ref_0.id as c1, 
              ref_0.id as c2, 
              (select name from main.t0 limit 1 offset 53)
                 as c3, 
              ref_0.name as c4, 
              ref_0.name as c5, 
              ref_0.id as c6, 
              ref_0.id as c7, 
              ref_0.id as c8
            from 
              main.t0 as ref_0
            where ref_0.id is not NULL
            limit 162) as subq_0
      where EXISTS (
        select  
            (select name from main.t0 limit 1 offset 5)
               as c0, 
            subq_0.c6 as c1, 
            subq_0.c4 as c2, 
            ref_1.name as c3, 
            63 as c4, 
            ref_1.id as c5, 
            subq_0.c0 as c6, 
            ref_1.name as c7, 
            subq_0.c2 as c8, 
            ref_1.name as c9
          from 
            main.t0 as ref_1
          where (0) 
            and (ref_1.name is NULL))
      limit 126) as subq_1
where 3 is NULL
limit 73;
