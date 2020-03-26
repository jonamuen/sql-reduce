select  
  ref_0.id as c0, 
  cast(nullif(ref_0.id,
    ref_0.id) as INT) as c1, 
  cast(nullif(ref_0.id,
    ref_0.id) as INT) as c2, 
  75 as c3, 
  ref_0.id as c4, 
  ref_0.id as c5
from 
  main.t0 as ref_0
where ref_0.id is not NULL
limit 75;
