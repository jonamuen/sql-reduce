select  
  subq_0.c11 as c0, 
  (select id from main.t0 limit 1 offset 4)
     as c1, 
  subq_0.c8 as c2
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1, 
        (select id from main.t0 limit 1 offset 4)
           as c2, 
        ref_0.name as c3, 
        ref_0.name as c4, 
        ref_0.id as c5, 
        ref_0.name as c6, 
        79 as c7, 
        ref_0.id as c8, 
        ref_0.name as c9, 
        ref_0.name as c10, 
        ref_0.name as c11
      from 
        main.t0 as ref_0
      where EXISTS (
        select  
            ref_0.id as c0, 
            ref_0.name as c1, 
            ref_1.id as c2, 
            (select name from main.t0 limit 1 offset 2)
               as c3
          from 
            main.t0 as ref_1
          where ref_1.name is not NULL
          limit 121)
      limit 122) as subq_0
where cast(coalesce(subq_0.c0,
    subq_0.c5) as INT) is not NULL;
