select  
  ref_0.id as c0, 
  73 as c1, 
  45 as c2, 
  ref_0.name as c3, 
  ref_0.name as c4, 
  (select name from main.t0 limit 1 offset 6)
     as c5, 
  ref_0.id as c6
from 
  main.t0 as ref_0
where ref_0.name is not NULL
limit 18;
