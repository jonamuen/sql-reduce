select  
  ref_0.id as c0, 
  46 as c1, 
  ref_0.id as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  ref_0.id as c6, 
  ref_0.name as c7, 
  ref_0.name as c8, 
  ref_0.name as c9
from 
  main.t0 as ref_0
where case when 1 then ref_0.name else ref_0.name end
     is not NULL
limit 64;
