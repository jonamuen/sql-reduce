select  
  subq_1.c0 as c0, 
  90 as c1
from 
  (select  
        subq_0.c5 as c0, 
        subq_0.c1 as c1, 
        subq_0.c3 as c2, 
        subq_0.c2 as c3, 
        subq_0.c8 as c4, 
        (select id from main.t0 limit 1 offset 3)
           as c5, 
        subq_0.c10 as c6, 
        subq_0.c6 as c7
      from 
        (select  
              ref_0.id as c0, 
              44 as c1, 
              (select id from main.t0 limit 1 offset 3)
                 as c2, 
              ref_0.name as c3, 
              ref_0.name as c4, 
              ref_0.id as c5, 
              ref_0.name as c6, 
              ref_0.id as c7, 
              ref_0.name as c8, 
              ref_0.name as c9, 
              ref_0.id as c10
            from 
              main.t0 as ref_0
            where (ref_0.name is NULL) 
              and (0)) as subq_0
      where 1) as subq_1
where cast(nullif(subq_1.c2,
    subq_1.c4) as VARCHAR(16)) is not NULL
limit 130;
