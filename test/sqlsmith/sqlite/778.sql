select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  cast(coalesce(ref_0.id,
    ref_0.id) as INT) as c3, 
  ref_0.id as c4, 
  cast(nullif(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c5, 
  ref_0.id as c6, 
  ref_0.name as c7, 
  ref_0.id as c8, 
  ref_0.name as c9, 
  ref_0.id as c10
from 
  main.t0 as ref_0
where 0
limit 48;
