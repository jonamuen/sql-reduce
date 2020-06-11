select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.id as c2
from 
  main.t0 as ref_0
where (cast(coalesce(ref_0.id,
      ref_0.id) as INT) is NULL) 
  and (ref_0.id is not NULL);
