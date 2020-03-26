select  
  (select name from main.t0 limit 1 offset 3)
     as c0, 
  cast(nullif(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c1, 
  case when (0) 
      or ((1) 
        or (ref_0.name is NULL)) then ref_0.name else ref_0.name end
     as c2
from 
  main.t0 as ref_0
where 1
limit 57;
