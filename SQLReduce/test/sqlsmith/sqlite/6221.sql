select  
  ref_0.name as c0, 
  ref_0.id as c1
from 
  main.t0 as ref_0
where (EXISTS (
    select  
        ref_0.id as c0
      from 
        (select  
              ref_0.name as c0, 
              ref_1.id as c1, 
              ref_1.name as c2, 
              ref_1.id as c3, 
              ref_1.name as c4, 
              ref_0.id as c5
            from 
              main.t0 as ref_1
            where (ref_1.name is not NULL) 
              and (1)
            limit 151) as subq_0
      where (subq_0.c1 is NULL) 
        or (1)
      limit 51)) 
  or ((ref_0.name is not NULL) 
    and (((ref_0.name is NULL) 
        or (ref_0.id is NULL)) 
      and (ref_0.name is not NULL)))
limit 84;
