select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  case when (ref_0.id is not NULL) 
      and (ref_0.id is not NULL) then ref_0.name else ref_0.name end
     as c3, 
  (select id from main.t0 limit 1 offset 1)
     as c4
from 
  main.t0 as ref_0
where 0
limit 54;
