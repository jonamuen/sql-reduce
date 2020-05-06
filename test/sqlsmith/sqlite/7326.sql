select  
  34 as c0, 
  cast(coalesce((select id from main.t0 limit 1 offset 1)
      ,
    ref_0.id) as INT) as c1, 
  ref_0.name as c2
from 
  main.t0 as ref_0
where 0
limit 54;
