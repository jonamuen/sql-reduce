select  
  subq_0.c0 as c0, 
  subq_0.c0 as c1
from 
  (select  
        (select name from main.t0 limit 1 offset 3)
           as c0, 
        ref_0.id as c1, 
        ref_0.id as c2
      from 
        main.t0 as ref_0
      where (EXISTS (
          select  
              ref_0.id as c0
            from 
              main.t0 as ref_1
            where ref_1.id is not NULL)) 
        and (((1) 
            and (((select name from main.t0 limit 1 offset 5)
                   is not NULL) 
              and ((ref_0.name is not NULL) 
                and (ref_0.id is not NULL)))) 
          or (1))
      limit 32) as subq_0
where 0
limit 165;
