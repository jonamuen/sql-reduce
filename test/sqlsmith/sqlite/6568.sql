select  
  subq_1.c2 as c0
from 
  (select  
        subq_0.c1 as c0, 
        subq_0.c0 as c1, 
        subq_0.c0 as c2
      from 
        (select  
              54 as c0, 
              (select id from main.t0 limit 1 offset 1)
                 as c1
            from 
              main.t0 as ref_0
            where EXISTS (
              select  
                  ref_1.id as c0
                from 
                  main.t0 as ref_1
                where ref_1.name is NULL
                limit 112)
            limit 102) as subq_0
      where subq_0.c0 is not NULL
      limit 141) as subq_1
where (EXISTS (
    select  
        ref_2.id as c0, 
        subq_1.c1 as c1, 
        ref_2.name as c2, 
        subq_1.c0 as c3, 
        case when 1 then subq_1.c1 else subq_1.c1 end
           as c4
      from 
        main.t0 as ref_2
      where 1
      limit 90)) 
  or (subq_1.c1 is not NULL);
