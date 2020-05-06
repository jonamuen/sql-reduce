select  
  ref_0.id as c0, 
  ref_0.id as c1
from 
  main.t0 as ref_0
where case when 1 then ref_0.id else ref_0.id end
     is not NULL
limit 129;
