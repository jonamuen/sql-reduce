select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.id as c3, 
  (select id from main.t0 limit 1 offset 69)
     as c4, 
  ref_0.name as c5, 
  case when (1) 
      or ((ref_0.id is not NULL) 
        or (ref_0.id is NULL)) then ref_0.name else ref_0.name end
     as c6
from 
  main.t0 as ref_0
where ref_0.name is NULL;
