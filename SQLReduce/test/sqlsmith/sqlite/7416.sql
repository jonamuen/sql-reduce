select  
  case when (0) 
      and (ref_0.id is not NULL) then ref_0.id else ref_0.id end
     as c0, 
  ref_0.id as c1
from 
  main.t0 as ref_0
where case when 1 then ref_0.id else ref_0.id end
     is NULL
limit 154;
