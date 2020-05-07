select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  ref_0.name as c4, 
  ref_0.id as c5, 
  cast(coalesce(ref_0.id,
    ref_0.id) as INT) as c6, 
  ref_0.name as c7, 
  ref_0.name as c8
from 
  main.t0 as ref_0
where (ref_0.id is NULL) 
  and ((1) 
    and (0));
