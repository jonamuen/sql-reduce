select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  ref_0.id as c3, 
  case when (1) 
      and (ref_0.name is NULL) then ref_0.name else ref_0.name end
     as c4, 
  ref_0.id as c5, 
  ref_0.name as c6, 
  ref_0.id as c7, 
  ref_0.name as c8, 
  ref_0.id as c9
from 
  main.t0 as ref_0
where (1) 
  and (ref_0.name is NULL)
limit 95;
