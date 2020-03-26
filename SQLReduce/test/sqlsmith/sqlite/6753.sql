select  
  case when ref_0.name is NULL then ref_0.id else ref_0.id end
     as c0
from 
  main.t0 as ref_0
where ref_0.name is NULL;
