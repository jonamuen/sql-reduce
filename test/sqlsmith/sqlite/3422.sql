select  
  subq_0.c2 as c0, 
  62 as c1
from 
  (select  
        (select id from main.t0 limit 1 offset 6)
           as c0, 
        64 as c1, 
        ref_0.id as c2, 
        ref_0.id as c3, 
        ref_0.name as c4
      from 
        main.t0 as ref_0
      where (ref_0.id is not NULL) 
        and ((ref_0.id is NULL) 
          or ((ref_0.id is not NULL) 
            and (ref_0.name is NULL)))
      limit 167) as subq_0
where 54 is not NULL;
