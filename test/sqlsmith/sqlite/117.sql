select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  (select name from main.t0 limit 1 offset 5)
     as c3, 
  ref_0.name as c4, 
  ref_0.name as c5, 
  case when ref_0.id is NULL then ref_0.id else ref_0.id end
     as c6, 
  ref_0.name as c7, 
  ref_0.id as c8, 
  ref_0.name as c9, 
  ref_0.id as c10
from 
  main.t0 as ref_0
where (select name from main.t0 limit 1 offset 3)
     is not NULL
limit 129;
