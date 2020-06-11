select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  (select name from main.t0 limit 1 offset 2)
     as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  ref_0.id as c6, 
  ref_0.name as c7, 
  ref_0.name as c8
from 
  main.t0 as ref_0
where ref_0.id is not NULL
limit 173;
