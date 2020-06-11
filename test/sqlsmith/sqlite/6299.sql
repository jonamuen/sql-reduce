select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.id as c3, 
  (select id from main.t0 limit 1 offset 6)
     as c4, 
  ref_0.name as c5, 
  ref_0.name as c6, 
  ref_0.name as c7, 
  ref_0.name as c8, 
  ref_0.id as c9, 
  ref_0.name as c10, 
  ref_0.id as c11, 
  ref_0.name as c12, 
  ref_0.name as c13, 
  ref_0.name as c14
from 
  main.t0 as ref_0
where ref_0.name is not NULL
limit 96;
