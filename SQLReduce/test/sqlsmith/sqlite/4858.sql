select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  ref_0.id as c2
from 
  main.t0 as ref_0
where (select name from main.t0 limit 1 offset 2)
     is NULL;
