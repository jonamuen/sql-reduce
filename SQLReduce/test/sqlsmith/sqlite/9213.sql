select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  ref_0.name as c5, 
  cast(nullif(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c6, 
  ref_0.id as c7, 
  ref_0.name as c8, 
  ref_0.name as c9
from 
  main.t0 as ref_0
where (0) 
  or (ref_0.id is not NULL)
limit 109;
