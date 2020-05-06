select  
  (select name from main.t0 limit 1 offset 3)
     as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.name as c3
from 
  main.t0 as ref_0
where (0) 
  or ((1) 
    or (1))
limit 173;
