select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  ref_0.id as c2, 
  case when 0 then ref_0.id else ref_0.id end
     as c3, 
  ref_0.name as c4, 
  ref_0.name as c5, 
  ref_0.id as c6, 
  ref_0.id as c7, 
  cast(nullif(ref_0.id,
    ref_0.id) as INT) as c8, 
  ref_0.id as c9
from 
  main.t0 as ref_0
where 0;
