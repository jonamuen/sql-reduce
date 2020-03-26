select  
  ref_0.id as c0, 
  case when 1 then ref_0.id else ref_0.id end
     as c1, 
  ref_0.id as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  ref_0.name as c5, 
  ref_0.id as c6
from 
  main.t0 as ref_0
where (1) 
  or (ref_0.name is not NULL);
