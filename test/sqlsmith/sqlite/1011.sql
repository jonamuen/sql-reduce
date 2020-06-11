select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.id as c3, 
  ref_0.name as c4, 
  ref_0.id as c5, 
  ref_0.id as c6, 
  ref_0.name as c7, 
  case when case when ref_0.id is not NULL then ref_0.id else ref_0.id end
         is NULL then ref_0.name else ref_0.name end
     as c8
from 
  main.t0 as ref_0
where 1
limit 143;
