select  
  ref_0.id as c0
from 
  main.t0 as ref_0
where cast(coalesce(ref_0.id,
    cast(nullif(ref_0.id,
      ref_0.id) as INT)) as INT) is NULL
limit 75;
