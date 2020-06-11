select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  4 as c2, 
  ref_0.name as c3, 
  cast(coalesce(ref_0.id,
    ref_0.id) as INT) as c4
from 
  main.t0 as ref_0
where ref_0.name is NULL
limit 120;
