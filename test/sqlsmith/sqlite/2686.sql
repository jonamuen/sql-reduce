select  
  subq_1.c0 as c0, 
  subq_1.c0 as c1, 
  subq_1.c0 as c2, 
  subq_1.c0 as c3, 
  subq_1.c0 as c4, 
  subq_1.c0 as c5, 
  subq_1.c0 as c6, 
  subq_1.c0 as c7, 
  subq_1.c0 as c8
from 
  (select  
        subq_0.c1 as c0
      from 
        (select  
              ref_0.name as c0, 
              ref_0.id as c1, 
              ref_0.name as c2
            from 
              main.t0 as ref_0
            where ((1) 
                or (0)) 
              and (0)
            limit 131) as subq_0
      where (subq_0.c0 is not NULL) 
        or (subq_0.c1 is not NULL)) as subq_1
where 0
limit 60;
