select  
  ref_2.name as c0, 
  subq_0.c1 as c1, 
  93 as c2, 
  ref_2.id as c3, 
  ref_2.name as c4, 
  subq_0.c12 as c5, 
  subq_0.c8 as c6, 
  subq_0.c11 as c7, 
  ref_2.id as c8, 
  cast(coalesce(subq_0.c0,
    subq_0.c9) as VARCHAR(16)) as c9
from 
  (select  
          (select name from main.t0 limit 1 offset 84)
             as c0, 
          44 as c1, 
          ref_0.id as c2, 
          ref_0.id as c3, 
          12 as c4, 
          ref_0.name as c5, 
          ref_0.id as c6, 
          ref_0.id as c7, 
          ref_0.name as c8, 
          ref_0.name as c9, 
          ref_0.id as c10, 
          ref_0.id as c11, 
          ref_0.id as c12
        from 
          main.t0 as ref_0
        where EXISTS (
          select  
              ref_1.name as c0, 
              ref_1.name as c1, 
              ref_0.id as c2, 
              ref_1.id as c3, 
              ref_0.id as c4, 
              ref_0.id as c5, 
              98 as c6, 
              ref_1.name as c7, 
              ref_1.id as c8, 
              (select name from main.t0 limit 1 offset 6)
                 as c9, 
              ref_0.id as c10, 
              59 as c11, 
              ref_1.id as c12, 
              ref_0.id as c13, 
              61 as c14, 
              ref_0.id as c15
            from 
              main.t0 as ref_1
            where ref_1.name is NULL)
        limit 109) as subq_0
    inner join main.t0 as ref_2
    on (ref_2.id is NULL)
where 0
limit 133;
