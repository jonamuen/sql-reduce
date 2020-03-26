select  
  (select name from main.t0 limit 1 offset 5)
     as c0, 
  ref_0.id as c1
from 
  main.t0 as ref_0
where (1) 
  and (((0) 
      or ((select name from main.t0 limit 1 offset 1)
           is NULL)) 
    and (ref_0.name is not NULL))
limit 77;
