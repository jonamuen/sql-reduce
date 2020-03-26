select  
  subq_0.c2 as c0
from 
  (select  
        89 as c0, 
        ref_0.id as c1, 
        ref_0.id as c2, 
        ref_0.id as c3, 
        ref_0.name as c4, 
        ref_0.name as c5
      from 
        main.t0 as ref_0
      where ((ref_0.id is not NULL) 
          and ((0) 
            or (ref_0.id is not NULL))) 
        and (1)
      limit 45) as subq_0
where 1
limit 159;
