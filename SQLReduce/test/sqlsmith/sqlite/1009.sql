select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  ref_0.id as c2, 
  69 as c3, 
  (select id from main.t0 limit 1 offset 1)
     as c4, 
  ref_0.id as c5, 
  ref_0.name as c6, 
  ref_0.name as c7
from 
  main.t0 as ref_0
where (0) 
  and (86 is NULL);
