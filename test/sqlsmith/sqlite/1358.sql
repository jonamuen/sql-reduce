select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  (select id from main.t0 limit 1 offset 4)
     as c3, 
  ref_0.id as c4
from 
  main.t0 as ref_0
where ref_0.id is NULL
limit 121;
