select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  (select id from main.t0 limit 1 offset 5)
     as c2, 
  ref_0.name as c3
from 
  main.t0 as ref_0
where 1
limit 54;
