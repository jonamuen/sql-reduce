select  
  subq_1.c0 as c0, 
  subq_1.c0 as c1
from 
  (select  
        subq_0.c5 as c0, 
        subq_0.c7 as c1
      from 
        (select  
              2 as c0, 
              ref_0.name as c1, 
              ref_0.id as c2, 
              ref_0.name as c3, 
              ref_0.id as c4, 
              ref_0.id as c5, 
              ref_0.id as c6, 
              ref_0.id as c7, 
              ref_0.name as c8
            from 
              main.t0 as ref_0
            where 1
            limit 103) as subq_0
      where (subq_0.c4 is NULL) 
        and (0)
      limit 94) as subq_1
where (case when 0 then subq_1.c0 else subq_1.c0 end
       is not NULL) 
  and (1);
