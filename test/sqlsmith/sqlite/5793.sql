select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  cast(coalesce(ref_0.id,
    ref_0.id) as INT) as c3, 
  ref_0.id as c4, 
  ref_0.name as c5, 
  ref_0.name as c6, 
  case when (0) 
      and (cast(coalesce(ref_0.id,
          ref_0.id) as INT) is NULL) then ref_0.id else ref_0.id end
     as c7, 
  ref_0.name as c8, 
  ref_0.id as c9, 
  ref_0.name as c10
from 
  main.t0 as ref_0
where 1;
