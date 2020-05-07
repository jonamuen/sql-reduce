select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  cast(nullif(ref_0.name,
    cast(coalesce(ref_0.name,
      ref_0.name) as VARCHAR(16))) as VARCHAR(16)) as c3, 
  34 as c4, 
  ref_0.name as c5, 
  ref_0.id as c6, 
  ref_0.id as c7, 
  ref_0.name as c8, 
  56 as c9, 
  ref_0.id as c10, 
  ref_0.id as c11, 
  ref_0.id as c12, 
  ref_0.name as c13, 
  ref_0.name as c14, 
  ref_0.name as c15, 
  case when (1) 
      or (0) then ref_0.id else ref_0.id end
     as c16, 
  ref_0.id as c17, 
  ref_0.name as c18
from 
  main.t0 as ref_0
where 1
limit 81;
