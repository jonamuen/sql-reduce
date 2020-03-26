select  
  ref_0.name as c0, 
  cast(nullif(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  case when ref_0.id is not NULL then ref_0.id else ref_0.id end
     as c5, 
  ref_0.name as c6, 
  ref_0.id as c7, 
  ref_0.id as c8, 
  ref_0.id as c9, 
  ref_0.name as c10, 
  38 as c11, 
  ref_0.name as c12
from 
  main.t0 as ref_0
where (ref_0.id is NULL) 
  and (ref_0.id is NULL)
limit 41;
