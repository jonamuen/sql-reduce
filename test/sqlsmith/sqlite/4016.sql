select  
  28 as c0, 
  ref_0.id as c1
from 
  main.t0 as ref_0
where ((ref_0.id is NULL) 
    or (ref_0.name is NULL)) 
  and (ref_0.name is not NULL)
limit 150;
