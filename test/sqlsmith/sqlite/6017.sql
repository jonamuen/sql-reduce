select  
  case when ref_0.id is not NULL then ref_0.name else ref_0.name end
     as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  ref_0.name as c4, 
  ref_0.name as c5, 
  ref_0.name as c6, 
  cast(coalesce(cast(nullif(ref_0.id,
      ref_0.id) as INT),
    ref_0.id) as INT) as c7, 
  ref_0.id as c8, 
  ref_0.id as c9
from 
  main.t0 as ref_0
where 1;
