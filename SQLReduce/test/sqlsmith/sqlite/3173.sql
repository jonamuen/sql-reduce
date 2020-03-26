select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  (select id from main.t0 limit 1 offset 51)
     as c3
from 
  main.t0 as ref_0
where 12 is NULL;
