select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  cast(nullif(ref_0.id,
    ref_0.id) as INT) as c5, 
  ref_0.name as c6, 
  ref_0.id as c7, 
  ref_0.id as c8, 
  ref_0.id as c9, 
  ref_0.id as c10, 
  ref_0.id as c11, 
  ref_0.id as c12, 
  ref_0.id as c13
from 
  main.t0 as ref_0
where (ref_0.id is NULL) 
  and (ref_0.id is not NULL)
limit 165;
