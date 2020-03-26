select  
  subq_0.c3 as c0, 
  subq_0.c2 as c1, 
  subq_0.c1 as c2, 
  subq_0.c1 as c3, 
  subq_0.c1 as c4, 
  subq_0.c3 as c5, 
  subq_0.c3 as c6, 
  subq_0.c3 as c7, 
  94 as c8, 
  subq_0.c1 as c9, 
  subq_0.c3 as c10
from 
  (select  
        56 as c0, 
        ref_1.id as c1, 
        (select name from main.t0 limit 1 offset 2)
           as c2, 
        ref_0.name as c3
      from 
        main.t0 as ref_0
          inner join main.t0 as ref_1
          on ((ref_1.name is not NULL) 
              and (ref_0.name is NULL))
      where ref_0.id is not NULL) as subq_0
where subq_0.c2 is NULL;
