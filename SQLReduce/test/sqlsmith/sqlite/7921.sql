select  
  100 as c0, 
  ref_0.id as c1, 
  ref_0.id as c2, 
  cast(coalesce((select name from main.t0 limit 1 offset 25)
      ,
    ref_0.name) as VARCHAR(16)) as c3, 
  35 as c4, 
  ref_0.id as c5
from 
  main.t0 as ref_0
where ref_0.name is not NULL
limit 152;
