select  
  cast(coalesce(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c0, 
  ref_0.id as c1
from 
  main.t0 as ref_0
where cast(nullif(ref_0.id,
    ref_0.id) as INT) is NULL;
