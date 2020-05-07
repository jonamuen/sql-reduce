select  
  subq_1.c4 as c0, 
  subq_1.c2 as c1, 
  subq_1.c0 as c2, 
  subq_1.c2 as c3, 
  case when subq_1.c1 is NULL then subq_1.c0 else subq_1.c0 end
     as c4
from 
  (select  
        subq_0.c0 as c0, 
        subq_0.c0 as c1, 
        subq_0.c0 as c2, 
        subq_0.c1 as c3, 
        subq_0.c0 as c4, 
        subq_0.c1 as c5
      from 
        (select  
              ref_0.id as c0, 
              ref_0.id as c1
            from 
              main.t0 as ref_0
            where (ref_0.id is not NULL) 
              or (((0) 
                  or ((ref_0.id is NULL) 
                    and (1))) 
                and ((0) 
                  or (1)))
            limit 187) as subq_0
      where (subq_0.c0 is NULL) 
        and (1)
      limit 141) as subq_1
where (select name from main.t0 limit 1 offset 1)
     is not NULL;
