select  
  subq_0.c0 as c0, 
  subq_0.c0 as c1
from 
  (select  
        ref_0.id as c0
      from 
        main.t0 as ref_0
      where 0) as subq_0
where ((subq_0.c0 is not NULL) 
    or (subq_0.c0 is not NULL)) 
  or ((((subq_0.c0 is NULL) 
        and (subq_0.c0 is not NULL)) 
      or (34 is not NULL)) 
    or ((0) 
      or (EXISTS (
        select  
            subq_0.c0 as c0, 
            ref_1.id as c1, 
            ref_1.id as c2, 
            subq_0.c0 as c3, 
            ref_1.id as c4, 
            ref_1.name as c5, 
            ref_1.id as c6, 
            subq_0.c0 as c7
          from 
            main.t0 as ref_1
          where subq_0.c0 is not NULL
          limit 72))));
