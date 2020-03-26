select  
  (select name from main.t0 limit 1 offset 4)
     as c0, 
  ref_0.id as c1, 
  ref_0.id as c2, 
  ref_0.id as c3
from 
  main.t0 as ref_0
where ref_0.name is not NULL
limit 141;
