select  
  ref_0.name as c0
from 
  main.t0 as ref_0
where (ref_0.name is not NULL) 
  or ((ref_0.name is NULL) 
    and (EXISTS (
      select  
          ref_1.name as c0
        from 
          main.t0 as ref_1
        where 0)))
limit 125;
