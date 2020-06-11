select  
  cast(nullif(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c0, 
  ref_0.id as c1, 
  cast(coalesce(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c2, 
  ref_0.name as c3, 
  ref_0.name as c4
from 
  main.t0 as ref_0
where 0
limit 149;
