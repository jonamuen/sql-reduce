select  
  subq_0.c2 as c0, 
  subq_0.c2 as c1
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1, 
        ref_0.id as c2, 
        (select id from main.t0 limit 1 offset 5)
           as c3, 
        ref_0.id as c4, 
        ref_0.name as c5, 
        ref_0.id as c6, 
        ref_0.id as c7, 
        16 as c8, 
        ref_0.name as c9, 
        ref_0.id as c10, 
        ref_0.name as c11, 
        ref_0.id as c12
      from 
        main.t0 as ref_0
      where ((ref_0.id is NULL) 
          and (EXISTS (
            select distinct 
                ref_1.id as c0, 
                (select id from main.t0 limit 1 offset 1)
                   as c1, 
                ref_0.name as c2
              from 
                main.t0 as ref_1
              where ref_0.id is not NULL
              limit 36))) 
        or (1)) as subq_0
where subq_0.c0 is NULL
limit 79;
