select  
  (select name from main.t0 limit 1 offset 1)
     as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.id as c3, 
  ref_0.id as c4
from 
  main.t0 as ref_0
where (ref_0.name is NULL) 
  and (cast(coalesce(ref_0.name,
      ref_0.name) as VARCHAR(16)) is NULL);
