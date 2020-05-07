select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  cast(nullif(ref_0.id,
    ref_0.id) as INT) as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  ref_0.id as c6, 
  cast(nullif(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c7
from 
  main.t0 as ref_0
where 1
limit 109;
