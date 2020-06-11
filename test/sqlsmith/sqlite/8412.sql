select  
  subq_1.c1 as c0
from 
  (select  
        subq_0.c6 as c0, 
        subq_0.c8 as c1, 
        subq_0.c9 as c2, 
        subq_0.c4 as c3
      from 
        (select  
              ref_0.name as c0, 
              30 as c1, 
              (select name from main.t0 limit 1 offset 4)
                 as c2, 
              ref_0.id as c3, 
              ref_0.name as c4, 
              ref_0.name as c5, 
              ref_0.id as c6, 
              ref_0.name as c7, 
              ref_0.name as c8, 
              ref_0.id as c9
            from 
              main.t0 as ref_0
            where 0) as subq_0
      where ((0) 
          or ((1) 
            and (subq_0.c0 is NULL))) 
        or (subq_0.c2 is NULL)
      limit 124) as subq_1
where subq_1.c2 is NULL;
