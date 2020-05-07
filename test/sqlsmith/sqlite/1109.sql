select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  ref_0.id as c2, 
  cast(nullif(ref_0.id,
    ref_0.id) as INT) as c3, 
  ref_0.name as c4, 
  ref_0.name as c5
from 
  main.t0 as ref_0
where ((1) 
    and (ref_0.name is not NULL)) 
  and (47 is NULL)
limit 86;
