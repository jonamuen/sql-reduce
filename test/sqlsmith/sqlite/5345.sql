select  
  case when ref_0.id is NULL then (select name from main.t0 limit 1 offset 1)
       else (select name from main.t0 limit 1 offset 1)
       end
     as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  ref_0.name as c5
from 
  main.t0 as ref_0
where 1
limit 148;
