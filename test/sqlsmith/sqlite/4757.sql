select  
  subq_0.c1 as c0, 
  subq_0.c0 as c1, 
  subq_0.c0 as c2, 
  subq_0.c1 as c3, 
  subq_0.c0 as c4, 
  (select id from main.t0 limit 1 offset 6)
     as c5, 
  subq_0.c0 as c6, 
  subq_0.c1 as c7, 
  subq_0.c0 as c8, 
  subq_0.c1 as c9, 
  subq_0.c0 as c10, 
  subq_0.c0 as c11, 
  subq_0.c0 as c12
from 
  (select  
        (select name from main.t0 limit 1 offset 6)
           as c0, 
        ref_0.id as c1
      from 
        main.t0 as ref_0
          left join main.t0 as ref_1
          on (ref_1.name is not NULL)
      where (0) 
        and (ref_0.name is NULL)
      limit 67) as subq_0
where (EXISTS (
    select  
        subq_0.c1 as c0, 
        ref_2.id as c1, 
        subq_0.c0 as c2, 
        subq_0.c0 as c3, 
        subq_0.c1 as c4, 
        subq_0.c0 as c5, 
        subq_0.c0 as c6, 
        ref_2.id as c7, 
        subq_0.c0 as c8, 
        subq_0.c1 as c9, 
        subq_0.c0 as c10, 
        ref_2.name as c11, 
        subq_0.c1 as c12
      from 
        main.t0 as ref_2
      where subq_0.c1 is not NULL
      limit 23)) 
  or (subq_0.c0 is not NULL)
limit 141;
