select  
  subq_0.c0 as c0, 
  subq_0.c0 as c1, 
  subq_0.c0 as c2, 
  subq_0.c0 as c3, 
  subq_0.c0 as c4, 
  subq_0.c0 as c5, 
  subq_0.c0 as c6, 
  subq_0.c0 as c7, 
  subq_0.c0 as c8, 
  subq_0.c0 as c9, 
  subq_0.c0 as c10
from 
  (select  
        91 as c0
      from 
        main.t0 as ref_0
      where ((ref_0.id is NULL) 
          and (ref_0.name is not NULL)) 
        or ((ref_0.id is not NULL) 
          or (ref_0.id is not NULL))
      limit 109) as subq_0
where subq_0.c0 is not NULL
limit 154;
