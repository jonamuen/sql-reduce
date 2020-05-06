select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.id as c3, 
  (select id from main.t0 limit 1 offset 3)
     as c4, 
  (select name from main.t0 limit 1 offset 4)
     as c5, 
  ref_0.name as c6, 
  ref_0.name as c7
from 
  main.t0 as ref_0
where 1
limit 46;
