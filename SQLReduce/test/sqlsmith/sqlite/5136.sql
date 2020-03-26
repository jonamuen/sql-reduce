select  
  ref_0.name as c0, 
  cast(coalesce(ref_0.id,
    ref_0.id) as INT) as c1, 
  ref_0.id as c2, 
  ref_0.name as c3
from 
  main.t0 as ref_0
where ref_0.id is not NULL
limit 151;
