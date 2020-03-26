select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  (select id from main.t0 limit 1 offset 43)
     as c6, 
  ref_0.id as c7, 
  ref_0.name as c8
from 
  main.t0 as ref_0
where 1
limit 111;
