select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  (select name from main.t0 limit 1 offset 1)
     as c3, 
  ref_0.name as c4
from 
  main.t0 as ref_0
where (72 is NULL) 
  or (100 is NULL)
limit 43;
