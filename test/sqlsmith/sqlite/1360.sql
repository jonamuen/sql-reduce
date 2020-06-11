select  
  ref_0.name as c0, 
  (select name from main.t0 limit 1 offset 6)
     as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  case when (((((ref_0.name is NULL) 
              and (ref_0.name is NULL)) 
            and (ref_0.id is not NULL)) 
          or (ref_0.name is not NULL)) 
        or (0)) 
      or (1) then ref_0.name else ref_0.name end
     as c4, 
  ref_0.id as c5
from 
  main.t0 as ref_0
where 0
limit 67;
