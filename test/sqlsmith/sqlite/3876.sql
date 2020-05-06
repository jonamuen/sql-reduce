select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  (select id from main.t0 limit 1 offset 3)
     as c3, 
  ref_0.id as c4, 
  cast(coalesce((select name from main.t0 limit 1 offset 1)
      ,
    cast(nullif(ref_0.name,
      ref_0.name) as VARCHAR(16))) as VARCHAR(16)) as c5, 
  54 as c6, 
  ref_0.id as c7
from 
  main.t0 as ref_0
where 0
limit 133;
