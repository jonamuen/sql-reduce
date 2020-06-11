select  
  subq_1.c5 as c0, 
  subq_1.c3 as c1, 
  subq_1.c4 as c2, 
  subq_1.c2 as c3, 
  subq_1.c1 as c4
from 
  (select  
        subq_0.c0 as c0, 
        subq_0.c0 as c1, 
        subq_0.c0 as c2, 
        subq_0.c0 as c3, 
        case when 0 then subq_0.c0 else subq_0.c0 end
           as c4, 
        subq_0.c0 as c5
      from 
        (select  
              ref_0.name as c0
            from 
              main.t0 as ref_0
            where ref_0.name is NULL
            limit 123) as subq_0
      where subq_0.c0 is not NULL
      limit 68) as subq_1
where subq_1.c2 is NULL
limit 122;
