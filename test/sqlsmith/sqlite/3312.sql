select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  ref_0.name as c6, 
  ref_0.id as c7, 
  cast(coalesce(ref_0.id,
    ref_0.id) as INT) as c8, 
  ref_0.name as c9, 
  ref_0.id as c10
from 
  main.t0 as ref_0
where (ref_0.id is not NULL) 
  and (ref_0.name is NULL);
