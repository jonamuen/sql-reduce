select  
  (select name from main.t0 limit 1 offset 1)
     as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.name as c3
from 
  main.t0 as ref_0
where ((ref_0.id is not NULL) 
    and (ref_0.name is NULL)) 
  and (ref_0.name is NULL)
limit 130;
