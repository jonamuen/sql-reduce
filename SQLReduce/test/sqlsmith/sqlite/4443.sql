select  
  (select name from main.t0 limit 1 offset 67)
     as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  case when (21 is not NULL) 
      or (case when ref_0.id is NULL then ref_0.name else ref_0.name end
           is NULL) then ref_0.name else ref_0.name end
     as c4, 
  ref_0.name as c5
from 
  main.t0 as ref_0
where 1
limit 47;
