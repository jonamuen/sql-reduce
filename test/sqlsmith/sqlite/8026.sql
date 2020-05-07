select  
  case when ref_0.name is not NULL then ref_0.name else ref_0.name end
     as c0, 
  ref_0.id as c1
from 
  main.t0 as ref_0
where ref_0.name is not NULL;
