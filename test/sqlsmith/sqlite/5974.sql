select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  case when (ref_0.id is not NULL) 
      or (0) then ref_0.name else ref_0.name end
     as c4
from 
  main.t0 as ref_0
where (select name from main.t0 limit 1 offset 2)
     is NULL
limit 58;
