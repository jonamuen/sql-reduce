select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  case when ref_0.name is NULL then ref_0.name else ref_0.name end
     as c2
from 
  main.t0 as ref_0
where (select name from main.t0 limit 1 offset 45)
     is not NULL
limit 103;
