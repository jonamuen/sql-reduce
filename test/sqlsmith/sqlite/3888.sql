select  
  ref_0.name as c0, 
  (select name from main.t0 limit 1 offset 1)
     as c1, 
  ref_0.id as c2
from 
  main.t0 as ref_0
where ((ref_0.name is not NULL) 
    and ((ref_0.name is NULL) 
      and ((1) 
        and (0)))) 
  or (ref_0.id is not NULL)
limit 105;
