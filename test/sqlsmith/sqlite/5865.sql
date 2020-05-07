select  
  ref_0.id as c0, 
  case when (0) 
      or (ref_0.id is NULL) then ref_0.id else ref_0.id end
     as c1, 
  ref_0.name as c2, 
  ref_0.name as c3
from 
  main.t0 as ref_0
where ref_0.id is NULL
limit 27;
