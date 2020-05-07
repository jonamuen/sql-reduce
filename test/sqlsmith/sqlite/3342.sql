select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  cast(coalesce(ref_0.id,
    ref_0.id) as INT) as c3
from 
  main.t0 as ref_0
where (ref_0.name is not NULL) 
  and (((ref_0.name is NULL) 
      or (ref_0.name is not NULL)) 
    and (ref_0.name is not NULL))
limit 149;
