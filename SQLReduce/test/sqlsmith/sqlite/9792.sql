select  
  ref_0.name as c0, 
  (select id from main.t0 limit 1 offset 4)
     as c1, 
  ref_0.id as c2
from 
  main.t0 as ref_0
where 1;
