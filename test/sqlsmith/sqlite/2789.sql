select  
  (select id from main.t0 limit 1 offset 6)
     as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.name as c3, 
  case when ref_0.id is not NULL then ref_0.id else ref_0.id end
     as c4, 
  ref_0.name as c5
from 
  main.t0 as ref_0
where 1
limit 116;
