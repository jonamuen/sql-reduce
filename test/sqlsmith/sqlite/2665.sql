select  
  ref_0.name as c0, 
  ref_0.id as c1
from 
  main.t0 as ref_0
where case when ref_0.id is NULL then ref_0.id else ref_0.id end
     is not NULL
limit 69;
