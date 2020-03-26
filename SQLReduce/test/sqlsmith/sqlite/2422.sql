select  
  (select name from main.t0 limit 1 offset 4)
     as c0, 
  ref_0.id as c1, 
  ref_0.id as c2, 
  ref_0.name as c3, 
  cast(nullif(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c4, 
  ref_0.id as c5, 
  case when 1 then ref_0.name else ref_0.name end
     as c6, 
  ref_0.name as c7, 
  ref_0.id as c8, 
  ref_0.id as c9
from 
  main.t0 as ref_0
where 1;
