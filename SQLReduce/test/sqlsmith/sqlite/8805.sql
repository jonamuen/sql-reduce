select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  ref_0.id as c2, 
  9 as c3, 
  ref_0.id as c4, 
  (select name from main.t0 limit 1 offset 1)
     as c5, 
  ref_0.name as c6, 
  ref_0.name as c7
from 
  main.t0 as ref_0
where 0;
