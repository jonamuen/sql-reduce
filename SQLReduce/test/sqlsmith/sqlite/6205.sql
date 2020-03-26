select  
  ref_0.name as c0, 
  (select id from main.t0 limit 1 offset 5)
     as c1, 
  ref_0.name as c2, 
  case when (0) 
      and (0) then ref_0.id else ref_0.id end
     as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  case when ref_0.name is NULL then ref_0.id else ref_0.id end
     as c6, 
  ref_0.id as c7, 
  ref_0.name as c8, 
  ref_0.id as c9, 
  67 as c10, 
  (select id from main.t0 limit 1 offset 6)
     as c11, 
  ref_0.id as c12, 
  ref_0.id as c13, 
  ref_0.id as c14, 
  ref_0.name as c15
from 
  main.t0 as ref_0
where (ref_0.id is NULL) 
  or (ref_0.name is not NULL);
