select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  ref_0.id as c2
from 
  main.t0 as ref_0
where (ref_0.name is NULL) 
  and (((ref_0.name is not NULL) 
      or (ref_0.id is NULL)) 
    or (ref_0.name is NULL));
