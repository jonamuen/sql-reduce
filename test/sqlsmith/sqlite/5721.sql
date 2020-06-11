select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  60 as c2, 
  ref_0.name as c3, 
  (select name from main.t0 limit 1 offset 5)
     as c4
from 
  main.t0 as ref_0
where ref_0.id is not NULL
limit 25;
