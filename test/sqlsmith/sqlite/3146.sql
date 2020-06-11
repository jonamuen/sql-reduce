select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  case when 1 then ref_0.id else ref_0.id end
     as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  ref_0.id as c6, 
  ref_0.id as c7, 
  ref_0.name as c8, 
  ref_0.name as c9, 
  ref_0.name as c10
from 
  main.t0 as ref_0
where case when (ref_0.name is not NULL) 
      and ((1) 
        and ((1) 
          or (ref_0.id is NULL))) then ref_0.id else ref_0.id end
     is not NULL
limit 31;
