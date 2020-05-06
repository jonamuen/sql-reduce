select  
  subq_0.c9 as c0, 
  subq_0.c3 as c1
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1, 
        ref_0.name as c2, 
        ref_0.name as c3, 
        (select name from main.t0 limit 1 offset 3)
           as c4, 
        ref_0.name as c5, 
        ref_0.name as c6, 
        ref_0.name as c7, 
        cast(nullif(ref_0.id,
          ref_0.id) as INT) as c8, 
        ref_0.id as c9, 
        ref_0.name as c10, 
        ref_0.name as c11, 
        ref_0.id as c12, 
        ref_0.id as c13, 
        ref_0.name as c14
      from 
        main.t0 as ref_0
      where (ref_0.id is not NULL) 
        and (((ref_0.name is not NULL) 
            or (ref_0.name is NULL)) 
          and (ref_0.name is not NULL))
      limit 108) as subq_0
where (0) 
  or (subq_0.c2 is NULL)
limit 84;
