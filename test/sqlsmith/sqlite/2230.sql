select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  ref_0.id as c3
from 
  main.t0 as ref_0
where case when (ref_0.name is NULL) 
      and (1) then ref_0.name else ref_0.name end
     is NULL;
