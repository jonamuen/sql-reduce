select  
  ref_0.id as c0, 
  cast(coalesce(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c1
from 
  main.t0 as ref_0
where (ref_0.name is not NULL) 
  or (0)
limit 168;
