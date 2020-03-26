select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  cast(coalesce(ref_0.id,
    cast(coalesce(ref_0.id,
      ref_0.id) as INT)) as INT) as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  90 as c6, 
  (select name from main.t0 limit 1 offset 4)
     as c7, 
  ref_0.name as c8
from 
  main.t0 as ref_0
where ref_0.name is NULL
limit 81;
