select  
  subq_1.c3 as c0
from 
  (select  
          (select name from main.t0 limit 1 offset 2)
             as c0, 
          ref_0.name as c1, 
          (select name from main.t0 limit 1 offset 1)
             as c2, 
          ref_0.id as c3, 
          ref_0.id as c4, 
          ref_0.id as c5, 
          ref_0.id as c6, 
          ref_0.id as c7, 
          ref_0.id as c8, 
          (select id from main.t0 limit 1 offset 1)
             as c9, 
          ref_0.name as c10, 
          ref_0.id as c11, 
          ref_0.id as c12
        from 
          main.t0 as ref_0
        where (0) 
          and (ref_0.name is NULL)
        limit 51) as subq_0
    inner join (select  
          ref_1.id as c0, 
          ref_1.name as c1, 
          ref_1.id as c2, 
          ref_1.id as c3
        from 
          main.t0 as ref_1
        where ref_1.id is NULL
        limit 133) as subq_1
    on (1)
where (subq_1.c0 is not NULL) 
  or (0);
