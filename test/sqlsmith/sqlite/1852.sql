select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  ref_0.id as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  (select id from main.t0 limit 1 offset 6)
     as c5, 
  ref_0.name as c6
from 
  main.t0 as ref_0
where (0) 
  or (ref_0.id is not NULL);
