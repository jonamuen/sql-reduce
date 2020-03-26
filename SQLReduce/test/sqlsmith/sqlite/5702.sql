select  
  (select name from main.t0 limit 1 offset 4)
     as c0, 
  subq_0.c0 as c1, 
  subq_0.c0 as c2, 
  subq_0.c0 as c3, 
  subq_0.c0 as c4, 
  subq_0.c0 as c5
from 
  (select  
        (select name from main.t0 limit 1 offset 6)
           as c0
      from 
        main.t0 as ref_0
      where ref_0.id is not NULL
      limit 32) as subq_0
where ((subq_0.c0 is NULL) 
    and ((((((subq_0.c0 is NULL) 
              or (subq_0.c0 is not NULL)) 
            or ((1) 
              and ((subq_0.c0 is NULL) 
                or (subq_0.c0 is NULL)))) 
          and (subq_0.c0 is not NULL)) 
        and ((0) 
          and (subq_0.c0 is NULL))) 
      or ((0) 
        or (subq_0.c0 is NULL)))) 
  and (subq_0.c0 is not NULL);
