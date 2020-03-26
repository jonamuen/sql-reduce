select  
  17 as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.id as c3, 
  ref_0.name as c4, 
  ref_0.id as c5, 
  ref_0.id as c6
from 
  main.t0 as ref_0
where cast(coalesce(ref_0.name,
    ref_0.name) as VARCHAR(16)) is NULL
limit 170;
