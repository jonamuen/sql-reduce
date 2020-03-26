select  
  case when 0 then ref_0.name else ref_0.name end
     as c0, 
  cast(coalesce(ref_0.id,
    ref_0.id) as INT) as c1, 
  ref_0.id as c2, 
  ref_0.id as c3
from 
  main.t0 as ref_0
where 1
limit 119;
