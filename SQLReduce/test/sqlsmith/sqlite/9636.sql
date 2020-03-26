select  
  subq_1.c1 as c0, 
  (select id from main.t0 limit 1 offset 4)
     as c1
from 
  (select  
        (select id from main.t0 limit 1 offset 1)
           as c0, 
        case when 1 then subq_0.c0 else subq_0.c0 end
           as c1, 
        subq_0.c3 as c2
      from 
        (select  
              ref_0.id as c0, 
              (select name from main.t0 limit 1 offset 1)
                 as c1, 
              ref_0.id as c2, 
              ref_0.id as c3, 
              8 as c4, 
              ref_0.id as c5, 
              32 as c6, 
              ref_0.id as c7, 
              ref_0.name as c8, 
              ref_0.name as c9, 
              ref_0.name as c10, 
              ref_0.name as c11, 
              ref_0.id as c12
            from 
              main.t0 as ref_0
            where EXISTS (
              select  
                  ref_1.id as c0, 
                  ref_1.name as c1, 
                  ref_0.id as c2
                from 
                  main.t0 as ref_1
                where (0) 
                  and (0))
            limit 179) as subq_0
      where (1) 
        and ((1) 
          and (subq_0.c6 is NULL))) as subq_1
where 0
limit 103;
