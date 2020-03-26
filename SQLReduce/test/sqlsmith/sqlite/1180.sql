select  
  ref_0.id as c0, 
  cast(nullif(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c1, 
  ref_0.id as c2, 
  ref_0.id as c3, 
  ref_0.name as c4, 
  ref_0.name as c5, 
  (select id from main.t0 limit 1 offset 1)
     as c6, 
  (select name from main.t0 limit 1 offset 1)
     as c7, 
  ref_0.id as c8, 
  ref_0.id as c9, 
  ref_0.name as c10, 
  ref_0.name as c11, 
  ref_0.id as c12, 
  82 as c13, 
  ref_0.id as c14
from 
  main.t0 as ref_0
where 1;
