select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  cast(nullif(28,
    54) as INTEGER) as c2, 
  cast(coalesce(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c3, 
  ref_0.id as c4, 
  ref_0.name as c5, 
  (select name from main.t0 limit 1 offset 5)
     as c6, 
  ref_0.name as c7
from 
  main.t0 as ref_0
where 1
limit 135;
