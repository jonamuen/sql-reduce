select  
  ref_0.name as c0, 
  cast(nullif(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c1, 
  ref_0.id as c2, 
  ref_0.id as c3, 
  (select id from main.t0 limit 1 offset 2)
     as c4, 
  ref_0.id as c5, 
  ref_0.name as c6, 
  ref_0.name as c7, 
  ref_0.id as c8, 
  ref_0.id as c9, 
  ref_0.id as c10
from 
  main.t0 as ref_0
where ref_0.id is not NULL;
