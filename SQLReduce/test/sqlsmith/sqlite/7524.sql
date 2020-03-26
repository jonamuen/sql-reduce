select  
  subq_1.c10 as c0, 
  subq_0.c4 as c1
from 
  (select  
          ref_0.id as c0, 
          ref_0.name as c1, 
          ref_0.name as c2, 
          (select name from main.t0 limit 1 offset 4)
             as c3, 
          53 as c4, 
          ref_0.id as c5
        from 
          main.t0 as ref_0
        where ((ref_0.name is not NULL) 
            or (0)) 
          and ((ref_0.name is not NULL) 
            or (ref_0.name is NULL))
        limit 104) as subq_0
    inner join (select  
          ref_1.name as c0, 
          ref_1.id as c1, 
          ref_1.id as c2, 
          ref_1.name as c3, 
          ref_1.id as c4, 
          cast(nullif(ref_1.name,
            ref_1.name) as VARCHAR(16)) as c5, 
          ref_1.id as c6, 
          ref_1.name as c7, 
          ref_1.id as c8, 
          ref_1.id as c9, 
          ref_1.id as c10, 
          ref_1.id as c11, 
          ref_1.id as c12, 
          ref_1.id as c13
        from 
          main.t0 as ref_1
        where 1) as subq_1
    on (subq_1.c1 is NULL)
where subq_0.c3 is NULL
limit 75;
