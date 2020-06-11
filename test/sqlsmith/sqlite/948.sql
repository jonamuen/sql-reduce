select  
  ref_0.name as c0, 
  ref_0.name as c1
from 
  main.t0 as ref_0
where ((ref_0.name is NULL) 
    or (((0) 
        and (EXISTS (
          select  
              ref_0.id as c0, 
              ref_1.name as c1, 
              ref_0.id as c2, 
              ref_0.name as c3, 
              ref_0.name as c4, 
              ref_1.name as c5, 
              ref_0.name as c6
            from 
              main.t0 as ref_1
            where 0
            limit 15))) 
      and (0))) 
  or (ref_0.id is NULL);
