select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  cast(nullif(cast(nullif(ref_0.name,
      ref_0.name) as VARCHAR(16)),
    ref_0.name) as VARCHAR(16)) as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  cast(nullif(ref_0.id,
    ref_0.id) as INT) as c5
from 
  main.t0 as ref_0
where ref_0.id is NULL
limit 115;
