select  
  ref_0.id as c0, 
  ref_0.id as c1
from 
  main.t0 as ref_0
where (ref_0.name is not NULL) 
  and ((ref_0.id is NULL) 
    and ((ref_0.name is not NULL) 
      and (1)))
limit 106;
