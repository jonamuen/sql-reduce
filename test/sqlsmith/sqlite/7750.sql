select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  cast(nullif(ref_0.id,
    ref_0.id) as INT) as c3, 
  ref_0.name as c4, 
  cast(nullif(ref_0.id,
    ref_0.id) as INT) as c5, 
  ref_0.name as c6, 
  ref_0.id as c7, 
  ref_0.id as c8
from 
  main.t0 as ref_0
where (0) 
  and ((select name from main.t0 limit 1 offset 4)
       is not NULL)
limit 121;
