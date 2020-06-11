select  
  subq_0.c0 as c0, 
  subq_0.c0 as c1, 
  (select name from main.t0 limit 1 offset 4)
     as c2, 
  subq_0.c1 as c3, 
  90 as c4
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1
      from 
        main.t0 as ref_0
      where EXISTS (
        select  
            ref_0.name as c0, 
            ref_1.name as c1
          from 
            main.t0 as ref_1
          where ref_0.id is NULL
          limit 106)
      limit 143) as subq_0
where ((subq_0.c0 is NULL) 
    or (subq_0.c1 is not NULL)) 
  and ((0) 
    or ((subq_0.c0 is not NULL) 
      or (subq_0.c1 is not NULL)))
limit 102;
