select  
  ref_0.name as c0
from 
  main.t0 as ref_0
where cast(nullif(ref_0.id,
    ref_0.id) as INT) is NULL;
