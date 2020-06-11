select  
  ref_0.id as c0, 
  case when 1 then 35 else 35 end
     as c1, 
  case when (1) 
      and (ref_0.name is not NULL) then ref_0.name else ref_0.name end
     as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  ref_0.name as c5, 
  ref_0.id as c6, 
  cast(coalesce(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c7, 
  ref_0.name as c8
from 
  main.t0 as ref_0
where ref_0.id is NULL;
