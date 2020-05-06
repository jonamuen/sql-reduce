select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  case when ref_0.name is NULL then cast(nullif(ref_0.id,
      ref_0.id) as INT) else cast(nullif(ref_0.id,
      ref_0.id) as INT) end
     as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  ref_0.id as c6, 
  ref_0.id as c7, 
  ref_0.id as c8, 
  (select id from main.t0 limit 1 offset 5)
     as c9, 
  ref_0.name as c10, 
  ref_0.id as c11, 
  ref_0.id as c12, 
  case when (ref_0.name is not NULL) 
      and (ref_0.name is NULL) then ref_0.name else ref_0.name end
     as c13, 
  ref_0.name as c14, 
  cast(nullif(cast(nullif(ref_0.name,
      ref_0.name) as VARCHAR(16)),
    ref_0.name) as VARCHAR(16)) as c15, 
  ref_0.id as c16, 
  ref_0.name as c17
from 
  main.t0 as ref_0
where ref_0.id is not NULL
limit 126;
