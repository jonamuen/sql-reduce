select  
  cast(coalesce(ref_0.id,
    cast(null as INT)) as INT) as c0, 
  ref_0.id as c1
from 
  main.t0 as ref_0
where ref_0.id is NULL
limit 101;
