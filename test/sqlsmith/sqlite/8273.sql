select  
  subq_1.c1 as c0
from 
  (select  
        subq_0.c0 as c0, 
        subq_0.c0 as c1, 
        subq_0.c0 as c2, 
        subq_0.c0 as c3, 
        subq_0.c0 as c4, 
        subq_0.c0 as c5, 
        subq_0.c0 as c6, 
        subq_0.c0 as c7, 
        subq_0.c0 as c8, 
        (select id from main.t0 limit 1 offset 2)
           as c9
      from 
        (select  
              ref_0.id as c0
            from 
              main.t0 as ref_0
            where (1) 
              or (1)
            limit 148) as subq_0
      where 1
      limit 25) as subq_1
where ((subq_1.c3 is not NULL) 
    or (((subq_1.c2 is NULL) 
        or ((0) 
          and (1))) 
      and (((subq_1.c5 is not NULL) 
          and (subq_1.c6 is NULL)) 
        and ((subq_1.c4 is not NULL) 
          or (subq_1.c6 is NULL))))) 
  and (subq_1.c8 is not NULL)
limit 123;
