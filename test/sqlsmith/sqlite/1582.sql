select distinct 
  ref_0.id as c0, 
  (select name from main.t0 limit 1 offset 1)
     as c1, 
  ref_0.id as c2, 
  case when ref_0.id is not NULL then ref_0.name else ref_0.name end
     as c3, 
  46 as c4, 
  ref_0.name as c5, 
  ref_0.id as c6, 
  ref_0.id as c7
from 
  main.t0 as ref_0
where ref_0.name is NULL
limit 64;
