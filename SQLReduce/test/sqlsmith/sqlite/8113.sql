select  
  ref_0.name as c0, 
  cast(nullif(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c1, 
  ref_0.name as c2
from 
  main.t0 as ref_0
where ref_0.name is not NULL;
