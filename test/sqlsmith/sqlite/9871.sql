select  
  90 as c0
from 
  (select  
        subq_0.c3 as c0, 
        subq_0.c2 as c1, 
        subq_0.c2 as c2, 
        88 as c3, 
        subq_0.c1 as c4, 
        subq_0.c0 as c5, 
        subq_0.c1 as c6, 
        subq_0.c3 as c7, 
        subq_0.c0 as c8, 
        subq_0.c1 as c9, 
        subq_0.c0 as c10, 
        subq_0.c0 as c11, 
        subq_0.c1 as c12
      from 
        (select  
              ref_0.name as c0, 
              ref_0.name as c1, 
              ref_0.name as c2, 
              ref_0.name as c3
            from 
              main.t0 as ref_0
            where ref_0.id is not NULL) as subq_0
      where ((1) 
          or (1)) 
        or ((subq_0.c0 is NULL) 
          or ((1) 
            or (EXISTS (
              select  
                  ref_1.id as c0, 
                  ref_1.id as c1
                from 
                  main.t0 as ref_1
                where 0
                limit 40))))) as subq_1
where (subq_1.c11 is not NULL) 
  and (1);
