select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  (select name from main.t0 limit 1 offset 48)
     as c3, 
  ref_0.name as c4
from 
  main.t0 as ref_0
where ref_0.name is NULL;
