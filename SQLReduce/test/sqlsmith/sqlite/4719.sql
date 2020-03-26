select  
  subq_1.c7 as c0, 
  subq_1.c2 as c1, 
  subq_1.c9 as c2
from 
  (select  
        subq_0.c3 as c0, 
        (select name from main.t0 limit 1 offset 2)
           as c1, 
        case when 1 then subq_0.c3 else subq_0.c3 end
           as c2, 
        subq_0.c0 as c3, 
        subq_0.c2 as c4, 
        (select name from main.t0 limit 1 offset 1)
           as c5, 
        subq_0.c2 as c6, 
        subq_0.c3 as c7, 
        subq_0.c2 as c8, 
        subq_0.c0 as c9
      from 
        (select  
              ref_0.name as c0, 
              95 as c1, 
              ref_0.name as c2, 
              27 as c3
            from 
              main.t0 as ref_0
            where 0
            limit 119) as subq_0
      where (subq_0.c3 is NULL) 
        and ((1) 
          or (1))) as subq_1
where subq_1.c4 is NULL
limit 152;
