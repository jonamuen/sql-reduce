select  
  ref_0.id as c0, 
  (select name from main.t0 limit 1 offset 6)
     as c1, 
  ref_0.id as c2, 
  ref_0.id as c3, 
  ref_0.name as c4, 
  ref_0.name as c5, 
  case when ref_0.name is not NULL then ref_0.name else ref_0.name end
     as c6
from 
  main.t0 as ref_0
where (0) 
  and (ref_0.name is NULL);
