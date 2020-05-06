select  
  subq_0.c2 as c0, 
  subq_0.c5 as c1, 
  subq_0.c0 as c2, 
  subq_0.c12 as c3
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1, 
        ref_0.name as c2, 
        (select id from main.t0 limit 1 offset 2)
           as c3, 
        ref_0.id as c4, 
        ref_0.name as c5, 
        ref_0.name as c6, 
        ref_0.name as c7, 
        ref_0.name as c8, 
        ref_0.id as c9, 
        ref_0.name as c10, 
        ref_0.id as c11, 
        ref_0.name as c12, 
        ref_0.id as c13, 
        ref_0.id as c14
      from 
        main.t0 as ref_0
      where 0
      limit 88) as subq_0
where ((subq_0.c7 is NULL) 
    or (((((1) 
            or (1)) 
          and ((0) 
            or ((1) 
              and (((subq_0.c9 is not NULL) 
                  or ((subq_0.c5 is not NULL) 
                    and (0))) 
                or (0))))) 
        and ((1) 
          and (((1) 
              or (1)) 
            or (1)))) 
      and (0))) 
  or (subq_0.c5 is NULL)
limit 49;
