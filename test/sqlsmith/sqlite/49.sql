select  
  case when ref_0.id is not NULL then ref_0.name else ref_0.name end
     as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  (select id from main.t0 limit 1 offset 4)
     as c6, 
  ref_0.name as c7, 
  ref_0.name as c8, 
  ref_0.id as c9
from 
  main.t0 as ref_0
where 1
limit 107;
