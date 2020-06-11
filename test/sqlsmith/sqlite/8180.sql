select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  case when ref_0.id is NULL then ref_0.id else ref_0.id end
     as c2, 
  ref_0.id as c3
from 
  main.t0 as ref_0
where (ref_0.name is not NULL) 
  and (ref_0.id is NULL)
limit 111;
