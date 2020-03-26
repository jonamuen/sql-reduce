select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  ref_0.id as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  ref_0.name as c6, 
  ref_0.name as c7, 
  ref_0.id as c8, 
  ref_0.name as c9, 
  (select id from main.t0 limit 1 offset 4)
     as c10, 
  ref_0.id as c11, 
  (select name from main.t0 limit 1 offset 32)
     as c12, 
  ref_0.id as c13
from 
  main.t0 as ref_0
where (select id from main.t0 limit 1 offset 3)
     is not NULL;
