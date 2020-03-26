select  
  ref_0.name as c0, 
  ref_0.id as c1
from 
  main.t0 as ref_0
where cast(coalesce(ref_0.name,
    ref_0.name) as VARCHAR(16)) is NULL
limit 127;
