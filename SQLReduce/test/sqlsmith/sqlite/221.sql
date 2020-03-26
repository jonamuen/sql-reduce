select  
  ref_0.name as c0, 
  case when 0 then ref_0.id else ref_0.id end
     as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  ref_0.name as c4, 
  ref_0.id as c5, 
  ref_0.name as c6, 
  97 as c7
from 
  main.t0 as ref_0
where (ref_0.id is not NULL) 
  or (0)
limit 150;
