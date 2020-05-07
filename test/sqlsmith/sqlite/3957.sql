select  
  ref_0.id as c0, 
  case when (ref_0.id is not NULL) 
      or (ref_0.name is not NULL) then ref_0.id else ref_0.id end
     as c1, 
  ref_0.id as c2
from 
  main.t0 as ref_0
where ref_0.id is NULL
limit 60;
