select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  case when ref_0.name is not NULL then ref_0.name else ref_0.name end
     as c5, 
  ref_0.name as c6, 
  (select name from main.t0 limit 1 offset 80)
     as c7, 
  ref_0.name as c8
from 
  main.t0 as ref_0
where ref_0.name is not NULL;
