select  
  case when ((0) 
        and ((ref_0.id is not NULL) 
          and (ref_0.name is NULL))) 
      or (ref_0.name is not NULL) then ref_0.name else ref_0.name end
     as c0
from 
  main.t0 as ref_0
where ref_0.id is not NULL
limit 81;
