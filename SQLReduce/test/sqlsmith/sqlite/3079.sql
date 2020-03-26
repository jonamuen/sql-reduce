select  
  subq_1.c4 as c0, 
  subq_1.c5 as c1, 
  subq_1.c3 as c2, 
  subq_1.c2 as c3, 
  subq_1.c6 as c4, 
  subq_1.c6 as c5, 
  (select id from main.t0 limit 1 offset 2)
     as c6
from 
  (select  
        subq_0.c0 as c0, 
        subq_0.c3 as c1, 
        subq_0.c1 as c2, 
        subq_0.c3 as c3, 
        subq_0.c2 as c4, 
        subq_0.c1 as c5, 
        subq_0.c1 as c6, 
        subq_0.c1 as c7, 
        subq_0.c2 as c8, 
        subq_0.c2 as c9, 
        subq_0.c0 as c10, 
        (select id from main.t0 limit 1 offset 4)
           as c11, 
        subq_0.c2 as c12, 
        subq_0.c1 as c13, 
        case when 1 then subq_0.c0 else subq_0.c0 end
           as c14, 
        subq_0.c2 as c15
      from 
        (select  
              ref_0.id as c0, 
              ref_0.name as c1, 
              ref_0.id as c2, 
              ref_0.name as c3
            from 
              main.t0 as ref_0
            where (ref_0.name is NULL) 
              and (ref_0.name is NULL)) as subq_0
      where subq_0.c2 is not NULL
      limit 108) as subq_1
where subq_1.c7 is not NULL
limit 137;
