select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  ref_0.id as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  ref_0.id as c6, 
  ref_0.id as c7, 
  ref_0.id as c8
from 
  main.t0 as ref_0
where case when 1 then ref_0.id else ref_0.id end
     is NULL
limit 111;