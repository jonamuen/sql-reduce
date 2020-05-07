select  
  ref_0.id as c0, 
  42 as c1, 
  ref_0.name as c2, 
  (select id from main.t0 limit 1 offset 1)
     as c3
from 
  main.t0 as ref_0
where ref_0.id is NULL
limit 74;
