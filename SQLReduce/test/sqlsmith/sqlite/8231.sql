select  
  (select id from main.t0 limit 1 offset 4)
     as c0, 
  case when (0) 
      and ((select name from main.t0 limit 1 offset 4)
           is NULL) then ref_0.name else ref_0.name end
     as c1, 
  ref_0.name as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  84 as c5
from 
  main.t0 as ref_0
where (ref_0.id is not NULL) 
  and (ref_0.name is NULL)
limit 62;
