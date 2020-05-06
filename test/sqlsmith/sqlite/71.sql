select  
  (select name from main.t0 limit 1 offset 3)
     as c0, 
  36 as c1, 
  ref_0.id as c2, 
  ref_0.id as c3, 
  ref_0.name as c4, 
  ref_0.name as c5
from 
  main.t0 as ref_0
where ref_0.name is not NULL;
