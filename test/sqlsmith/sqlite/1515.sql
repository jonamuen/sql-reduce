select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.id as c3, 
  ref_0.name as c4, 
  ref_0.name as c5, 
  ref_0.id as c6, 
  ref_0.id as c7, 
  ref_0.name as c8
from 
  main.t0 as ref_0
where (ref_0.name is NULL) 
  or (ref_0.name is not NULL)
limit 38;
