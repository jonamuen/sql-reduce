select  
  ref_0.id as c0, 
  ref_0.name as c1
from 
  main.t0 as ref_0
where ((select id from main.t0 limit 1 offset 4)
       is NULL) 
  and (ref_0.id is not NULL)
limit 59;
