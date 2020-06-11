select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  ref_0.name as c4, 
  case when ref_0.name is not NULL then ref_0.id else ref_0.id end
     as c5, 
  ref_0.name as c6, 
  (select name from main.t0 limit 1 offset 6)
     as c7, 
  (select name from main.t0 limit 1 offset 1)
     as c8, 
  ref_0.id as c9, 
  71 as c10, 
  ref_0.name as c11, 
  ref_0.id as c12, 
  ref_0.name as c13, 
  ref_0.name as c14, 
  case when ref_0.name is NULL then cast(coalesce(ref_0.name,
      ref_0.name) as VARCHAR(16)) else cast(coalesce(ref_0.name,
      ref_0.name) as VARCHAR(16)) end
     as c15
from 
  main.t0 as ref_0
where ref_0.name is NULL
limit 132;
