select  
  ref_0.name as c0, 
  (select id from main.t0 limit 1 offset 5)
     as c1
from 
  main.t0 as ref_0
where ref_0.id is not NULL
limit 98;
