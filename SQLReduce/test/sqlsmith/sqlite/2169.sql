select  
  case when case when 0 then ref_0.name else ref_0.name end
         is NULL then ref_0.id else ref_0.id end
     as c0, 
  ref_0.name as c1, 
  ref_0.id as c2
from 
  main.t0 as ref_0
where ref_0.id is not NULL
limit 44;
