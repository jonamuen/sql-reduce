select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.id as c3, 
  ref_0.name as c4, 
  ref_0.id as c5, 
  ref_0.name as c6, 
  ref_0.name as c7, 
  ref_0.id as c8, 
  83 as c9, 
  ref_0.id as c10, 
  ref_0.id as c11, 
  ref_0.name as c12, 
  ref_0.id as c13, 
  ref_0.name as c14, 
  ref_0.name as c15, 
  cast(nullif(30,
    cast(nullif(12,
      65) as INTEGER)) as INTEGER) as c16, 
  case when (1) 
      and (ref_0.name is not NULL) then ref_0.name else ref_0.name end
     as c17, 
  ref_0.name as c18
from 
  main.t0 as ref_0
where (ref_0.id is not NULL) 
  and (1)
limit 86;
