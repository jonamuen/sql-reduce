select  
  72 as c0, 
  ref_0.id as c1, 
  (select id from main.t0 limit 1 offset 3)
     as c2, 
  (select name from main.t0 limit 1 offset 4)
     as c3, 
  ref_0.name as c4, 
  ref_0.name as c5, 
  ref_0.id as c6, 
  ref_0.name as c7
from 
  main.t0 as ref_0
where ref_0.id is not NULL;
