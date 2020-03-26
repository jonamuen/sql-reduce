select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  ref_0.name as c2
from 
  main.t0 as ref_0
where ((0) 
    and (ref_0.name is not NULL)) 
  and (cast(coalesce(ref_0.name,
      cast(null as VARCHAR(16))) as VARCHAR(16)) is NULL)
limit 187;
