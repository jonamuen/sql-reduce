select  
  (select name from main.t0 limit 1 offset 3)
     as c0, 
  ref_0.id as c1
from 
  main.t0 as ref_0
where 1
limit 162;
