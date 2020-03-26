select  
  cast(nullif(ref_0.id,
    ref_0.id) as INT) as c0
from 
  main.t0 as ref_0
where ref_0.id is NULL;
