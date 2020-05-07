select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  cast(nullif((select name from main.t0 limit 1 offset 3)
      ,
    ref_0.name) as VARCHAR(16)) as c2
from 
  main.t0 as ref_0
where 0
limit 71;
