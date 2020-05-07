select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  ref_0.name as c4, 
  ref_0.name as c5, 
  (select id from main.t0 limit 1 offset 1)
     as c6, 
  10 as c7, 
  ref_0.id as c8, 
  ref_0.id as c9, 
  ref_0.name as c10, 
  80 as c11
from 
  main.t0 as ref_0
where ref_0.id is not NULL
limit 67;
