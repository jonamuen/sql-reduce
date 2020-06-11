select  
  4 as c0, 
  (select name from main.t0 limit 1 offset 3)
     as c1, 
  ref_0.id as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  ref_0.id as c6, 
  ref_0.name as c7, 
  ref_0.id as c8, 
  ref_0.name as c9, 
  ref_0.id as c10, 
  ref_0.id as c11, 
  ref_0.name as c12
from 
  main.t0 as ref_0
where ref_0.name is NULL
limit 65;
