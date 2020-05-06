select  
  ref_0.id as c0, 
  (select id from main.t0 limit 1 offset 1)
     as c1, 
  case when 63 is not NULL then ref_0.id else ref_0.id end
     as c2
from 
  main.t0 as ref_0
where ref_0.name is not NULL
limit 49;
