select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  (select id from main.t0 limit 1 offset 6)
     as c2, 
  ref_0.name as c3, 
  ref_0.id as c4
from 
  main.t0 as ref_0
where 0;
