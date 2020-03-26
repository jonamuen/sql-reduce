select  
  ref_0.id as c0, 
  (select name from main.t0 limit 1 offset 4)
     as c1, 
  ref_0.name as c2, 
  ref_0.id as c3, 
  ref_0.name as c4, 
  ref_0.id as c5
from 
  main.t0 as ref_0
where (ref_0.name is not NULL) 
  and ((ref_0.id is not NULL) 
    or ((select name from main.t0 limit 1 offset 1)
         is not NULL))
limit 122;
