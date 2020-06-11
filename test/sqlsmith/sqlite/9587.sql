select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.name as c3, 
  ref_0.name as c4
from 
  main.t0 as ref_0
where cast(coalesce(ref_0.id,
    ref_0.id) as INT) is not NULL;
