select  
  (select name from main.t0 limit 1 offset 1)
     as c0, 
  ref_0.name as c1
from 
  main.t0 as ref_0
where 0
limit 115;
