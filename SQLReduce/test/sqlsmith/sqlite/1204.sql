select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  case when cast(nullif(ref_0.id,
        ref_0.id) as INT) is not NULL then ref_0.id else ref_0.id end
     as c2, 
  ref_0.id as c3
from 
  main.t0 as ref_0
where 1
limit 59;
