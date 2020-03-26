select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  ref_0.name as c6, 
  ref_0.id as c7, 
  case when ref_0.name is NULL then ref_0.id else ref_0.id end
     as c8, 
  ref_0.name as c9, 
  ref_0.name as c10, 
  ref_0.id as c11, 
  ref_0.name as c12, 
  96 as c13, 
  ref_0.id as c14, 
  ref_0.name as c15, 
  (select name from main.t0 limit 1 offset 3)
     as c16, 
  ref_0.id as c17
from 
  main.t0 as ref_0
where ref_0.name is not NULL
limit 89;
