select  
  ref_0.id as c0, 
  (select id from main.t0 limit 1 offset 4)
     as c1
from 
  main.t0 as ref_0
where (ref_0.name is not NULL) 
  or (1)
limit 75;
