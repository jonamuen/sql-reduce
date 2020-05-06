select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  cast(coalesce(ref_0.id,
    ref_0.id) as INT) as c3, 
  ref_0.name as c4, 
  75 as c5, 
  ref_0.name as c6, 
  94 as c7, 
  ref_0.id as c8, 
  ref_0.id as c9, 
  ref_0.name as c10, 
  ref_0.name as c11, 
  ref_0.id as c12, 
  ref_0.name as c13, 
  ref_0.id as c14
from 
  main.t0 as ref_0
where (select id from main.t0 limit 1 offset 67)
     is NULL
limit 115;
