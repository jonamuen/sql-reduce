select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.id as c3, 
  ref_0.name as c4, 
  ref_0.id as c5, 
  ref_0.id as c6, 
  (select name from main.t0 limit 1 offset 3)
     as c7, 
  ref_0.id as c8, 
  ref_0.name as c9
from 
  main.t0 as ref_0
where ref_0.id is NULL;
