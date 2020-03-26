select  
  cast(coalesce(subq_0.c9,
    subq_0.c9) as VARCHAR(16)) as c0, 
  10 as c1, 
  subq_0.c1 as c2
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1, 
        ref_0.name as c2, 
        ref_0.id as c3, 
        ref_0.id as c4, 
        ref_0.id as c5, 
        (select name from main.t0 limit 1 offset 3)
           as c6, 
        ref_0.name as c7, 
        ref_0.name as c8, 
        cast(coalesce(ref_0.name,
          ref_0.name) as VARCHAR(16)) as c9, 
        ref_0.id as c10
      from 
        main.t0 as ref_0
          left join main.t0 as ref_1
          on (((ref_0.name is NULL) 
                and ((EXISTS (
                    select  
                        ref_2.name as c0, 
                        ref_2.id as c1, 
                        ref_2.id as c2
                      from 
                        main.t0 as ref_2
                      where 0)) 
                  and (0))) 
              and (0))
      where ref_0.name is NULL
      limit 99) as subq_0
where (0) 
  and ((subq_0.c5 is not NULL) 
    or (0))
limit 101;
