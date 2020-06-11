select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  ref_0.name as c5
from 
  main.t0 as ref_0
where (ref_0.id is not NULL) 
  and ((ref_0.name is NULL) 
    and (ref_0.id is not NULL))
limit 95;
