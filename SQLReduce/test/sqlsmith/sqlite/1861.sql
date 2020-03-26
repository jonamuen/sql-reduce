select  
  subq_0.c12 as c0, 
  subq_0.c10 as c1, 
  83 as c2, 
  subq_0.c1 as c3, 
  subq_0.c7 as c4, 
  subq_0.c4 as c5, 
  case when subq_0.c2 is not NULL then subq_0.c4 else subq_0.c4 end
     as c6, 
  subq_0.c7 as c7
from 
  (select  
        ref_0.name as c0, 
        81 as c1, 
        ref_0.name as c2, 
        ref_0.id as c3, 
        ref_0.name as c4, 
        (select name from main.t0 limit 1 offset 2)
           as c5, 
        ref_0.name as c6, 
        ref_0.id as c7, 
        ref_0.id as c8, 
        ref_0.id as c9, 
        ref_0.id as c10, 
        ref_0.id as c11, 
        ref_0.id as c12, 
        ref_0.name as c13
      from 
        main.t0 as ref_0
      where (1) 
        or ((ref_0.id is not NULL) 
          and (1))
      limit 52) as subq_0
where subq_0.c11 is NULL;
