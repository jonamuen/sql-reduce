select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  ref_0.id as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  ref_0.name as c6, 
  ref_0.name as c7, 
  case when (0) 
      or (0) then ref_0.id else ref_0.id end
     as c8, 
  ref_0.name as c9, 
  ref_0.name as c10, 
  ref_0.id as c11
from 
  main.t0 as ref_0
where (1) 
  or (case when 0 then ref_0.name else ref_0.name end
       is NULL)
limit 112;
